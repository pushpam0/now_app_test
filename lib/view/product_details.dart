

import 'package:flutter/material.dart';
import 'package:now_app_test/event/React_on_event.dart';
import 'package:now_app_test/model/cart_object.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class ProductDetails extends StatefulWidget {
  int id;

  ProductDetails({required this.id});

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int QUANTITY = 0;
  List<Map> list=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductDetailsFromDb();
  }



  getProductDetailsFromDb() async {

    var databasesPath = await getDatabasesPath();
    String path2 = join(databasesPath, 'cart.db');
    Database database2 = await openDatabase(path2, version: 1);
    List<Map> list4 = await database2.rawQuery('SELECT * FROM Cart WHERE Identification = ?',['${widget.id}']);

    if(list4.isNotEmpty) {
      setState(() {
        QUANTITY=int.parse(list4[0]["Quantity"]);
      });
    }


      //var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'product.db');
      Database database = await openDatabase(path, version: 1);
      List<Map> list2 =
      await database.rawQuery('SELECT * FROM Product WHERE id=${widget.id}');
      setState(() {
        list = list2;

      });
      print("list2 : $list2");

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: list.isEmpty!=true?ListView(children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
          child: Center(child: Image.network(list[0]["Product_Image"],fit: BoxFit.fitWidth,)),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Product Name : ${list[0]["Product_Name"]}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Price : ${list[0]["Price"]} /-",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Available Quantity : ${list[0]["Unit"]}",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      if(QUANTITY>0) {
                        setState(() {
                          QUANTITY--;
                        });
                      }
                      else{
                        showAlertDialog(context,"Negative quantity is not possible !");
                      }
                    },
                    child: Text("-")),
                SizedBox(
                  width: 5,
                ),
                Text("$QUANTITY"),
                SizedBox(
                  width: 5,
                ),
                TextButton(
                    onPressed: () {
                      if(QUANTITY<int.parse(list[0]["Unit"])) {
                        setState(() {
                          QUANTITY++;
                        });
                      }
                      else{
                        showAlertDialog(context,"Can't add an item higher than the available quantity !");
                      }
                    },
                    child: Text("+")),
              ],
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                ),
                onPressed: () async {
                  if(QUANTITY>0) {
                  //  Provider.of<CartItem>(context, listen: false).updatedListItem(CartObject(productName:list[0]["Product_Name"],productPrice: (double.parse(list[0]["Price"]) * QUANTITY).toString(),quantity: QUANTITY.toString(), ));
                    insertCartStatus(list[0]["Product_Name"], QUANTITY,
                        double.parse(list[0]["Price"]) * QUANTITY, list[0]["id"])
                        .then((value) {
                      if (value == true)
                        Navigator.pop(context);
                    });
                  }else{
                    showAlertDialog(context,"Add item quantity must be at least 1 !");
                  }
                //  double.parse(list[0]["Unit"])*QUANTITY;
                  // Get a location using getDatabasesPath
                /*  var databasesPath = await getDatabasesPath();
                  String path = join(databasesPath, 'cart.db');
                  Database database = await openDatabase(path, version: 1);
                  List<Map> list =
                      await database.rawQuery('SELECT * FROM Cart');
                  print(list);*/
                },
                child: Text('Add To Cart'),
              ),
            ),
          ],
        ),
      ]):const Center(child: Text("loading DB item...")),
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
