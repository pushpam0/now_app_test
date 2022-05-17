import 'package:flutter/material.dart';
import 'package:now_app_test/view/product_details.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../event/React_on_event.dart';

class CartItem extends StatefulWidget {
  const CartItem({Key? key}) : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  List<Map> list = [];
  double total_price=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getItemFromCart();
  }

  Future<void> getItemFromCart() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'cart.db');
    Database database = await openDatabase(path, version: 1);
    List<Map> list2 = await database.rawQuery('SELECT * FROM Cart');
    setState(() {
      list = list2;
    });
    print(list);
  }

  @override
  Widget build(BuildContext context) {
    getItemFromCart();
    return Scaffold(

      body:list.isEmpty!=true? ListView.builder(itemCount: list.length,itemBuilder: (context, index) {
        total_price+=double.parse(list[index]["Total_Price"]);
        return Card(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Product Name : ${list[index]["Product_Name"]}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Total Price : ${list[index]["Total_Price"]} /-",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Added Quantity : ${list[index]["Quantity"]}",
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>ProductDetails(id: int.parse(list[index]["Identification"]))),
                      );
                      /* Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>ProductDetails(id: list[index]["id"])),
                    );*/
                    },
                    child: Text(
                      "Edit",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    )),
                SizedBox(width: 10,),
                InkWell(
                    onTap: () {
                      deleteCartStatus(list[index]["id"]).then((value){
                        if(value==true){
                          getItemFromCart();
                        }
                      });
                      /* Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>ProductDetails(id: list[index]["id"])),
                    );*/
                    },
                    child: Text(
                      "Delete",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red),
                    )),
              ]),
            ]),
          ),
        );
      }):const Center(child: Text("No Item please add")),
      floatingActionButton:FloatingActionButton.extended(
        onPressed: (){
          showAlertDialog(context,total_price,list.length);
        },
        label: Text("Take order"),

      ),
    );
  }
  showAlertDialog(BuildContext context,double price,int len) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("Check Out",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),),
      onPressed: () async{
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.remove("CHECKIN");
        await preferences.remove("CHECKINSTORE");

        var databasesPath = await getDatabasesPath();
        String path = join(databasesPath, 'cart.db');
        Database database = await openDatabase(path, version: 1);

        await database
            .rawDelete('DELETE FROM Cart');

      //  var databasesPath = await getDatabasesPath();
        String path2 = join(databasesPath, 'product.db');
        Database database2 = await openDatabase(path2, version: 1);
        int count2 = await database2.rawUpdate(
            'UPDATE Product SET Unit = 100 ');

        Navigator.pop(context);

        finalAlertDialog(context,"Thank you Visit Again! ");

      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(

      content: SizedBox(height: 100,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("Total number of item : $len"),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("Total cost of an item : $price"),
            ),
          ],
        ),
      ),
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

  finalAlertDialog(BuildContext context,String msg) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Congratulation!!!"),
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
