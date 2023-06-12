import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class updateCiudadPage extends StatefulWidget {

  String id_Ciudad;
  String nombre;
  updateCiudadPage(this.id_Ciudad, this.nombre);

  @override
  _updateCiudadPageState createState() => _updateCiudadPageState();
}

class _updateCiudadPageState extends State<updateCiudadPage> {

  TextEditingController nombre = TextEditingController();

  Future<void> updateciudad(String CiudadID) async {
    try
    {
      String uri = "http://localhost/LoRa_API/update_ciudad.php";

      var res = await http.post(Uri.parse(uri),
      body: {
        "id_Ciudad": CiudadID,
        "nombre": nombre.text,
      });
      var response = jsonDecode(res.body);
        if(response["success"] == "true")
        {
          print("Ciudad Actualizado");
          
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
    nombre.text = widget.nombre;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actualizar Ciudad')
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: nombre,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Ingrese un Ciudad'),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: (){
                updateciudad(widget.id_Ciudad.toString());
              }, 
              child: Text('Actualizar'),
            ),
          ),
        ],
      ),
    );
  }
}