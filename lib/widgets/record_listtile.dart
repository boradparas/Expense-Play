import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenseplay/screens/edit_screen.dart';
import 'package:flutter/material.dart';

class RecordListTile extends StatelessWidget {
  final String name;
  final String description;
  final int amount;
  final Timestamp date;
  final String docId;
  final String collectionName;

  RecordListTile({
    this.name,
    this.docId,
    this.description,
    this.amount,
    this.date,
    this.collectionName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              title: Text(name),
              subtitle: Text(description),
              trailing: Text(amount.toString()),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditScreen(
                    title: name,
                    docId: docId,
                    date: date,
                    description: description,
                    amount: amount,
                    name: name,
                    collectionName: collectionName,
                  ),
                ),
              );
            },
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Are you sure you want to delete the record of " +
                      name +
                      "?"),
                  actions: [
                    FlatButton(
                      onPressed: () {
                        Firestore.instance
                            .collection(collectionName)
                            .document(docId)
                            .delete();
                        Navigator.pop(context);
                      },
                      child: Text("Yes"),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("No"),
                    ),
                  ],
                ),
              );
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
