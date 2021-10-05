import 'package:customdatepicker/custom_date_picker.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: CustomDatePicker(
              onSelected: (a) {},
              theme: CustomDatePickerThemeData(
                  selectedItemTextStyle: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w400),
                  unSelectedItemTextStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                  buttonItemColor: Colors.white,
                  backgroundColor: Colors.black12),
              firstTime: DateTime.now(),
            ),
          ),
        ),
      ),
    );
  }
}
