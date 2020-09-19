import 'package:cloud_firestore/cloud_firestore.dart';

class DataModel {
  String name;
  String description;
  Timestamp date;
  int amount;

  DataModel({this.name, this.description, this.date, this.amount});
}
