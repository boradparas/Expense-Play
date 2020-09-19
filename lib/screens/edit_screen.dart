import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expenseplay/constants.dart';
import 'package:expenseplay/screen_utils.dart';
import 'package:expenseplay/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditScreen extends StatefulWidget {
  static const String id = "edit_screen";
  final String docId;
  final String title;
  final String name;
  final String description;
  final int amount;
  final Timestamp date;
  final String collectionName;

  EditScreen({
    this.docId,
    this.title,
    this.name,
    this.description,
    this.amount,
    this.date,
    this.collectionName,
  });

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  String _title;
  bool _isNew;

  String _name;
  int _amount;
  String _content;

  TextEditingController _textNameInput;
  TextEditingController _textAmountInput;
  TextEditingController _textContentInput;

  bool _validateNameInput = false;
  bool _validateAmountInput = false;
  bool _validateContentInput = false;

  bool _getStatusEditOrNew() {
    if (widget.title == kGiven || widget.title == kTaken) {
      _title = "Add to " + widget.title;
      _textNameInput = TextEditingController();
      _textAmountInput = TextEditingController();
      _textContentInput = TextEditingController();
      return true;
    } else {
      _title = "Edit " + widget.title;
      _name = widget.name;
      _amount = widget.amount;
      _content = widget.description;
      _textNameInput = TextEditingController(text: widget.name);
      _textAmountInput = TextEditingController(text: widget.amount.toString());
      _textContentInput = TextEditingController(text: widget.description);
      return false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isNew = _getStatusEditOrNew();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil().init(context);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: customAppbar(_title),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: ScreenUtil.blockSizeHorizontal * 2,
            right: ScreenUtil.blockSizeHorizontal * 2,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) {
                      _name = value;
                    },
                    controller: _textNameInput,
                    decoration: new InputDecoration(
                        errorText:
                            _validateNameInput ? 'Value Can\'t Be Empty' : null,
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.teal)),
                        hintText: 'Enter Name',
                        labelText: 'Enter Name',
                        prefixText: '',
                        suffixStyle: const TextStyle(color: Colors.green)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      _amount = int.parse(value);
                    },
                    controller: _textAmountInput,
                    decoration: new InputDecoration(
                        errorText: _validateAmountInput
                            ? 'Value Can\'t Be Empty'
                            : null,
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.teal)),
                        hintText: 'Enter amount',
                        helperText:
                            "Please enter right amount, Don't forget 9800!",
                        labelText: 'Enter Amount',
                        prefixText: ' ',
                        suffixStyle: const TextStyle(color: Colors.green)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _textContentInput,
                    keyboardType: TextInputType.multiline,
                    maxLines: 2,
                    onChanged: (value) {
                      setState(() {
                        _content = value;
                      });
                    },
                    decoration: new InputDecoration(
                        errorText: _validateContentInput
                            ? 'Value Can\'t Be Empty'
                            : null,
                        border: new OutlineInputBorder(
                            borderSide: new BorderSide(color: Colors.teal)),
                        hintText: 'Type the Description',
                        labelText: 'Enter Description',
                        helperText: "Remember not HK Demand",
                        prefixText: ' ',
                        suffixStyle: const TextStyle(color: Colors.green)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(ScreenUtil.safeBlockVertical * 2),
                  child: FlatButton(
                    color: kButtonColor,
                    onPressed: () {
                      setState(() {
                        _textNameInput.text.isEmpty
                            ? _validateNameInput = true
                            : _validateNameInput = false;
                        _textAmountInput.text.isEmpty
                            ? _validateAmountInput = true
                            : _validateAmountInput = false;
                        _textContentInput.text.isEmpty
                            ? _validateContentInput = true
                            : _validateContentInput = false;
                      });

                      if (_textNameInput.text.isEmpty ||
                          _textAmountInput.text.isEmpty ||
                          _textContentInput.text.isEmpty) {
                        return;
                      } else {
                        if (_isNew) {
                          Firestore.instance.collection(widget.title).add({
                            "name": _name,
                            "amount": _amount,
                            "description": _content,
                            "date": Timestamp.fromDate(DateTime.now()),
                          });
                          Navigator.pop(context);
                        } else {
                          Firestore.instance
                              .collection(widget.collectionName)
                              .document(widget.docId)
                              .updateData({
                            "name": _name,
                            "amount": _amount,
                            "description": _content,
                            "date": Timestamp.fromDate(DateTime.now()),
                          });
                          Navigator.pop(context);
                        }
                      }
                    },
                    child: Text(_title),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
