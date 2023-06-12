import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class updateMedidorPage extends StatefulWidget {

  String id_Medidor;
  String consumo;
  updateMedidorPage(this.id_Medidor, this.consumo);

  @override
  _updateMedidorPageState createState() => _updateMedidorPageState();
}

class _updateMedidorPageState extends State<updateMedidorPage> {

  TextEditingController consumo = TextEditingController();

  Future<void> updatemedidor(String MedidorID) async {
    try
    {
      double consumoValue = double.parse(consumo.text);

      String uri = "http://localhost/LoRa_API/update_medidor.php";

      var res = await http.post(Uri.parse(uri),
      body: {
        "id_Medidor": MedidorID,
        "consumo": consumoValue.toString(),
      });
      var response = jsonDecode(res.body);
        if(response["success"] == "true")
        {
          print("Consumo Actualizado");
          
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
    consumo.text = widget.consumo;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actualizar Consumo')
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: consumo,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Ingrese un Consumo'),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: (){
                updatemedidor(widget.id_Medidor.toString());
              }, 
              child: Text('Actualizar'),
            ),
          ),
        ],
      ),
    );
  }
}