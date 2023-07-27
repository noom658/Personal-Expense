import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:project_flutter_app/Drawer/mydrawer.dart';
import 'package:project_flutter_app/models/home_model.dart';
import 'package:project_flutter_app/models/wallet_model.dart';
import 'package:project_flutter_app/providers/home_provider.dart';
import 'package:project_flutter_app/providers/index_provider.dart';
import 'package:project_flutter_app/providers/wallet_provider.dart';

import 'package:project_flutter_app/screens/edit_item.dart';
import 'package:project_flutter_app/widget/pie_chart.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

changeData(String data) {
  Maindata = data;
}

DateTime? _date;
String? Maindata;
double revenue = 0;
double expenses = 0;

class _HomeScreenState extends State<HomeScreen> {
  @override
  var scaffoldKey = GlobalKey<ScaffoldState>();
  Color? firstcolor = Colors.greenAccent[400];
  @override
  Widget build(BuildContext context) {
    double screen = MediaQuery.of(context).size.width;
    return Consumer3(builder: (context, IndexProvider indexlist,
        WalletProvider walletprovider, HomeProvider provider, child) {
      // IndexProvider indexlist
      walletprovider.initData();
      // provider.editDataChart();
      provider.initData();
      // provider.sortData();
      if (indexlist.indexdata.length <= 0) {
        indexlist.addIndex();
      } else {
        indexlist.initData();
      }
      if (walletprovider.wallets.length > 0) {
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
              "บัญชี เงินสด",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            centerTitle: true,
          ),
          body: Stack(
            children: [
              ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: walletprovider.wallets.length,
                  itemBuilder: (context, int index) {
                    WalletModel data = walletprovider.wallets[index];
                    return Stack(
                      children: [
                        GestureDetector(
                          child: Container(
                            width: screen * 0.5,
                            height: 60,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey, width: 2))),
                            child: Center(
                                child: Column(
                              children: [
                                Text(
                                  data.title.toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(NumberFormat('#,###.##').format(
                                        double.parse(data.amount.toString())) +
                                    " บาท"),
                              ],
                            )),
                          ),
                          onTap: () {
                            setState(() {
                              revenue = double.parse(data.revenue.toString());
                              expenses = double.parse(data.expenses.toString());
                              var indexwall = index;
                              provider.editindexwallet(indexwall);
                              Maindata = data.title.toString();
                            });
                          },
                        ),
                      ],
                    );
                  }),
              Container(
                margin: EdgeInsets.only(top: 120),
                height: 100,
                child: PieChart(
                  PieChartData(
                    borderData: FlBorderData(show: false),
                    sectionsSpace: 0,
                    centerSpaceRadius: 40,
                    sections: provider.editDataChart(revenue, expenses),
                  ),
                ),
              ),
              // PieChartWidget(),
              Container(
                margin: EdgeInsets.only(top: 220),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.label,
                          color: Colors.blue,
                          size: 30,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'รายรับ',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.label,
                          color: Colors.red,
                          size: 30,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'รายจ่าย',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                // margin: EdgeInsets.only(bottom: 60, top: 60),
                margin: EdgeInsets.only(bottom: 60, top: 300),
                child: ListView.builder(
                    itemCount: provider.totaldata.length,
                    itemBuilder: (context, int index) {
                      HomeModel data = provider.totaldata[index];
                      return checkData(context, data, index);
                      // return formData(
                      //     data.date!, data.amount!, data.titleCategory!);
                    }),
              ),
              buttomsubmit(context, "เพิ่มรายการ", 4)
            ],
          ),
        );
      } else {
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
              "บัญชี เงินสด",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            centerTitle: true,
          ),
          body: Center(
            child: Container(
              child: Text(
                'กรุณาเพิ่มบัญชี',
                style: TextStyle(fontSize: 50),
              ),
            ),
          ),
        );
      }
    });
  }
}

Widget checkData(BuildContext context, HomeModel data, int index) {
  if (Maindata == data.titleWallet) {
    var provider = Provider.of<HomeProvider>(context, listen: false);
    // if(data.typeCategory == 'รายรับ'){
    //   provider.editrevenue(double.parse(data.amount.toString()) );
    // }
    // else if(data.typeCategory == 'รายจ่าย'){
    //   provider.expenses = provider.expenses + double.parse(data.amount.toString());
    // }
    return GestureDetector(
      onTap: () {
        // homeprovider.sortReturnData();
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Edit_Item(
            data: data,
            index: index,
          );
        }));
      },
      child: Container(
        child: Column(
          children: [
            // รายการที่ 1
            Container(
              height: 60,
              decoration: BoxDecoration(color: data.typeCategory == 'รายรับ' ? Colors.blue : Colors.red),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    // วันที่
                    Row(
                      children: [
                        Text(
                          DateFormat('dd').format(data.date!),
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(DateFormat.EEEE().format(data.date!),
                                style: TextStyle(color: Colors.white)),
                            Text(
                                DateFormat.MMMM().format(data.date!) +
                                    " " +
                                    DateFormat.y().format(data.date!),
                                style: TextStyle(
                                  color: Colors.white,
                                ))
                          ],
                        ),
                        // Text(provider.revenue.toString()),
                        // Text(test.toString()),
                      ],
                    ),
                    // ลูกศรด้านท้าย
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            // รายรับ
            Container(
              decoration: BoxDecoration(color: Colors.grey[200] ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(IconData(int.parse(data.icon.toString()),
                        fontFamily: 'MaterialIcons')),
                    Text(data.details == ''
                        ? data.titleCategory!
                        : data.details!),
                    Expanded(
                      child: Text(
                        data.amount!,
                        textAlign: TextAlign.right,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  return Container();
}

Widget buttomsubmit(BuildContext context, String title, int index) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      SizedBox(
        width: double.infinity,
        height: 60,
        child: RaisedButton(
          onPressed: () {
            selectedMenu(context, index);
          },
          color: Colors.greenAccent[400],
          child: Text(
            title,
            style: TextStyle(
                fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      )
    ],
  );
}

// Widget formData(DateTime date, String amount, String titleCate) {
//   return Container(
//     child: Column(
//       children: [
//         // รายการที่ 1
//         Container(
//           height: 60,
//           decoration: BoxDecoration(color: Colors.blue),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Stack(
//               children: [
//                 // วันที่
//                 Row(
//                   children: [
//                     Text(DateFormat('dd').format(date)),
//                     SizedBox(
//                       width: 20,
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(DateFormat.EEEE().format(date)),
//                         Text(DateFormat.MMMM().format(date) +
//                             " " +
//                             DateFormat.y().format(date))
//                       ],
//                     ),
//                   ],
//                 ),
//                 // ลูกศรด้านท้าย
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Icon(Icons.arrow_forward_ios),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//         // รายรับ
//         Container(
//           decoration: BoxDecoration(color: Colors.blue[100]),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Text(titleCate),
//                 Expanded(
//                   child: Text(
//                     amount,
//                     textAlign: TextAlign.right,
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }
