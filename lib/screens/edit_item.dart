import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_flutter_app/Drawer/mydrawer.dart';
import 'package:project_flutter_app/models/category_model.dart';
import 'package:project_flutter_app/models/home_model.dart';
import 'package:project_flutter_app/models/select_model.dart';
import 'package:project_flutter_app/models/wallet_model.dart';
import 'package:project_flutter_app/providers/category_provider.dart';
import 'package:project_flutter_app/providers/home_provider.dart';
import 'package:project_flutter_app/providers/select_provider.dart';
import 'package:project_flutter_app/providers/wallet_provider.dart';
import 'package:project_flutter_app/screens/edit_select_category.dart';
import 'package:project_flutter_app/screens/edit_select_wallet.dart';
import 'package:project_flutter_app/screens/home_screen.dart';
import 'package:provider/provider.dart';

class Edit_Item extends StatefulWidget {
  HomeModel? data;
  int index;
  Edit_Item({this.data, required this.index});
  @override
  _Edit_ItemState createState() => _Edit_ItemState(data: data, index: index);
}

class _Edit_ItemState extends State<Edit_Item> {
  HomeModel? data;
  int index;
  _Edit_ItemState({this.data, required this.index});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  final _amountcontroller = TextEditingController();
  final _titlecontroller = TextEditingController();
  DateTime? _dateTime;
  DateTime? _dateTime2;
  String? detail;
  String? amount;
  @override
  Widget build(BuildContext context) {
    double screen = MediaQuery.of(context).size.width;
    detail = data!.details.toString();
    amount = data!.amount.toString();
    _titlecontroller.text = detail.toString();
    _amountcontroller.text = amount.toString();
    _dateTime = data!.date;
    return Consumer3(builder: (context, HomeProvider homeprovider,
        WalletProvider walletprovider, SelectProvider provider, child) {
      // homeprovider.sortData();
      return Form(
        key: formKey,
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                iconSize: 30,
                color: Colors.white,
                icon: Icon(Icons.arrow_back_rounded),
                onPressed: () {
                  homeprovider.firstCate();
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HomeScreen();
                  }));
                },
              ),
              title: Text(
                "รายการ",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: screen * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextFormField(
                            onChanged: (text) {
                              amount = text;
                            },
                            keyboardType: TextInputType.number,
                            controller: _amountcontroller,
                            validator: (str) {
                              if (str!.isEmpty) {
                                return "กรุณาป้อนยอดเงิน";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "0.00",
                              labelText: "ยอดเงิน",
                              labelStyle: TextStyle(
                                fontSize: 20,
                              ),
                              prefixIcon: Icon(
                                Icons.monetization_on_outlined,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(color: Colors.blue)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 30),
                        child: Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    var indexedit = index;
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return EditSelectCategory(
                                        maindata: data!,
                                        mainindex: indexedit,
                                      );
                                    }));
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                          IconData(
                                              homeprovider.cate[0].icon == ''
                                                  ? int.parse(
                                                      data!.icon.toString())
                                                  : int.parse(homeprovider
                                                      .cate[0].icon
                                                      .toString()),
                                              fontFamily: 'MaterialIcons'),
                                          size: 30),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                          homeprovider.cate[0].title == ''
                                              ? data!.titleCategory.toString()
                                              : homeprovider.cate[0].title
                                                  .toString(),
                                          style: TextStyle(fontSize: 25)),
                                      Icon(Icons.arrow_forward_ios),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            nameItem("หมวดหมู่", Icons.grid_view_rounded),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 30),
                        child: Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  // onTap: () {
                                  //   var indexedit = index;
                                  //   Navigator.push(context,
                                  //       MaterialPageRoute(builder: (context) {
                                  //     return EditSelectWallet(
                                  //       maindata: data!,
                                  //       mainindex: indexedit,
                                  //     );
                                  //   }));
                                  // },
                                  child: Row(
                                    children: [
                                      Icon(Icons.savings_outlined, size: 30),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                          homeprovider.wall[0].title == ''
                                              ? data!.titleWallet.toString()
                                              : homeprovider.wall[0].title
                                                  .toString(),
                                          style: TextStyle(fontSize: 25)),
                                      // Icon(Icons.arrow_forward_ios),
                                      Padding(
                                          padding: EdgeInsets.only(right: 20)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            nameItem(
                                "บัญชี", Icons.account_balance_wallet_outlined),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      GestureDetector(
                        child: Container(
                          margin: EdgeInsets.only(left: 30),
                          decoration: BoxDecoration(color: Colors.white),
                          child: Stack(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                      _dateTime2 == null
                                          ? DateFormat('dd/MM/yy')
                                              .format(_dateTime!)
                                              .toString()
                                          : DateFormat('dd/MM/yy')
                                              .format(_dateTime2!)
                                              .toString(),
                                      style: TextStyle(fontSize: 25))
                                ],
                              ),
                              nameItem("วันที่", Icons.calendar_today_outlined),
                            ],
                          ),
                        ),
                        onTap: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: _dateTime2 == null
                                      ? _dateTime!
                                      : _dateTime2!,
                                  firstDate: DateTime(2001),
                                  lastDate: DateTime(2222))
                              .then((date) {
                            setState(() {
                              _dateTime2 = date!;
                            });
                          });
                        },
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: screen * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextFormField(
                            onChanged: (text) {
                              detail = text;
                            },
                            keyboardType: TextInputType.text,
                            maxLines: 3,
                            controller: _titlecontroller,
                            validator: (str) {
                              if (str!.isEmpty) {
                                _titlecontroller.text = '';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "รายละเอียด",
                              labelStyle: TextStyle(
                                fontSize: 20,
                              ),
                              prefixIcon: Icon(
                                Icons.rate_review_outlined,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(color: Colors.blue)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).viewInsets.bottom)),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 60,
                      child: RaisedButton(
                        onPressed: () {
                          var walletamount = double.parse(walletprovider
                              .wallets[provider.dataSelect[0].indexWallet]
                              .amount
                              .toString());
                          var titleWallet = homeprovider.wall[0].title == ''
                              ? data!.titleWallet
                              : homeprovider.wall[0].title.toString();
                          var amount = double.parse(data!.amount.toString());
                          double revenueWallet = double.parse(walletprovider
                                .wallets[homeprovider.indexwallet].revenue
                                .toString());
                            double expensesWallet = double.parse(walletprovider
                                .wallets[homeprovider.indexwallet].expenses
                                .toString());
                          var indexlist = index;
                          var editWalletamountl;
                          if (data!.typeCategory == 'รายรับ') {
                            editWalletamountl = walletamount - amount;
                            revenueWallet = revenueWallet - amount;
                          } else if (data!.typeCategory == 'รายจ่าย') {
                            editWalletamountl = walletamount + amount;
                            expensesWallet = expensesWallet - amount;
                          }
                          WalletModel walletstatement = WalletModel(
                            title: titleWallet,
                            amount: editWalletamountl.toString(),
                            revenue: revenueWallet.toString(),
                            expenses: expensesWallet.toString(),
                          );
                          walletprovider.editWallet(
                              walletstatement,
                              int.parse(walletprovider
                                  .wallets[homeprovider.indexwallet].id
                                  .toString()));
                          homeprovider.deleteTotal(int.parse(
                              homeprovider.totaldata[indexlist].id.toString()));
                          Navigator.pop(context);
                        },
                        color: Colors.red,
                        child: Text(
                          "ลบรายการ",
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      height: 60,
                      child: RaisedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            selectedMenu(context, 0);
                            var walletamount = double.parse(walletprovider
                                .wallets[homeprovider.indexwallet].amount
                                .toString());
                            var editindex = index;
                            var title = _titlecontroller.text;
                            var mainWallet;
                            var old = double.parse(data!.amount.toString());
                            double revenueWallet = double.parse(walletprovider
                                .wallets[homeprovider.indexwallet].revenue
                                .toString());
                            double expensesWallet = double.parse(walletprovider
                                .wallets[homeprovider.indexwallet].expenses
                                .toString());
                            var amount = double.parse(_amountcontroller.text);
                            var titleCategory = homeprovider.cate[0].title == ''
                                ? data!.titleCategory
                                : homeprovider.cate[0].title.toString();
                            var icon = homeprovider.cate[0].icon == ''
                                ? data!.icon
                                : homeprovider.cate[0].icon;
                            var titleWallet = homeprovider.wall[0].title == ''
                                ? data!.titleWallet
                                : homeprovider.wall[0].title.toString();
                            var editWalletamountl;
                            var typecate;
                            if (data!.typeCategory == 'รายรับ') {
                              mainWallet = walletamount - old;
                              revenueWallet = revenueWallet - old;
                            } else if (data!.typeCategory == 'รายจ่าย') {
                              mainWallet = walletamount + old;
                              expensesWallet = expensesWallet - old;
                            }
                            // if (homeprovider.typeedit[0].title == "รายรับ") {
                            //   typecate = 'รายรับ';
                            // } else if (homeprovider.typeedit[0].title ==
                            //     "รายจ่าย") {
                            //   typecate = 'รายจ่าย';
                            // }
                            if (homeprovider.typeedit[0].title == "รายรับ") {
                              typecate = 'รายรับ';
                              editWalletamountl = mainWallet + amount;
                              revenueWallet = revenueWallet + amount;
                            } else if (homeprovider.typeedit[0].title ==
                                "รายจ่าย") {
                              typecate = 'รายจ่าย';
                              editWalletamountl = mainWallet - amount;
                              expensesWallet = expensesWallet + amount;
                            } else {
                              typecate = data!.typeCategory;
                              editWalletamountl = walletamount;
                              revenueWallet = double.parse(walletprovider
                                  .wallets[homeprovider.indexwallet].revenue
                                  .toString());
                              expensesWallet = double.parse(walletprovider
                                  .wallets[homeprovider.indexwallet].expenses
                                  .toString());
                            }
                            WalletModel walletstatement = WalletModel(
                              title: titleWallet,
                              amount: editWalletamountl.toString(),
                              revenue: revenueWallet.toString(),
                              expenses: expensesWallet.toString(),
                            );
                            HomeModel statement = HomeModel(
                              amount: amount.toString(),
                              titleCategory: titleCategory,
                              icon: icon,
                              titleWallet: titleWallet,
                              date: _dateTime2 == null ? _dateTime : _dateTime2,
                              details: title,
                              typeCategory: typecate,
                            );
                            walletprovider.editWallet(
                                walletstatement,
                                int.parse(walletprovider
                                    .wallets[homeprovider.indexwallet].id
                                    .toString()));
                            homeprovider.editTotalData(
                                statement,
                                int.parse(homeprovider.totaldata[editindex].id
                                    .toString()));
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return HomeScreen();
                            }));
                            provider.first();
                          }
                        },
                        color: Colors.greenAccent[400],
                        child: Text(
                          "แก้ไขรายการ",
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            )),
      );
    });
  }
}

Widget nameItem(String text, IconData icon) {
  return Row(
    children: [
      Icon(
        icon,
        color: Colors.orange,
        size: 30,
      ),
      SizedBox(
        width: 8,
      ),
      Text(
        text,
        style: TextStyle(fontSize: 25),
      )
    ],
  );
}

Widget nextPage(String title, IconData icon, String namePage,
    IconData? iconPage, BuildContext context, int index) {
  return Container(
    child: Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                selectedMenu(context, index);
              },
              child: Row(
                children: [
                  Icon(iconPage, size: 30),
                  SizedBox(
                    width: 8,
                  ),
                  Text(namePage, style: TextStyle(fontSize: 25)),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            )
          ],
        ),
        nameItem(title, icon),
      ],
    ),
  );
}
