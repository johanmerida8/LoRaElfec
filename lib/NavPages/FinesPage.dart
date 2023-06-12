// ignore: unused_import
import 'package:flutter/material.dart';

class FinesPage extends StatefulWidget {
  @override
  _FinesPageState createState() => _FinesPageState();
}

class _FinesPageState extends State<FinesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fines Page"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          }
        )
      ),
    );
  }
}


