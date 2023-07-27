import 'package:flutter/cupertino.dart';
import 'package:project_flutter_app/models/category_model.dart';

class HomeModel {
  int? id;
  String? amount;
  String? titleCategory;
  String? icon;
  String? titleWallet;
  DateTime? date;
  String? details;
  String? typeCategory;
  
  HomeModel({this.id, this.amount, this.titleCategory, this.icon, this.titleWallet, this.date, this.details, this.typeCategory});
}

class EditCate {
  String? title;
  String? icon;
  EditCate({this.title, this.icon});
}
class EditWall {
  String? title;
  EditWall({this.title});
}

class DataChart {
  String? title;
  double? percent;
  Color? color;
  DataChart({this.title, this.percent, this.color});
}