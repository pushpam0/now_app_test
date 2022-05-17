import 'package:flutter/material.dart';
import 'package:now_app_test/view/product_details.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class ProductDesign extends StatefulWidget {
  const ProductDesign({Key? key}) : super(key: key);

  @override
  _ProductDesignState createState() => _ProductDesignState();
}

class _ProductDesignState extends State<ProductDesign> {
  List<Map> list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDBData();
  }


  Future<void> getDBData() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'product.db');
    Database database = await openDatabase(path, version: 1);
    List<Map> list2 = await database.rawQuery('SELECT * FROM Product');
    setState(() {
      list=list2;
    });
    print(list);
  }

  @override
  Widget build(BuildContext context) {
    getDBData();
    return Scaffold(
      body: list.isEmpty!=true?ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
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
                      "Price : ${list[index]["Price"]} /-",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Available Quantity : ${list[index]["Unit"]}",
                    ),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    InkWell(
                        onTap: () {
 Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>ProductDetails(id: list[index]["id"])),
                          );

                        },
                        child: Text(
                          "Add To Cart",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.blue),
                        )),
                  ]),
                ]),
              ),
            );
          }):const Center(child: Text("Loading DB Product...")),
    );
  }
}
