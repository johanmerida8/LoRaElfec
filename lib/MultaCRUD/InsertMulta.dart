import 'package:intl/intl.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lora_app/MultaCRUD/view_data_multa.dart';

class InsertMultaPage extends StatefulWidget {
  InsertMultaPage({Key? key}) : super(key: key);
  
  @override
  _InsertMultaPageState createState() => _InsertMultaPageState();
}

class _InsertMultaPageState extends State<InsertMultaPage> {

  TextEditingController cliente = TextEditingController();
  TextEditingController ci = TextEditingController();
  TextEditingController direccion = TextEditingController();
  TextEditingController numeroMedidor = TextEditingController();
  TextEditingController descripcion = TextEditingController();
  TextEditingController monto = TextEditingController();
  TextEditingController fecha = TextEditingController();
  TextEditingController fechaLimite = TextEditingController();
  TextEditingController estado = TextEditingController();

  Future<void> insertmulta() async 
  {
    if(cliente.text != "" || ci.text != "" || direccion.text != "" || numeroMedidor.text != "" || 
    descripcion.text != "" || monto.text != "" || fecha.text != "" || fechaLimite.text != "" || estado.text != "" )
    {
      try
      {
        String uri = "http://localhost/LoRa_API/insert_multa.php";

        double montoValue = double.parse(monto.text);
        DateTime fechaValue = DateFormat("yyyy-MM-dd").parse("${fecha.text} 00:00:00");
        DateTime fechaLimiteValue = DateFormat("yyyy-MM-dd").parse("${fechaLimite.text} 00:00:00");

        var res = await http.post(Uri.parse(uri), body: {
          "cliente": cliente.text,
          "ci": ci.text,
          "direccion": direccion.text,
          "numeroMedidor": numeroMedidor.text,
          "descripcion": descripcion.text,
          "monto": montoValue.toString(),
          "fecha": fechaValue.toIso8601String(),
          "fechaLimite": fechaLimiteValue.toIso8601String(),
          "estado": estado.text,
        });

        var response = jsonDecode(res.body);
        if(response["success"] == "true")
        {
          print("Multa Insertado");
          cliente.clear();
          ci.clear();
          direccion.clear();
          numeroMedidor.clear();
          descripcion.clear();
          monto.clear();
          fecha.clear();
          fechaLimite.clear();
          estado.clear();
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insert Multa'),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: cliente,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Ingrese nombre del cliente'),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: ci,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Ingrese numero del carnet'),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: direccion,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Ingrese el nombre del direccion'),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: numeroMedidor,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Ingrese el numero del medidor'),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: descripcion,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Ingrese un descripcion'),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: monto,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Ingrese el cantidad del monto'),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: fecha,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Ingrese fecha de emision'),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: fechaLimite,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Ingrese fecha limite'),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: estado,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Ingrese el estado'),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: (){
                insertmulta();
              }, 
              child: Text('Insert'),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Builder(
              builder: (cont){
                return ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder:(context) => viewDataMultaPage()));
                  }, 
                  child: Text("View Data"));
              },
            ),
          ),
        ],
      ),
    );
  }
}


