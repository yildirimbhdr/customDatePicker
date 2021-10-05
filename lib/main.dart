import 'package:customdatepicker/custom_date_picker.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Date Picker',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
          child: Align(
            alignment: Alignment.topCenter,
            child: CustomDatePicker(
              onSelected: (a) {},
              theme: CustomDatePickerThemeData(
                  selectedItemTextStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                  unSelectedItemTextStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                  backgroundColor: Colors.blue.withOpacity(0.3),
                  buttonItemColor: Colors.white,
                  buttonBackgroundColor: Colors.blue,
                  selectedItemBackground: Colors.blue,
                  unSelectedItemBackground: Colors.blue.withOpacity(0.5)),
              firstTime: DateTime.now(),
            ),
          ),
        ),
      ),
    );
  }
}
