import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_flutter_app/Drawer/mydrawer.dart';
import 'package:project_flutter_app/models/wallet_model.dart';
import 'package:project_flutter_app/providers/wallet_provider.dart';
import 'package:project_flutter_app/screens/add_wallet.dart';
import 'package:project_flutter_app/screens/edit_wallet.dart';
import 'package:project_flutter_app/screens/home_screen.dart';
import 'package:provider/provider.dart';

class wallet extends StatefulWidget {
  @override
  _walletState createState() => _walletState();
}

class _walletState extends State<wallet> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<WalletProvider>(context, listen: false).initData();
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: mainDrawer(),
      appBar: AppBar(
        leading: IconButton(
          iconSize: 30,
          color: Colors.white,
          icon: Icon(Icons.view_list_rounded),
          onPressed: () {
            scaffoldKey.currentState!.openDrawer();
          },
        ),
        title: Text(
          "บัญชี",
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Consumer(builder: (context, WalletProvider provider, child) {
        return Stack(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 60),
              child: ListView.builder(
                  itemCount: provider.wallets.length,
                  itemBuilder: (context, int index) {
                    WalletModel data = provider.wallets[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return editWallet(
                            title: data.title,
                            amount: data.amount,
                            index: index,
                          );
                        }));
                      },
                      child: Card(
                        elevation: 5,
                        child: Row(
                          children: [
                            Icon(
                              Icons.savings_outlined,
                              color: Colors.pink,
                              size: 40,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              children: [
                                Text(
                                  data.title.toString(),
                                  style: TextStyle(fontSize: 30),
                                ),
                                Text(NumberFormat('#,###.##').format(
                                        double.parse(data.amount.toString())) +
                                    " บาท")
                              ],
                            ),
                            Expanded(child: Container()),
                            Icon(Icons.arrow_forward_ios, size: 40,),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            buttomsubmit(context, "เพิ่มบัญชี", 5)
          ],
        );
      }),
    );
  }
}
