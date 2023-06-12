import 'package:flutter/material.dart';

class TotalLabel extends StatefulWidget {
  

  @override
  _TotalLabelState createState() => _TotalLabelState();
}

class _TotalLabelState extends State<TotalLabel> {

  double total = 0.0;

  void addToTotal(double price) {
    setState(() {
      total += price;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Text(
        'Total: \$${total.toStringAsFixed(2)}', // Display total with two decimal places
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}