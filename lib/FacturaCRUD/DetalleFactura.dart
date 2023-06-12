import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class detalleFactura extends StatefulWidget {
  const detalleFactura({super.key});

  @override
  _detalleFacturaState createState() => _detalleFacturaState();
}

class _detalleFacturaState extends State<detalleFactura> {

  TextEditingController consumo = TextEditingController();
  TextEditingController descripcion = TextEditingController();
  TextEditingController importe = TextEditingController();

  List<dynamic> facturadata = [];
  String? selectedFacturaValue;
  
  Future<void> getfactura() async {
    String uri = "http://localhost/LoRa_API/view_data_factura.php";
    try
    {
      var response = await http.get(Uri.parse(uri));

      setState(() {
        facturadata = jsonDecode(response.body);
      });
    }
    catch(e)
    {
      print(e);
    }
  }

  Future<void> insertdetfactura() async 
  {
    if(consumo.text.isNotEmpty && descripcion.text.isNotEmpty && importe.text.isNotEmpty && selectedFacturaValue != null)
    {
      try{
        if(selectedFacturaValue == null) {
          print("Por favor, seleccione una categoría");
          return;
        }
        String uri = "http://localhost/LoRa_API/detalle_factura.php";
        var res = await http.post(Uri.parse(uri), body: {
          "consumo": consumo.text,
          "descripcion": descripcion.text,
          "importe": importe.text,
          "FacturaID": selectedFacturaValue!,
        });

        var response = jsonDecode(res.body);
        if(response["success"] == "true")
        {
          print("Detalle Insertado");
          consumo.clear();
          descripcion.clear();
          importe.clear();
          setState(() {
            selectedFacturaValue = null;
            /* fechaV = null; */
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

  @override
  void initState() {
    // TODO: implement initState
    getfactura();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insertar Detalle'),
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
            child: TextFormField(
              controller: descripcion,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Ingrese un Descripcion'),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor, Ingrese un Descripcion';
                }
                return null;
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: importe,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Ingrese el Importe'),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor, Ingrese el Importe';
                }
                return null;
              },
            ),
          ),

          Container(
            child: DropdownButton<String>(
              value: selectedFacturaValue,
              icon: Icon(Icons.menu),
              style: TextStyle(color: Colors.black),
              underline: Container(
                height: 2,
                color: Colors.black,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  selectedFacturaValue = newValue!;
                });
              },
              items: [
                DropdownMenuItem<String>(
                  value: null,
                  child: Text('Seleccione'),
                ),
                  ...facturadata.map<DropdownMenuItem<String>>((dynamic category) {
                    String? FacturaID = category['id_Factura'].toString();
                    String? cliente = category['cliente'].toString();
                    String? estado = category['estado'].toString();
                    String? CategoriaID = category['CategoriaID'].toString();
                    String? UsuarioID = category['UsuarioID'].toString();
                    String? text = '$cliente, $estado, $CategoriaID, $UsuarioID';
                    return DropdownMenuItem<String>(
                      value: FacturaID,
                      child: Text(text),
                    );
                  }).toSet().toList(),
              ],
            ),
          ),
          

          Container(
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: (){
                insertdetfactura();
                /* Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InvoiceDisplayPage(
                      cliente: cliente.text,
                      descripcion: estado.text,
                      ImporteID: selectedCategoriaValue,
                      UsuarioID: selectedUsuarioValue,
                    ),
                  ),
                ); */
              }, 
              child: Text('Insertar'),
            ),
          ),
          /* Container(
            margin: EdgeInsets.all(10),
            child: Builder(
              builder: (cont){
                return ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder:(context) => viewDataFacturaPage()));
                  }, 
                  child: Text("Ver Datos"));
              },
            ),
          ), */
        ],
      ),
    );
  }
}