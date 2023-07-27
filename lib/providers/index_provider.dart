import 'package:flutter/foundation.dart';
import 'package:project_flutter_app/database/transaction_db.dart';
import 'package:project_flutter_app/models/index_model.dart';

class IndexProvider with ChangeNotifier{
  List<indexModel> indexdata =[

  ];
  void initData() async{
    var db = TransactionDB(dbName: 'transactions.db');
    indexdata = await db.loadIndex();
    notifyListeners();
  }
  void addIndex() async{
    var db = TransactionDB(dbName: 'transactions.db');
    await db.addIndex();
    indexdata = await db.loadIndex();
    notifyListeners();
  }
  void editWallet(int indexlist) async{
    var db = TransactionDB(dbName: 'transactions.db');
    await db.UpdateIndex(indexlist);
    indexdata = await db.loadIndex();
    // wallets[index] = statement;
    notifyListeners();
  }

}