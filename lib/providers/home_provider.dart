import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_flutter_app/database/transaction_db.dart';
import 'package:project_flutter_app/models/category_model.dart';
import 'package:project_flutter_app/models/home_model.dart';
import 'package:project_flutter_app/providers/category_provider.dart';
import 'package:project_flutter_app/providers/wallet_provider.dart';

class HomeProvider with ChangeNotifier {
  List<HomeModel> totaldata = [
  ];

  List<EditCate> cate = [
    EditCate(title: '', icon: ''),
  ];
  List<EditWall> wall = [
    EditWall(title: ''),
  ];
  List<CategoryModel> typeedit = CategoryProvider().revenue;
  // double revenue = 0;
  // double expenses = 0;
  List<DataChart> dataChart = [
    DataChart(title: 'รายรับ', percent: 0, color: Colors.blue),
    DataChart(title: 'รายจ่าย', percent: 0, color: Colors.red),
  ];
  // void editrevenue(double amount){
  //   revenue = revenue + amount;
  //   editDataChart();
  //   notifyListeners();
  // }
  List<PieChartSectionData> editDataChart(double revenue, double expenses){
    var totle = revenue + expenses;
    var revenuepercent = NumberFormat('###.##').format(revenue / totle * 100);
    var expensespercent = NumberFormat('###.##').format(expenses / totle * 100);
    dataChart[0].percent = double.parse(revenuepercent.toString());
    dataChart[1].percent = double.parse(expensespercent.toString());
    notifyListeners();
    return getSections();
  }
  List<PieChartSectionData> getSections()=> dataChart
  .asMap().map<int, PieChartSectionData>((index, data) {
    final value = PieChartSectionData(
      color: data.color,
      value: data.percent,
      title: '${data.percent}%',
      titleStyle: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
    return MapEntry(index, value);
  }).values.toList();
  // void initData() async{
  //   var db = TransactionDB(dbName: 'transactions.db');
  //   totaldata = await db.loadHomeData();
  //   notifyListeners();
  // }
  int indexwallet = 0;
  void editindexwallet(int x){
    indexwallet = x;
    notifyListeners();
  }
  void initData() async{
    var db = TransactionDB(dbName: 'transactions.db');
    totaldata = await db.loadHomeData();
    notifyListeners();
  }
  void deleteTotal(int index)async{
    var db = TransactionDB(dbName: 'transactions.db');
    await db.DeleteHomeData(index);
    totaldata = await db.loadHomeData();
    // totaldata.removeAt(index);
    notifyListeners();
  }
  void firstCate(){
    cate[0].title = '';
    cate[0].icon = '';
    wall[0].title = '';
    notifyListeners();
  }
   void editTotalData(HomeModel statement, int index) async{
     var db = TransactionDB(dbName: 'transactions.db');
    await db.UpdateHomeData(statement, index);
    totaldata = await db.loadHomeData();
    // totaldata[index] = statement;
    notifyListeners();
  }
   void editNameWalletTotalData(String namewattle, String changename) async{
     var db = TransactionDB(dbName: 'transactions.db');
    await db.UpdateNameHomeData(namewattle, changename);
    totaldata = await db.loadHomeData();
    // totaldata[index] = statement;
    notifyListeners();
  }
  void editCate(List<CategoryModel> type, int indexcate){
    typeedit = type;
    cate[0].title = type[indexcate].title;
    cate[0].icon = type[indexcate].icon;
    notifyListeners();
  }
  void editWall(int indexcate){
    wall[0].title = WalletProvider().wallets[indexcate].title;
    notifyListeners();
  }

  void addTotal(HomeModel statement) async{
    var db = TransactionDB(dbName: 'transactions.db');
    await db.InsertHomeData(statement);
    totaldata = await db.loadHomeData();
    // totaldata.add(statement);
    notifyListeners();
  }

}
