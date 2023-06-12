import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lora_app/CategoriaCRUD/view_data_categoria.dart';
import 'package:http/http.dart' as http;

class InsertCategoriaPage extends StatefulWidget {
  
  
  @override
  _InsertCategoriaPageState createState() => _InsertCategoriaPageState();
}

class _InsertCategoriaPageState extends State<InsertCategoriaPage> {
  TextEditingController tipo = TextEditingController();

  Future<void> insertcategoria() async 
  {
    if(tipo.text != "")
    {
      try{
        String uri = "http://localhost/LoRa_API/insert_categoria.php";
        var res = await http.post(Uri.parse(uri), body: {
          "tipo": tipo.text,

        });

        var response = jsonDecode(res.body);
        if(response["success"] == "true")
        {
          print("Categoria Insertado");
          tipo.clear();
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
        title: Text('Insertar Categoria'),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: tipo,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Ingrese el Categoria'),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor, Introduzca una Categoria';
                }
                return null;
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: (){
                insertcategoria();
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
                    Navigator.push(context, MaterialPageRoute(builder:(context) => viewDataCategoriaPage()));
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