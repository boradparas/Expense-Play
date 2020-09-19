import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenseplay/constants.dart';
import 'package:expenseplay/screens/edit_screen.dart';
import 'package:expenseplay/widgets/custom_appbar.dart';
import 'package:expenseplay/widgets/record_listtile.dart';
import 'package:flutter/material.dart';

final _fireStore = Firestore.instance;

class GivenOrTakenScreen extends StatelessWidget {
  static const String id = "given_or_taken_screen";
  final String title;

  GivenOrTakenScreen({this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: customAppbar(title),
      body: StreamBuilder<QuerySnapshot>(
        stream: _fireStore.collection(title).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final items = snapshot.data.documents;
          int total = 0;
          List<RecordListTile> itemsList = [];
          for (var item in items) {
            final name = item.data["name"];
            final amount = item.data["amount"];
            final date = item.data["date"];
            final description = item.data["description"];
            final docId = item.documentID;
            total = total + item.data["amount"];
            final record = RecordListTile(
              name: name,
              amount: amount,
              description: description,
              date: date,
              docId: docId,
              collectionName: title,
            );
            itemsList.add(record);
          }
          _fireStore
              .collection(title + "Total")
              .document("total")
              .setData({"total": total});
          return ListView(
            shrinkWrap: true,
            children: itemsList,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kButtonColor,
        child: Icon(
          Icons.add,
          color: kTextColor,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditScreen(
                title: title,
              ),
            ),
          );
        },
      ),
    );
  }
}
