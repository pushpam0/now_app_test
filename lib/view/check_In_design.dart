import 'package:flutter/material.dart';
import 'package:now_app_test/event/React_on_event.dart';
import 'package:now_app_test/model/retailer_models.dart';
import 'package:now_app_test/view/home_page_design.dart';
import 'package:now_app_test/view/product_list.dart';
import 'package:now_app_test/view/take_order_checkout.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckInDesign extends StatefulWidget {
  const CheckInDesign({Key? key}) : super(key: key);

  @override
  State<CheckInDesign> createState() => _CheckInDesignState();
}

class _CheckInDesignState extends State<CheckInDesign> {
  String? checkInStatus = "";
  bool checkIn=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSharedPrefData();
    //CreateTableTest();
  }

  getSharedPrefData() async{
    final prefs = await SharedPreferences.getInstance();
   bool? check= await prefs.getBool("CHECKIN");

    int? store=await prefs.getInt("CHECKINSTORE");
    setState(() {
      checkIn=check!;
      checkInStatus=RetailerModel().retailers[store!]["ShopName"];
    });
  }

  @override
  Widget build(BuildContext context) {
    getSharedPrefData();
    return Scaffold(
      body: ListView(children: [
        InkWell(onTap: (){
          if(checkIn==false) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePageDesign()),
            );
          }
          else{
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TakeOrderCheckOut()),
            );
          }
        },
          child: Card(
            child: ListTile(
              title: const Text("Check In"),
              subtitle: Text(checkInStatus!),
              trailing: Icon(Icons.arrow_forward),
            ),
          ),
        ),
      ]),
    );
  }
}
