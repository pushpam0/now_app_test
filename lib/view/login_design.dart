

import 'package:flutter/material.dart';
import 'package:now_app_test/view/otp_dilog.dart';

class LoginDesign extends StatelessWidget {
  const LoginDesign({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ListView(children: [
      Container(height: MediaQuery.of(context).size.height*0.4,child: FlutterLogo()),
      Padding(
        padding: const EdgeInsets.all(10),
        child: TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Mobile",
              hintText: "Enter Mobile Number"),
        ),
      ),
      SizedBox(height: 20,),
      Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 3,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => OtpPopUpDilog(context),
            );
          },
          child: Text('Login'),
        ),
      ),
    ]),);
  }
}
