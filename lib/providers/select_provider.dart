import 'package:flutter/foundation.dart';
import 'package:project_flutter_app/models/category_model.dart';
import 'package:project_flutter_app/models/select_model.dart';
import 'package:project_flutter_app/providers/category_provider.dart';

class SelectProvider with ChangeNotifier{
  List<SelectModel> dataSelect = [
    SelectModel(indexCategory: 0, indexWallet: 0)
  ];
  List<CategoryModel> typeData = CategoryProvider().revenue;
  void editCate(List<CategoryModel> type, int category){
    dataSelect[0].indexCategory = category;
    typeData = type;
    notifyListeners();
  }
  void editWall(int wallet){
    dataSelect[0].indexWallet = wallet;
    notifyListeners();
  }

  void first(){
    dataSelect[0].indexCategory = 0;
    dataSelect[0].indexWallet = 0;
    List<CategoryModel> typeData = CategoryProvider().revenue;
    notifyListeners();
  }
}