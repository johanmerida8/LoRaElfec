import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lora_app/CiudadCRUD/view_data_ciudad.dart';

class InsertCiudadPage extends StatefulWidget {
  
  
  @override
  _InsertCiudadPageState createState() => _InsertCiudadPageState();
}

class _InsertCiudadPageState extends State<InsertCiudadPage> {
  TextEditingController nombre = TextEditingController();

  Future<void> insertciudad() async 
  {
    if(nombre.text != "")
    {
      try{
        String uri = "http://localhost/LoRa_API/insert_ciudad.php";
        var res = await http.post(Uri.parse(uri), body: {
          "nombre": nombre.text,

        });

        var response = jsonDecode(res.body);
        if(response["success"] == "true")
        {
          print("Ciudad Insertado");
          nombre.clear();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insertar Ciudad'),
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
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor, Introduzca un Ciudad';
                }
                return null;
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: (){
                insertciudad();
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
                    Navigator.push(context, MaterialPageRoute(builder:(context) => viewDataCiudadPage()));
                  }, 
                  child: Text("Ver Datos"));
              },
            ),
          ),
        ],
      )
    );
  }
}