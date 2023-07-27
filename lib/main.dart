import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:project_flutter_app/providers/category_provider.dart';
import 'package:project_flutter_app/providers/home_provider.dart';
import 'package:project_flutter_app/providers/index_provider.dart';
import 'package:project_flutter_app/providers/select_provider.dart';
import 'package:project_flutter_app/providers/wallet_provider.dart';
import 'package:project_flutter_app/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  Intl.defaultLocale = "th";
  initializeDateFormatting();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return CategoryProvider();
        }),
        ChangeNotifierProvider(create: (context) {
          return WalletProvider();
        }),
        ChangeNotifierProvider(create: (context) {
          return SelectProvider();
        }),
        ChangeNotifierProvider(create: (context) {
          return HomeProvider();
        }),
        ChangeNotifierProvider(create: (context) {
          return IndexProvider();
        })
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.greenAccent[400],
        ),
        home: HomeScreen(),
      ),
    );
  }
}
