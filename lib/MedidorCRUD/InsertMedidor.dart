import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lora_app/MedidorCRUD/view_data_medidor.dart';

class InsertMedidorPage extends StatefulWidget {
  
  
  @override
  _InsertMedidorPageState createState() => _InsertMedidorPageState();
}

class _InsertMedidorPageState extends State<InsertMedidorPage> {
  TextEditingController consumo = TextEditingController();

  Future<void> insertmedidor() async 
  {
    if(consumo.text.isNotEmpty)
    {
      try{
        double consumoValue = double.parse(consumo.text);

        String uri = "http://localhost/LoRa_API/insert_medidor.php";
        var res = await http.post(Uri.parse(uri), body: {
          "consumo": consumoValue.toString(),
        });

        var response = jsonDecode(res.body);
        if(response["success"] == "true")
        {
          print("Consumo Insertado");
          consumo.clear();
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
        title: Text('Insertar Consumo'),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: consumo,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Ingrese el Consumo'),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor, Ingrese el Consumo';
                }
                return null;
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: (){
                insertmedidor();
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
                    Navigator.push(context, MaterialPageRoute(builder:(context) => viewDataMedidorPage()));
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