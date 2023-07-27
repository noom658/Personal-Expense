import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_flutter_app/models/wallet_model.dart';
import 'package:project_flutter_app/providers/home_provider.dart';
import 'package:project_flutter_app/providers/wallet_provider.dart';
import 'package:provider/provider.dart';

class editWallet extends StatefulWidget {
  String? title;
  String? amount;
  int index;
  editWallet({this.title, this.amount, required this.index});
  @override
  _editWalletState createState() =>
      _editWalletState(title: title, amount: amount, index: index);
}

class _editWalletState extends State<editWallet> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? title;
  String? amount;
  int index;
  _editWalletState({this.title, this.amount, required this.index});
  TextEditingController _amountcontroller = TextEditingController();
  TextEditingController _titlecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _titlecontroller.text = title.toString();
    _amountcontroller.text = amount.toString();
    double screen = MediaQuery.of(context).size.width;
    return Scaffold(
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
      body: Consumer(builder: (context, WalletProvider provider, child) {
        return Form(
          key: formKey,
          child: Stack(
            children: [
              Column(
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
                          title = text;
                        },
                        controller: _titlecontroller,
                        keyboardType: TextInputType.text,
                        validator: (str) {
                          if (str!.isEmpty) {
                            return "กรุณาป้อนชื่อบัญชี";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "ชื่อบัญชี",
                          labelStyle: TextStyle(
                            fontSize: 20,
                          ),
                          prefixIcon: Icon(
                            Icons.account_balance_wallet_outlined,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.blue)),
                        ),
                      ),
                    ),
                  ),
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
                            _amountcontroller.text = "0.00";
                            return null;
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
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: double.infinity,
                    height: 60,
                    child: RaisedButton(
                      onPressed: () {
                        var indexlist = index;
                        provider.deleteWallet(int.parse(provider.wallets[indexlist].id.toString()));
                        Navigator.pop(context);
                      },
                      color: Colors.red,
                      child: Text(
                        "ลบบัญชี",
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
                          var titile = _titlecontroller.text;
                          var amount = double.parse(_amountcontroller.text);
                          var indexlist = index;
                          var namewattle = provider.wallets[indexlist].title;
                          var homeprovider = Provider.of<HomeProvider>(context, listen: false);
                          double revenueWallet = double.parse(provider.wallets[indexlist].revenue.toString());
                          double expensesWallet = double.parse(provider.wallets[indexlist].expenses.toString());
                          WalletModel statement = WalletModel(
                            title: titile,
                            amount: amount.toString(),
                            revenue: revenueWallet.toString(),
                            expenses: expensesWallet.toString(),
                          );
                          homeprovider.editNameWalletTotalData(namewattle!, titile);
                          provider.editWallet(statement, int.parse(provider.wallets[indexlist].id.toString()));
                          Navigator.pop(context);
                        }
                      },
                      color: Colors.greenAccent[400],
                      child: Text(
                        "แก้ไขบัญชี",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
