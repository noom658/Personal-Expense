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
import 'package:project_flutter_app/providers/index_provider.dart';
import 'package:project_flutter_app/providers/select_provider.dart';
import 'package:project_flutter_app/providers/wallet_provider.dart';
import 'package:project_flutter_app/screens/home_screen.dart';
import 'package:provider/provider.dart';

class Add_Item extends StatefulWidget {
  @override
  _Add_ItemState createState() => _Add_ItemState();
}

class _Add_ItemState extends State<Add_Item> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  final _amountcontroller = TextEditingController();
  final _titlecontroller = TextEditingController();

  DateTime? _dateTime;

  @override
  Widget build(BuildContext context) {
    double screen = MediaQuery.of(context).size.width;
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            iconSize: 30,
            color: Colors.white,
            icon: Icon(Icons.arrow_back_rounded),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return HomeScreen();
              }));
            },
          ),
          title: Text(
            "รายการ",
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        body: Consumer4(builder: (context,
            IndexProvider indexprovider,
            HomeProvider homeprovider,
            WalletProvider walletprovider,
            SelectProvider provider,
            child) {
          return Stack(
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
                          keyboardType: TextInputType.number,
                          controller: _amountcontroller,
                          validator: (String? str) {
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
                    nextPage(
                        "หมวดหมู่",
                        Icons.grid_view_rounded,
                        provider.typeData[provider.dataSelect[0].indexCategory]
                            .title
                            .toString(),
                        IconData(
                            int.parse(provider
                                .typeData[provider.dataSelect[0].indexCategory]
                                .icon
                                .toString()),
                            fontFamily: 'MaterialIcons'),
                        // provider.typeData[provider.dataSelect[0].indexCategory]
                        //     .icon,
                        context,
                        2),
                    SizedBox(
                      height: 50,
                    ),
                    nextPage(
                        "บัญชี",
                        Icons.account_balance_wallet_outlined,
                        walletprovider
                            .wallets[provider.dataSelect[0].indexWallet].title
                            .toString(),
                        Icons.savings_outlined,
                        context,
                        1),
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
                                    _dateTime == null
                                        ? DateFormat('dd/MM/yy')
                                            .format(DateTime.now())
                                            .toString()
                                        : DateFormat('dd/MM/yy')
                                            .format(_dateTime!)
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
                                initialDate: _dateTime == null
                                    ? DateTime.now()
                                    : _dateTime!,
                                firstDate: DateTime(2001),
                                lastDate: DateTime(2222))
                            .then((date) {
                          setState(() {
                            _dateTime = date!;
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
                            bottom: MediaQuery.of(context).viewInsets.bottom)),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: RaisedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          selectedMenu(context, 0);
                          var walletamount = double.parse(walletprovider
                              .wallets[provider.dataSelect[0].indexWallet]
                              .amount
                              .toString());
                          var title = _titlecontroller.text;
                          var amount = double.parse(_amountcontroller.text);
                          var titleCategory = provider
                              .typeData[provider.dataSelect[0].indexCategory]
                              .title
                              .toString();
                          var typecate;
                          var revenueWallet = double.parse(walletprovider.wallets[provider.dataSelect[0].indexWallet].revenue.toString());
                          var expensesWallet = double.parse(walletprovider.wallets[provider.dataSelect[0].indexWallet].expenses.toString());
                          if (provider.typeData[0].title == "รายรับ") {
                            typecate = 'รายรับ';
                            revenueWallet = revenueWallet + amount;
                          } else if (provider.typeData[0].title == "รายจ่าย") {
                            typecate = 'รายจ่าย';
                            expensesWallet = expensesWallet + amount;
                          }
                          var icon = provider
                              .typeData[provider.dataSelect[0].indexCategory]
                              .icon;
                          var titleWallet = walletprovider
                              .wallets[provider.dataSelect[0].indexWallet].title
                              .toString();
                          var editWalletamountl;
                          if (provider.typeData.length > 10) {
                            editWalletamountl = walletamount - amount;
                          } else {
                            editWalletamountl = walletamount + amount;
                          }
                          WalletModel walletstatement = WalletModel(
                            title: titleWallet,
                            amount: editWalletamountl.toString(),
                            revenue: revenueWallet.toString(),
                            expenses: expensesWallet.toString(),
                          );
                          HomeModel statement = HomeModel(
                            id: indexprovider.indexdata[0].id,
                            amount: amount.toString(),
                            titleCategory: titleCategory,
                            icon: icon,
                            titleWallet: titleWallet,
                            date:
                                _dateTime == null ? DateTime.now() : _dateTime,
                            details: title,
                            typeCategory: typecate,
                          );
                          walletprovider.editWallet(
                              walletstatement,
                              int.parse(walletprovider
                                  .wallets[provider.dataSelect[0].indexWallet]
                                  .id
                                  .toString()));
                          indexprovider.editWallet(int.parse(
                                  indexprovider.indexdata[0].id.toString()) +
                              1);
                          homeprovider.addTotal(statement);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return HomeScreen();
                          }));
                          provider.first();
                        }
                      },
                      color: Colors.greenAccent[400],
                      child: Text(
                        "บันทึกรายการ",
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
          );
        }),
      ),
    );
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
    margin: EdgeInsets.only(left: 30),
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
