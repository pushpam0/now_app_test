import 'package:flutter/material.dart';
import 'package:now_app_test/view/product_list.dart';
import 'package:now_app_test/view/product_list_cart_list.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';


class TakeOrderCheckOut extends StatefulWidget {
  const TakeOrderCheckOut({Key? key}) : super(key: key);

  @override
  State<TakeOrderCheckOut> createState() => _TakeOrderCheckOutState();
}

class _TakeOrderCheckOutState extends State<TakeOrderCheckOut> {
  String checkInStatus = "";
  List<Map> list=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStatus();
  }

  getStatus() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'cart.db');
    Database database = await openDatabase(path, version: 1);
    List<Map> list2 = await database.rawQuery('SELECT * FROM Cart ');

    setState(() {
      list=list2;
    });

  }

  @override
  Widget build(BuildContext context) {
    getStatus();
    return Scaffold(
      body: ListView(children: [
        InkWell(onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProductList()),
          );
        },
          child: Card(
            child: Container(color: list.isNotEmpty==true?Colors.blue:Colors.white,
              child: ListTile(
                title: const Text("Take Order"),
                subtitle: Text(checkInStatus),
                trailing: Icon(Icons.arrow_forward),
              ),
            ),
          ),
        ),
        InkWell(onTap: () async {
        /*  Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePageDesign()),
          );*/
    if(list.isNotEmpty){
    showAlertDialog(context,"Please Take an order then Check Out or Delete Cart item !");
    }
    else {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.remove("CHECKIN");
          await preferences.remove("CHECKINSTORE");

          var databasesPath = await getDatabasesPath();
          String path = join(databasesPath, 'cart.db');
          Database database = await openDatabase(path, version: 1);

            await database
              .rawDelete('DELETE FROM Cart');

      String path2 = join(databasesPath, 'product.db');
      Database database2 = await openDatabase(path2, version: 1);
      int count2 = await database2.rawUpdate(
          'UPDATE Product SET Unit = 100 ');


            Navigator.pop(context);

    }
        },
          child: Card(
            child: ListTile(
              title: const Text("Check Out"),
              subtitle: Text(checkInStatus),
              trailing: Icon(Icons.arrow_forward),
            ),
          ),
        ),
      ]),
    );
  }

  showAlertDialog(BuildContext context,String msg) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text(msg),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
