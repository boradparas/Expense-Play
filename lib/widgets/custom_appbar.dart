import 'package:expenseplay/constants.dart';
import 'package:flutter/material.dart';

AppBar customAppbar(String title) {
  return AppBar(
    elevation: 0,
    backgroundColor: kBackgroundColor,
    iconTheme: IconThemeData(
      color: kTextColor, //change your color here
    ),
    brightness: Brightness.light,
    title: Text(
      title,
      style: TextStyle(color: kTextColor),
    ),
  );
}
