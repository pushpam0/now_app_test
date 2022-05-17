

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:now_app_test/event/React_on_event.dart';
import 'package:now_app_test/view/check_In_design.dart';

Widget OtpPopUpDilog(context) {
  return AlertDialog(
    title: Text("Enter your otp"),
    content: SizedBox(height: 120,
      child: Column(
        children: [
          Row(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0,8,8,8),
              child: SizedBox(height: 60,width: 50,
                child: TextField(inputFormatters: [LengthLimitingTextInputFormatter(1),],
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  autofocus: true,

                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    if (value.length == 1) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,8,8,8),
              child: SizedBox(height: 60,width: 50,
                child: TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  autofocus: true,
                  inputFormatters: [LengthLimitingTextInputFormatter(1),],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    if (value.length == 1) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,8,8,8),
              child: SizedBox(height: 60,width: 50,
                child: TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  autofocus: true,
                  inputFormatters: [LengthLimitingTextInputFormatter(1),],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    if (value.length == 1) {
                      FocusScope.of(context).nextFocus();
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 60,width: 50,
              child: TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                autofocus: true,
                inputFormatters: [LengthLimitingTextInputFormatter(1),],
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  if (value.length == 1) {
                    FocusScope.of(context).nextFocus();
                  }
                },
              ),
            )
          ]),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(onTap:() async {
                 await  veryfyEvent().then((value){
                   if(value==true) {
                     Navigator.pop(context);
                     Navigator.push(
                         context,
                         MaterialPageRoute(
                             builder: (context) => const CheckInDesign())
                     );
                   }
                   else
                     print("value : $value");

                 });

                  /*Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CheckInDesign())
                  );*/

                },child: Text("Verify",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
