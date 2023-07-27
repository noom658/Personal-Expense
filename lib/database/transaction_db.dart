import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_flutter_app/models/category_model.dart';
import 'package:project_flutter_app/models/home_model.dart';
import 'package:project_flutter_app/models/index_model.dart';
import 'package:project_flutter_app/models/wallet_model.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class TransactionDB {
  String? dbName;
  TransactionDB({this.dbName});

  Future<Database> openDatabase() async {
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDirectory.path, dbName);

    DatabaseFactory dbFactory = await databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);
    return db;
  }

  Future<List<HomeModel>> loadHomeData() async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store('totaldata');
    var snapshot = await store.find(db);

    List<HomeModel> homeList = <HomeModel>[];
    for (var record in snapshot) {
      homeList.add(HomeModel(
          id: int.parse(record['id'].toString()),
          amount: record['amount'].toString(),
          titleCategory: record['titleCategory'].toString(),
          icon: record['icon'].toString(),
          titleWallet: record['titleWallet'].toString(),
          date: DateTime.parse(record['date'].toString()),
          details: record['details'].toString(),
          typeCategory: record['typeCategory'].toString()));
    }
    homeList.sort((a, b) => b.date!.compareTo(a.date!));
    return homeList;
  }

  Future<int> InsertHomeData(HomeModel statement) async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store('totaldata');
    var keyID = store.add(db, {
      "id": statement.id,
      "amount": statement.amount,
      "titleCategory": statement.titleCategory,
      "icon": statement.icon,
      "titleWallet": statement.titleWallet,
      "date": statement.date!.toIso8601String(),
      "details": statement.details,
      "typeCategory": statement.typeCategory
      // "data": statement.data.toIso8601String() ถ้าเก็บค่า Date ให้ใช้ toIso ด้วย
    });
    db.close();
    return keyID;
  }

  Future UpdateHomeData(HomeModel statement, int index) async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store('totaldata');
    final finder = Finder(filter: Filter.equals('id', index));
    await store.update(
      db,
      {
        "amount": statement.amount,
        "titleCategory": statement.titleCategory,
        "icon": statement.icon,
        "titleWallet": statement.titleWallet,
        "date": statement.date!.toIso8601String(),
        "details": statement.details,
        "typeCategory": statement.typeCategory
      },
      finder: finder,
    );
    db.close();
  }
  Future UpdateNameHomeData(String namewattle, String changename) async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store('totaldata');
    final finder = Finder(filter: Filter.equals('titleWallet', namewattle));
    await store.update(
      db,
      {
        "titleWallet": changename,
      },
      finder: finder,
    );
    db.close();
  }

  Future DeleteHomeData(int index) async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store(
      'totaldata',
    );
    final finder = Finder(filter: Filter.equals('id', index));
    await store.delete(
      db,
      finder: finder,
    );
    db.close();
  }

  Future<List<WalletModel>> loadWalletData() async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store('wallet');
    var snapshot = await store.find(db);

    List<WalletModel> walletList = <WalletModel>[];
    for (var record in snapshot) {
      walletList.add(WalletModel(
        id: int.parse(record['id'].toString()),
        title: record['title'].toString(),
        amount: record['amount'].toString(),
        revenue: record['revenue'].toString(),
        expenses: record['expenses'].toString()
      ));
    }
    return walletList;
  }

  Future<int> InsertWalletData(WalletModel statement) async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store('wallet');
    var keyID = store.add(db, {
      "id": statement.id,
      "title": statement.title,
      "amount": statement.amount,
      "revenue": statement.revenue,
      "expenses": statement.expenses,
      // "data": statement.data.toIso8601String() ถ้าเก็บค่า Date ให้ใช้ toIso ด้วย
    });
    db.close();
    return keyID;
  }

  Future UpdateWalletData(WalletModel statement, int index) async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store('wallet');
    final finder = Finder(filter: Filter.equals('id', index));
    await store.update(
      db,
      {
        "title": statement.title,
        "amount": statement.amount,
        "revenue": statement.revenue,
        "expenses": statement.expenses,
      },
      finder: finder,
    );
    db.close();
  }

  Future DeleteWalletData(int index) async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store(
      'wallet',
    );
    final finder = Finder(filter: Filter.equals('id', index));
    await store.delete(
      db,
      finder: finder,
    );
    db.close();
  }

  Future<List<indexModel>> loadIndex() async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store('index');
    var snapshot = await store.find(db);

    List<indexModel> indexlist = <indexModel>[];
    for (var record in snapshot) {
      indexlist.add(indexModel(
        id: int.parse(record['id'].toString()),
      ));
    }
    return indexlist;
  }

  Future<int> addIndex() async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store('index');
    var keyID = store.add(db, {
      "id": 0,
    });
    db.close();
    return keyID;
  }

  Future UpdateIndex(int index) async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store('index');
    await store.update(
      db,
      {
        "id": index,
      },
    );
    db.close();
  }
}
