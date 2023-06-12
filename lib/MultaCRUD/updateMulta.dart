// ignore: unused_import
import 'package:intl/intl.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class updateMultaPage extends StatefulWidget {
  
  String id_Multa;
  String cliente;
  String ci;
  String direccion;
  String numeroMedidor;
  String descripcion;
  String monto;
  String fecha;
  String fechaLimite;
  String estado;

  updateMultaPage(this.id_Multa, this.cliente, this.ci, this.direccion, this.numeroMedidor, this.descripcion, this.monto, this.fecha, this.fechaLimite, this.estado);



  @override
  _updateMultaPageState createState() => _updateMultaPageState();
}

class _updateMultaPageState extends State<updateMultaPage> {

  TextEditingController cliente = TextEditingController();
  TextEditingController ci = TextEditingController();
  TextEditingController direccion = TextEditingController();
  TextEditingController numeroMedidor = TextEditingController();
  TextEditingController descripcion = TextEditingController();
  TextEditingController monto = TextEditingController();
  TextEditingController fecha = TextEditingController();
  TextEditingController fechaLimite = TextEditingController();
  TextEditingController estado = TextEditingController();

  

  Future<void> updatemulta(String idMulta) async 
  {
    try
    {
      String uri = "http://localhost/LoRa_API/update_multa.php";

      /* double montoValue = double.parse(monto.text); */
      /* DateTime fechaValue = DateFormat("yyyy-MM-dd").parse(fecha.text);
      DateTime fechaLimiteValue = DateFormat("yyyy-MM-dd").parse(fechaLimite.text); */

      var res = await http.post(Uri.parse(uri), 
      body: {
        "id_Multa": idMulta,
        "cliente": cliente.text,
          "ci": ci.text,
          "direccion": direccion.text,
          "numeroMedidor": numeroMedidor.text,
          "descripcion": descripcion.text,
          /* "monto": double.parse(monto.text), */
          "monto": monto.text,
          /* "fecha": fechaValue.toIso8601String(), */
          "fecha": fecha.text,
          /* "fechaLimite": fechaLimiteValue.toIso8601String(), */
          "fechaLimite": fechaLimite.text,
          "estado": estado.text,
      });
      var response = jsonDecode(res.body);
        if(response["success"] == "true")
        {
          print("Multa Actualizado");
          
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
    cliente.text = widget.cliente;
    ci.text = widget.ci;
    direccion.text = widget.direccion;
    numeroMedidor.text = widget.numeroMedidor;
    descripcion.text = widget.descripcion;
    /* monto.text = widget.monto.toString(); */
    monto.text = widget.monto;
    /* fecha.text = widget.fecha.toIso8601String(); */
    fecha.text = widget.fecha;
    /* fechaLimite.text = widget.fechaLimite.toIso8601String(); */
    fechaLimite.text = widget.fechaLimite;
    estado.text = widget.estado;
    

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Multa')
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            /* child: TextFormField(
              controller: TextEditingController(text: widget.id_Multa.toString()),
              readOnly: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('ID Multa'),
              ),
            ), */
          ),
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
                updatemulta(widget.id_Multa.toString());
              }, 
              child: Text('Update'),
            ),
          ),
        ],
      ),
    );
  }
}