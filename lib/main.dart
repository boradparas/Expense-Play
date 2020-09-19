import 'package:expenseplay/screens/edit_screen.dart';
import 'package:expenseplay/screens/given_or_taken_screen.dart';
import 'package:expenseplay/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        GivenOrTakenScreen.id: (context) => GivenOrTakenScreen(),
        EditScreen.id: (context) => EditScreen(),
      },
    );
  }
}
