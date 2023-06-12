import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lora_app/ImporteCRUD/view_data_importe.dart';

class RowData{
  String descripcion;
  String monto;

  RowData({required this.descripcion, required this.monto});
}

class insertImportePage extends StatefulWidget {
  
  
  @override
  _insertImportPageState createState() => _insertImportPageState();
}

class _insertImportPageState extends State<insertImportePage> {


  TextEditingController descripcion = TextEditingController();
  TextEditingController precio = TextEditingController();

  List<dynamic> categorydata = [];
  /* String categoryValue = ""; */

  
  Future getcategory() async {
    String uri = "http://localhost/LoRa_API/get_categoria.php";
    try
    {
      var response = await http.get(Uri.parse(uri));

      if(response.statusCode == 200) {
        
        setState(() {
          categorydata = jsonDecode(response.body);
        });
      }
    }
    catch(e)
    {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getcategory();
  }

  Future insertimporte() async 
  {
    if (descripcion.text.isNotEmpty && precio.text.isNotEmpty && categoryValue != null)
    {
      try{
        String uri = "http://localhost/LoRa_API/insert_importe.php";
        
          var res = await http.post(Uri.parse(uri), body: {
          "descripcion": descripcion.text,
          "precio": precio.text, 
          "CategoriaID": categoryValue,
          });

          var response = jsonDecode(res.body);
        if(response["success"] == "true")
        {
          print("Importe Insertado");
          descripcion.clear();
          precio.clear();
          setState(() {
            categoryValue = null;
          });
        }
        else 
        {
          print("hubo algun fallo");
        }
        
      }
      catch(e){
        print(e);
      }
    }
    else
    {
      print("Porfavor llene todo los campos");
    }
  }

  String? categoryValue;
  /* List<String> dropdownItems = [
    'Monofasico',
    'Trifasico'
  ]; */

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text('Insertar Importe'),
      ),
      body: Column(
        children: [
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: descripcion,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Ingrese el Descripcion'),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, Ingrese el Descripcion del Importe';
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextFormField(
                controller: precio,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Ingrese el Precio'),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, Ingrese el Precio del Importe';
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: DropdownButton<String>(
                value: categoryValue,
                onChanged: (String? newValue) {
                  setState(() {
                    categoryValue = newValue;
                  });
                },
                items: categorydata.map<DropdownMenuItem<String>>((dynamic category) {
                  return DropdownMenuItem<String>(
                    value: category['id_Categoria'].toString(),
                    child: Text(category['tipo']),
                  );
                }).toList(),
              ),
            ),
          Container(
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: (){
                insertimporte();
              }, 
              child: Text('Insertar'),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Builder(
              builder: (cont){
                return ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder:(context) => viewDataImportePage()));
                  }, 
                  child: Text("Ver Datos"));
              },
            ),
          ),
        ],
      ),
    );

    
  }



