import 'package:flutter/material.dart';

class InvoiceCreate extends StatefulWidget {
  const InvoiceCreate({super.key});

  @override
  _InvoiceCreateState createState() => _InvoiceCreateState();
}

class _InvoiceCreateState extends State<InvoiceCreate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice'),
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              
            ],
          ),
        ),
      ),
    );
  }
}