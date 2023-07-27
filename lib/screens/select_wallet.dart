import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_flutter_app/Drawer/mydrawer.dart';
import 'package:project_flutter_app/models/category_model.dart';
import 'package:project_flutter_app/models/wallet_model.dart';
import 'package:project_flutter_app/providers/category_provider.dart';
import 'package:project_flutter_app/providers/select_provider.dart';
import 'package:project_flutter_app/providers/wallet_provider.dart';
import 'package:project_flutter_app/screens/add_item.dart';
import 'package:project_flutter_app/screens/add_wallet.dart';
import 'package:project_flutter_app/screens/edit_wallet.dart';
import 'package:project_flutter_app/screens/home_screen.dart';
import 'package:provider/provider.dart';

class SelectWallet extends StatefulWidget {
  @override
  _SelectWalletState createState() => _SelectWalletState();
}

class _SelectWalletState extends State<SelectWallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: mainDrawer(),
      appBar: AppBar(
        leading: IconButton(
          iconSize: 30,
          color: Colors.white,
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "บัญชี",
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Consumer2(builder: (context, SelectProvider selectprovider,
          WalletProvider provider, child) {
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
                        int indexlist = index;
                        selectprovider.editWall(index);
                        Navigator.pop(context);
                        // Navigator.push(context, MaterialPageRoute(builder: (context){
                        //     return Add_Item();
                        //   }));
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
                                Text(data.title.toString(),
                                    style: TextStyle(fontSize: 30)),
                                Text(NumberFormat('#,###.##').format(
                                        double.parse(data.amount.toString())) +
                                    " บาท")
                              ],
                            ),
                            Expanded(child: Container()),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 40,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        );
      }),
    );
  }
}
