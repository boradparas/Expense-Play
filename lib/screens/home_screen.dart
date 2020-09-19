import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenseplay/constants.dart';
import 'package:expenseplay/screen_utils.dart';
import 'package:expenseplay/widgets/home_screen_card.dart';
import 'package:flutter/material.dart';

final _fireStore = Firestore.instance;

class HomeScreen extends StatelessWidget {
  static const String id = "home_screen";
  @override
  Widget build(BuildContext context) {
    ScreenUtil().init(context);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Expense Era",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: ScreenUtil.safeBlockHorizontal * 8,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(ScreenUtil.safeBlockHorizontal * 4),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _fireStore.collection(kGiven + "Total").snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Padding(
                  padding: EdgeInsets.all(ScreenUtil.safeBlockHorizontal * 2),
                  child: HomeScreenCard(
                    title: kGiven,
                    total: 0,
                  ),
                );
              }
              return Padding(
                padding: EdgeInsets.all(ScreenUtil.safeBlockHorizontal * 2),
                child: HomeScreenCard(
                  title: kGiven,
                  total: snapshot.data.documents[0].data["total"],
                ),
              );
            },
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _fireStore.collection(kTaken + "Total").snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Padding(
                  padding: EdgeInsets.only(
                      left: ScreenUtil.safeBlockHorizontal * 2,
                      right: ScreenUtil.safeBlockHorizontal * 2),
                  child: HomeScreenCard(
                    title: kTaken,
                    total: 0,
                  ),
                );
              }
              return Padding(
                padding: EdgeInsets.only(
                    left: ScreenUtil.safeBlockHorizontal * 2,
                    right: ScreenUtil.safeBlockHorizontal * 2),
                child: HomeScreenCard(
                  title: kTaken,
                  total: snapshot.data.documents[0].data["total"],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
