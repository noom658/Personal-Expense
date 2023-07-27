
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter_app/models/category_model.dart';

class CategoryProvider with ChangeNotifier{
  List <CategoryModel> revenue = [
    CategoryModel(title: "รายรับ", icon: "63469"),
    CategoryModel(title: "ของขวัญ", icon: '57759'),
    CategoryModel(title: "เงินเดือน", icon: '58498'),
    CategoryModel(title: "ยอดขาย", icon: '60366'),
    CategoryModel(title: "โบนัส", icon: '63698'),
    CategoryModel(title: "เงินดอกเบี้ย", icon: '59312'),
    CategoryModel(title: "เงินฝาก", icon: '59312'),
    CategoryModel(title: "อื่นๆ", icon: '63012'),
  ];

  List <CategoryModel> expenses = [
    CategoryModel(title: "รายจ่าย", icon: '58361'),
    CategoryModel(title: "อาหาร", icon: '61513'),
    CategoryModel(title: "ช้อปปิ้ง", icon: '57434'),
    CategoryModel(title: "การเดินทาง", icon: '62559'),
    CategoryModel(title: "การลงทุน", icon: '57534'),
    CategoryModel(title: "บัตรเครดิต", icon: '57759'),
    CategoryModel(title: "การศึกษา", icon: '57584'),
    CategoryModel(title: "ค่าบ้าน", icon: '58152'),
    CategoryModel(title: "ค่าผ่อนรถ", icon: '57864'),
    CategoryModel(title: "ครอบครัว", icon: '63469'),
    CategoryModel(title: "บริจาค", icon: '57662'),
    CategoryModel(title: "ท่องเที่ยว", icon: '63469'),
    CategoryModel(title: "ถอนเงิน", icon: '61918'),
    CategoryModel(title: "ธุรกิจ", icon: '57628'),
    CategoryModel(title: "บันเทิง", icon: '60029'),
    CategoryModel(title: "ประกันภัย", icon: '62634'),
    CategoryModel(title: "สาธารณูปโภค", icon: '62643'),
    CategoryModel(title: "ที่พัก", icon: '59939'),
    CategoryModel(title: "สุขภาพ", icon: '57662'),
    CategoryModel(title: "อื่นๆ", icon: '63012'),
  ];
}