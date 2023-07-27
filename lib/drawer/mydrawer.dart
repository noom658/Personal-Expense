import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_flutter_app/models/category_model.dart';
import 'package:project_flutter_app/providers/category_provider.dart';
import 'package:project_flutter_app/providers/wallet_provider.dart';
import 'package:project_flutter_app/screens/add_item.dart';
import 'package:project_flutter_app/screens/add_wallet.dart';
import 'package:project_flutter_app/screens/calculate.dart';
import 'package:project_flutter_app/screens/category.dart';
import 'package:project_flutter_app/screens/edit_select_category.dart';
import 'package:project_flutter_app/screens/home_screen.dart';
import 'package:project_flutter_app/screens/select_category.dart';
import 'package:project_flutter_app/screens/select_wallet.dart';
import 'package:project_flutter_app/screens/wallet.dart';
import 'package:provider/provider.dart';

class mainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, WalletProvider provider, child) {
      return Drawer(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.green,
                  child: Container(
                    margin: EdgeInsets.only(top: 50),
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            child: Text(
                              provider.wallets.length.toString(), 
                              style: TextStyle(color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(width: 20,),
                          Text('บัญชี',style: TextStyle(color: Colors.white, fontSize: 50)),
                        ],
                      ),
                    ),
                  ),
                ),
                TabMenu("หน้าแรก", Icons.people_alt_rounded, Colors.blue,
                    context, 0),
                Divider(
                  color: Colors.grey,
                ),
                TabMenu("บัญชี", Icons.account_balance_wallet_rounded,
                    Colors.cyan, context, 7),
                Divider(
                  color: Colors.grey,
                ),
                TabMenu("หมวดหมู่", Icons.grid_view_rounded, Colors.orange,
                    context, 8),
                Divider(
                  color: Colors.grey,
                ),
                // TabMenu("เครื่องคิดเลข", Icons.calculate_rounded,
                //     Colors.pinkAccent, context, 9),
                // Divider(
                //   color: Colors.grey,
                // ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Divider(
                  color: Colors.grey,
                ),
                TabMenu(
                    "ออกจากระบบ", Icons.logout_rounded, Colors.red, context, 3)
              ],
            )
          ],
        ),
      );
    });
  }
}

Widget TabMenu(
    String text, IconData icon, Color color, BuildContext context, int index) {
  return ListTile(
      leading: Icon(
        icon,
        color: color,
        size: 45,
      ),
      title: Text(
        text,
        style: TextStyle(
          fontSize: 30,
        ),
        textAlign: TextAlign.start,
      ),
      onTap: () {
        selectedMenu(context, index);
      });
}

void selectedMenu(BuildContext context, int index) {
  switch (index) {
    case 0:
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return HomeScreen();
      }));
      break;
    case 1:
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return SelectWallet();
      }));
      break;
    case 2:
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return SelectCategory();
      }));
      break;
    case 3:
      SystemNavigator.pop();
      break;
    case 4:
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Add_Item();
      }));
      break;
    case 5:
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return addWallet();
      }));
      break;
    case 6:
      Navigator.pop(context);
      break;
    case 7:
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return wallet();
      }));
      break;
    case 8:
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return AllCategory();
      }));
      break;
    // case 9:
    //   Navigator.push(context, MaterialPageRoute(builder: (context) {
    //     return Calculator();
    //   }));
    //   break;
  }
}
