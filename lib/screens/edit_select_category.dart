import 'package:flutter/material.dart';
import 'package:project_flutter_app/Drawer/mydrawer.dart';
import 'package:project_flutter_app/models/category_model.dart';
import 'package:project_flutter_app/models/home_model.dart';
import 'package:project_flutter_app/providers/category_provider.dart';
import 'package:project_flutter_app/providers/home_provider.dart';
import 'package:project_flutter_app/providers/select_provider.dart';
import 'package:project_flutter_app/screens/add_item.dart';
import 'package:project_flutter_app/screens/edit_item.dart';
import 'package:project_flutter_app/screens/home_screen.dart';
import 'package:provider/provider.dart';

class EditSelectCategory extends StatefulWidget {
  HomeModel maindata;
  int mainindex;
  
  EditSelectCategory({required this.maindata ,required this.mainindex,});
  @override
  _EditSelectCategoryState createState() => _EditSelectCategoryState(maindata: maindata, mainindex: mainindex,);
  
}

class _EditSelectCategoryState extends State<EditSelectCategory> {
  HomeModel maindata;
  int mainindex;
  
  _EditSelectCategoryState({required this.maindata ,required this.mainindex,});

  List<CategoryModel> typeData = CategoryProvider().revenue;
  Color? firstcolor = Colors.greenAccent[400];
  Color? secondcolor;
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
          "หมวดหมู่",
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Consumer2(
        builder: (context, CategoryProvider provider, HomeProvider selectprovider, child) {
          return Stack(
            children: [
              Row(
                children: [
                  GestureDetector(
                    child: topTap("รายรับ", firstcolor, screen),
                    onTap: () {
                      setState(() {
                        firstcolor = Colors.greenAccent[400];
                        secondcolor = null;
                        typeData = provider.revenue;
                      });
                    },
                  ),
                  GestureDetector(
                    child: topTap("รายจ่าย", secondcolor, screen),
                    onTap: () {
                      setState(() {
                        secondcolor = Colors.greenAccent[400];
                        firstcolor = null;
                        typeData = provider.expenses;
                      });
                    },
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 50),
                child: ListView.builder(
                    itemCount: typeData.length,
                    itemBuilder: (context, int index) {
                      CategoryModel data = typeData[index];
                      return GestureDetector(
                        child: Card(
                          elevation: 5,
                          child: ListTile(
                            leading: Icon(IconData(int.parse(data.icon.toString()), fontFamily: 'MaterialIcons'), color: Colors.orange, size: 40),
                            title: Text(data.title.toString(),style: TextStyle(color: Colors.lightBlueAccent, fontSize: 30, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        onTap: () {
                          int indexmain = mainindex;
                          List<CategoryModel> type = typeData;
                          int indexlist = index;
                          HomeModel datamain = maindata;
                          selectprovider.editCate(type, indexlist);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Edit_Item(data: datamain, index: indexmain,);
                          }));
                        },
                      );
                    }),
              ),
            ],
          );
        },
      ),
    );
  }
}

Widget topTap(String title, Color? colors, double screen) {
  return Container(
    width: screen * 0.5,
    height: 50,
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
            bottom: BorderSide(
                color: colors == null ? Colors.grey : colors,
                width: colors == null ? 2 : 4))),
    child: Center(
        child: Text(
      title,
      style: TextStyle(
        color: colors == null ? Colors.black : colors,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    )),
  );
}
