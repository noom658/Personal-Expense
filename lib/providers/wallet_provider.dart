import 'package:flutter/foundation.dart';
import 'package:project_flutter_app/database/transaction_db.dart';
import 'package:project_flutter_app/models/wallet_model.dart';

class WalletProvider with ChangeNotifier {
  List<WalletModel> wallets = [
    
  ];
  void initData() async{
    var db = TransactionDB(dbName: 'transactions.db');
    wallets = await db.loadWalletData();
    notifyListeners();
  }
  void addWallet(WalletModel statement) async{
    var db = TransactionDB(dbName: 'transactions.db');
    await db.InsertWalletData(statement);
    wallets = await db.loadWalletData();
    // wallets.add(statement);
    notifyListeners();
  }

  void editWallet(WalletModel statement, int index) async{
    var db = TransactionDB(dbName: 'transactions.db');
    await db.UpdateWalletData(statement, index);
    wallets = await db.loadWalletData();
    // wallets[index] = statement;
    notifyListeners();
  }
  
  void deleteWallet(int index) async{
    var db = TransactionDB(dbName: 'transactions.db');
    await db.DeleteWalletData(index);
    wallets = await db.loadWalletData();
    // wallets.removeAt(index);
    notifyListeners();
  }
}
