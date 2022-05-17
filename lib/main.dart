import 'package:flutter/material.dart';
import 'package:now_app_test/view/check_In_design.dart';

import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import 'event/React_on_event.dart';
import 'view/login_design.dart';

void main() {
  runApp(const MyApp());

}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  bool checkLogin=false;
  bool? getFromServices=false;
  List<Map> list=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getSharedprefData();
    CreateTableTest();
    createTableCart();
   /* CreateTableCheckIn();
    createTableCart();*/
  }

  getSharedprefData()async{
    final prefs = await SharedPreferences.getInstance();
    getFromServices=await prefs.getBool("login");
    setState(() {
      checkLogin=getFromServices!;
    });
    if(checkLogin==true){
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'checkin.db');
      Database database = await openDatabase(path, version: 1);
      List<Map> list2 =
      await database.rawQuery('SELECT * FROM Check_In');
      setState(() {
        list=list2;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: checkLogin!=true?const LoginDesign():list.isEmpty==true?CheckInDesign():CircularProgressIndicator()/*:ProductList():Scaffold(body: Center(child: CircularProgressIndicator(),))*/,
    );
  }
}

