import 'package:flutter/material.dart';

class CategoriaImporte extends StatefulWidget {
  
  @override
  _CategoriaImporteState createState() => _CategoriaImporteState();
}

class _CategoriaImporteState extends State<CategoriaImporte> {
  final lists = ['Monofasico','Trifasico'];
  String? value;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
          title: Text('Categoria Importe'),
        ),
        body: Center(
          child: Container(
            width: 300,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black, width: 4),
            ),
            child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              iconSize: 36,
              icon: Icon(Icons.arrow_drop_down, color: Colors.black),
              isExpanded: true,
              items: lists.map(buildMenuItem).toList(),
              onChanged: (value) => setState(() => this.value = value),
            ),
          ),
        ),
      ),
    );
    
    

    DropdownMenuItem<String> buildMenuItem(String list) => DropdownMenuItem(
      value: list,
      child: Text(
        list,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }


