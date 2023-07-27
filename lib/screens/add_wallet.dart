import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get_it/get_it.dart';
import 'package:project_flutter_app/models/wallet_model.dart';
import 'package:project_flutter_app/providers/index_provider.dart';
import 'package:project_flutter_app/providers/wallet_provider.dart';
import 'package:project_flutter_app/screens/home_screen.dart';
import 'package:provider/provider.dart';

class addWallet extends StatelessWidget {
  // WalletRepository _walletRepository = GetIt.I.get();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _amountcontroller = TextEditingController();
  final _titlecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
      body: Consumer2(builder: (context, IndexProvider indexprovider, WalletProvider provider, child) {
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
                          labelText: "ยอดเงินรวม",
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
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: RaisedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          var titile = _titlecontroller.text;
                          var amount = double.parse(_amountcontroller.text);
                          WalletModel statement = WalletModel(
                            id: indexprovider.indexdata[0].id,
                            title: titile,
                            amount: amount.toString(),
                            revenue: '0.00',
                            expenses: '0.00',
                          );
                          indexprovider.editWallet(int.parse(indexprovider.indexdata[0].id.toString())  + 1);
                          provider.addWallet(statement);
                          Navigator.pop(context);
                        }
                      },
                      color: Colors.greenAccent[400],
                      child: Text(
                        "บันทึก",
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
          ),
        );
      }),
    );
  }
}
