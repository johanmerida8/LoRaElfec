import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


//Parte de Yamil tarea de importe de insercion de actualizacion//

// ignore: must_be_immutable
class updateImportePage extends StatefulWidget {

  String id_Importe;
  String descripcion;
  String precio;
  String CategoriaID;
  
  updateImportePage(this.id_Importe, this.descripcion, this.precio, this.CategoriaID);

  @override
  _updateImportePageState createState() => _updateImportePageState();
}

class _updateImportePageState extends State<updateImportePage> {

  TextEditingController descripcion = TextEditingController();
  TextEditingController precio = TextEditingController();
  
  String? categoryValue;
  List<dynamic> categorydata = [];

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

  Future<void> updateimporte(String idImporte) async {
    try
    {
      String uri = "http://localhost/LoRa_API/update_importe.php";

      var res = await http.post(Uri.parse(uri),
      body: {
        "id_Importe": idImporte,
        "descripcion": descripcion.text,
        "precio": precio.text,
        "CategoriaID": categoryValue,
        
      });
      var response = jsonDecode(res.body);
        if(response["success"] == "true")
        {
          print("Importe Actualizado");
          
        }
        else 
        {
          print("hubo algun fallo");
        }
    
    }
    catch(e)
    {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    descripcion.text = widget.descripcion;
    precio.text = widget.precio;
    categoryValue = widget.CategoriaID;
    getcategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actualizar Importe'),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            /* child: TextFormField(
              controller: TextEditingController(text: widget.id_Factura.toString()),
              readOnly: true,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('ID Factura'),
              ),
            ), */
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: descripcion,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Ingrese el Descripcion del Importe'),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: precio,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Ingrese el Monto del Importe'),
              ),
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
                    value: category['id_Categoria'],
                    child: Text(category['tipo']),
                  );
                }).toList(),
              ),
            ),
          Container(
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: (){
                updateimporte(widget.id_Importe.toString());
              }, 
              child: Text('Actualizar'),
            ),
          ),
        ],
      ),
    );
  }
}

