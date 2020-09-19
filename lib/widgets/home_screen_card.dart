import 'package:expenseplay/constants.dart';
import 'package:expenseplay/screens/given_or_taken_screen.dart';
import 'package:flutter/material.dart';

class HomeScreenCard extends StatelessWidget {
  final String title;
  final int total;

  HomeScreenCard({
    this.title,
    this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kCardBackgroundColor,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GivenOrTakenScreen(
                title: title,
              ),
            ),
          );
        },
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: kDarkBackground,
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: kTextColor,
              ),
            ),
            radius: 30,
          ),
          title: Text("Total"),
          subtitle: Text(total.toString() ?? "0"),
          trailing: IconButton(
            icon: Icon(Icons.navigate_next),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GivenOrTakenScreen(
                    title: title,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
