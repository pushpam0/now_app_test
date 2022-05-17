

import 'package:flutter/foundation.dart';
import 'package:now_app_test/model/cart_object.dart';
import 'package:now_app_test/model/product_to_dart_model.dart';
import 'package:now_app_test/services/get_product.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

Future<bool> veryfyEvent() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("login", true);
    ProductToDartModel productToDartModel = await getProDuct();
    print("product value : ${productToDartModel.data!.products![0].prodImage}");

    // Get a location using getDatabasesPath
    final databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'product.db');
    Database database = await openDatabase(path, version: 1);
   /* Database? database = await openDatabase(dbPath, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Test (id INTEGER PRIMARY KEY, Product_Name TEXT, Price TEXT, Unit TEXT, Product_Image TEXT)');
    });*/
    productToDartModel.data!.products!.forEach((element) async {
      // Insert some records in a transaction
      await database.transaction((txn) async {
        int id1 = await txn.rawInsert(
            'INSERT INTO Product(Product_Name, Price, Unit,Product_Image) VALUES("${element.prodName}", "${element.prodPrice}", "100", "${element.prodImage}")');
        print('inserted1: $id1');
      });
    });
  //  await database.close();
  } catch (e) {
    print("Exception");
    return false;
  }
  return true;
}

Future<bool> checkInStatus(int index) async{
  try {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("CHECKIN", true);
    await prefs.setInt("CHECKINSTORE", index);
  }
  catch(e){
    return false;
  }
  return true;
}

Future<bool> insertCheckInStatus(int index) async {
  try {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'checkin.db');
    Database database = await openDatabase(path, version: 1);
    await database.transaction((txn) async {
      int id1 = await txn.rawInsert(
          'INSERT INTO Check_In(IndexValue, Status) VALUES("$index", "true")');
      print('inserted Check_In: $id1');
    });
  //  await database.close();
  }catch(e){
    return false;
  }
  return true;
}

Future<bool> insertCartStatus(productname,int quantity,totalprice,identification) async {
  int? i;
  int? k;
  try {

    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'cart.db');
    Database database = await openDatabase(path, version: 1);
    List<Map> list2 = await database.rawQuery('SELECT * FROM Cart WHERE Identification = ?',['$identification']);

    String path2 = join(databasesPath, 'product.db');
    Database database2 = await openDatabase(path2, version: 1);
    List<Map> list3 = await database2.rawQuery('SELECT * FROM Product WHERE id = ?',[identification]);
    if(list2.isNotEmpty){
     // list[index]["Product_Name"]
      if(int.parse(list2[0]["Quantity"])>quantity){
       i= int.parse(list3[0]["Unit"]);
        k=int.parse(list2[0]["Quantity"]);
      i+=k-quantity;
        int count2 = await database2.rawUpdate(
            'UPDATE Product SET Unit = ? WHERE id = ?',
            ["$i", identification]);
        print('updated: $count2');

        int count = await database.rawUpdate(
            'UPDATE Cart SET Quantity = ? WHERE Identification = ?',
            ["$quantity", "$identification"]);
        print('updated: $count');
        return true;

      }
      else if(int.parse(list2[0]["Quantity"])<quantity){

        int i= int.parse(list3[0]["Unit"]);
        i-=quantity-int.parse(list2[0]["Quantity"]);
        int count2 = await database2.rawUpdate(
            'UPDATE Product SET Unit = ? WHERE id = ?',
            ["$i", identification]);
        print('updated: $count2');

        int count = await database.rawUpdate(
            'UPDATE Cart SET Quantity = ? WHERE Identification = ?',
            ["$quantity", "$identification"]);
        print('updated: $count');
        return true;

      }


    }
    else {
      // var databasesPath = await getDatabasesPath();
      //String path = join(databasesPath, 'cart.db');
      // Database database = await openDatabase(path, version: 1);
      int i= int.parse(list3[0]["Unit"])-quantity;
      int count2 = await database2.rawUpdate(
          'UPDATE Product SET Unit = ? WHERE id = ?',
          ["$i", identification]);


      await database.transaction((txn) async {
        int id1 = await txn.rawInsert(
            'INSERT INTO Cart(Product_Name, Quantity,Total_Price,Identification) VALUES("$productname", "$quantity","$totalprice","$identification")');
        print('inserted Check_In: $id1');
      });
    }
    //  await database.close();
  }catch(e){
    print("some exception while updateng");
    return false;
  }
  return true;
}

Future<bool> deleteCartStatus(id) async {
  try {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'cart.db');
    Database database = await openDatabase(path, version: 1);
    await database
        .rawDelete('DELETE FROM Cart WHERE id = $id');
    //  await database.close();
  }catch(e){
    return false;
  }
  return true;
}

Future<bool> createTableCart() async {
  try {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'cart.db');

    Database? database=   await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE IF NOT EXISTS Cart (id INTEGER PRIMARY KEY,Product_Name TEXT, Quantity TEXT, Total_Price TEXT, Identification TEXT)');
        });

  /*  await database.transaction((txn) async {
      int id1 = await txn.rawInsert(
          'INSERT INTO Cart(Product_Name, Quantity,Total_Price,Identification) VALUES("$index", "true")');
      print('inserted Check_In: $id1');
    });*/
    //  await database.close();
  }catch(e){
    return false;
  }
  return true;
}


Future<bool> CreateTableTest() async {
  try {
    // Get a location using getDatabasesPath
    final databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, 'product.db');
    Database? database= await openDatabase(dbPath, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE IF NOT EXISTS Product (id INTEGER PRIMARY KEY, Product_Name TEXT, Price TEXT, Unit TEXT, Product_Image TEXT)');
        });


  } catch (e) {
    print("Exception");
    return false;
  }
  return true;
}
Future<bool> CreateTableCheckIn() async {
  try {
    // Get a location using getDatabasesPath
    final databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'checkin.db');
    Database? database=  await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE IF NOT EXISTS Check_In (id INTEGER PRIMARY KEY, IndexValue TEXT, Status TEXT)');
        });


  } catch (e) {
    print("Exception");
    return false;
  }
  return true;
}

class CartItem extends ChangeNotifier{
  List<CartObject> item=[];

  void updatedListItem(value){
    item.add(value);
    print("product price : ${item[0].productPrice}");
    notifyListeners();
  }

}
