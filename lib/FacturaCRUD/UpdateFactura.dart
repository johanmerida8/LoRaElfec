import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


//Parte de Johan tarea de factura de actualizacion//

// ignore: must_be_immutable
class updateFacturaPage extends StatefulWidget {
  
  String id_Factura;
  String descripcion;
  String fecha;
  String fechaLimite;
  String ClienteID;
  String ImporteID;
  /* String MedidorID; */
  String CategoriaID;
  /* String CiudadID; */
  
  updateFacturaPage(this.id_Factura, this.descripcion, this.fecha, this.fechaLimite, 
  this.ClienteID, this.ImporteID, this.CategoriaID);

  @override
  _updateFacturaPageState createState() => _updateFacturaPageState();
}

class _updateFacturaPageState extends State<updateFacturaPage> {

  
  TextEditingController descripcion = TextEditingController();
  
  DateTime fechaE = DateTime.now();
  DateTime fechaV = DateTime.now();

  Future<List<dynamic>?> getuser() async {
    String uri = "http://localhost/LoRa_API/get_user.php";
    try
    {
      var response = await http.get(Uri.parse(uri));

      setState(() {
        clienteData = jsonDecode(response.body);
      });
    }
    catch(e)
    {
      print(e);
    }
    return null;
  }

  Future<List<dynamic>?> getcategory() async {
    String uri = "http://localhost/LoRa_API/get_categoria.php";
    try
    {
      var response = await http.get(Uri.parse(uri));

      setState(() {
        categoryData = jsonDecode(response.body);
      });
    }
    catch(e)
    {
      print(e);
    }
    return null;
  }

  Future getimporte() async {
    String uri = "http://localhost/LoRa_API/view_data_importe.php";
    try
    {
      var response = await http.get(Uri.parse(uri));

      if(response.statusCode == 200) {
        
        setState(() {
          importeData = jsonDecode(response.body);
        });
      }
    }
    catch(e)
    {
      print(e);
    }
  }

  /* Future<List<dynamic>?> getmedidor() async {
    String uri = "http://localhost/LoRa_API/get_medidor.php";
    try
    {
      var response = await http.get(Uri.parse(uri));

      setState(() {
        medidorData = jsonDecode(response.body);
      });
    }
    catch(e)
    {
      print(e);
    }
    return [];
  } */

  /* Future<List<dynamic>?> getciudad() async {
    String uri = "http://localhost/LoRa_API/get_ciudad.php";
    try
    {
      var response = await http.get(Uri.parse(uri));

      setState(() {
        ciudadData = jsonDecode(response.body);
      });
    }
    catch(e)
    {
      print(e);
    }
    return null;
  } */


  Future<void> updatefactura(String idFactura) async {
    try
    {
      String uri = "http://localhost/LoRa_API/update_factura.php";

      var res = await http.post(Uri.parse(uri),
      body: {
        "id_Factura": idFactura,
        "descripcion": descripcion.text,
        "fecha": fechaE.toIso8601String(),
        "fechaLimite": fechaV.toIso8601String(),
        "ClienteID": selectedClienteValue!,
        "ImporteID": selectedImporteValue!,
        /* "MedidorID": selectedMedidorValue!, */
        "CategoriaID": selectedCategoriaValue!,
        /* "CiudadID": selectedCiudadValue!, */
      });
      var response = jsonDecode(res.body);
        if(response["success"] == "true")
        {
          print("Factura Actualizado");
          
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
    getimporte();
    getuser();
    /* getmedidor(); */
    getcategory();
    /* getciudad(); */
    /* getimporte(); */
    descripcion.text = widget.descripcion;
    fechaE = DateTime.parse(widget.fecha);
    fechaV = DateTime.parse(widget.fechaLimite);
    selectedImporteValue = widget.ImporteID;
    selectedClienteValue = widget.ClienteID;
    /* selectedMedidorValue = widget.MedidorID; */
    selectedCategoriaValue = widget.CategoriaID;
    /* selectedCiudadValue = widget.CiudadID; */
    super.initState();
  }

  String? selectedImporteValue;
  String? selectedClienteValue;
  /* String? selectedMedidorValue; */
  String? selectedCategoriaValue;
  /* String? selectedCiudadValue; */
  List<dynamic> importeData = [];
  List<dynamic> clienteData = [];
  /* List<dynamic> medidorData = []; */
  List<dynamic> categoryData = [];
  /* List<dynamic> ciudadData = []; */

  /* DateTime selectedDate = DateTime.now(); */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actualizar Factura')
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: descripcion,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Ingrese un Descripcion'),
              ),
            ),
          ),
          
          Text(
            '${fechaE.year}/${fechaE.month}/${fechaE.day}',
            style: TextStyle(fontSize: 32),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            child: Text('Seleccione Fecha de Emision'),
            onPressed: () async {
               DateTime? newDate = await showDatePicker(
                context: context, 
                initialDate: fechaE, 
                firstDate: DateTime(1900), 
                lastDate: DateTime(2100),
              );
              if (newDate == null) return;

              setState(() => fechaE = newDate);
            },
          ),
          
          Text(
            '${fechaV.year}/${fechaV.month}/${fechaV.day}',
            style: TextStyle(fontSize: 32),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            child: Text('Seleccione Fecha de Vencimiento'),
            onPressed: () async {
               DateTime? newDate = await showDatePicker(
                context: context, 
                initialDate: fechaV, 
                firstDate: DateTime(1900), 
                lastDate: DateTime(2100),
              );
              if (newDate == null) return;

              setState(() => fechaV = newDate);
            },
          ),

          Container(
            child: DropdownButton<String>(
              value: selectedClienteValue,
              icon: Icon(Icons.menu),
              style: TextStyle(color: Colors.black),
              underline: Container(
                height: 2,
                color: Colors.black,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  selectedClienteValue = newValue!;
                });
              },
              items: clienteData.map<DropdownMenuItem<String>>((dynamic category) {
                String UsuarioID = category['id_Usuario'].toString();
                String nombre = category['nombre'].toString();
                String text = '$UsuarioID - $nombre';
                return DropdownMenuItem<String>(
                  value: UsuarioID,
                  child: Text(text),
                );
              }).toList(),
            )
          ),

          Container(
            child: DropdownButton<String>(
              value: selectedImporteValue,
              icon: Icon(Icons.menu),
              style: TextStyle(color: Colors.black),
              underline: Container(
                height: 2,
                color: Colors.black,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  selectedImporteValue = newValue!;
                });
              },
              items: importeData.map<DropdownMenuItem<String>>((dynamic category) {
                String ImporteID = category['id_Importe'].toString();
                String descripcion = category['descripcion'].toString();
                String precio = category['precio'].toString();
                String CategoriaID = category['CategoriaID'].toString();
                String text = '$descripcion, $precio, $CategoriaID';
                return DropdownMenuItem<String>(
                  value: ImporteID,
                  child: Text(text),
                );
              }).toList(),
            )
          ),

          /* Container(
            child: DropdownButton<String>(
              value: selectedMedidorValue,
              icon: Icon(Icons.menu),
              style: TextStyle(color: Colors.black),
              underline: Container(
                height: 2,
                color: Colors.black,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  selectedMedidorValue = newValue!;
                });
              },
              items: medidorData.map<DropdownMenuItem<String>>((dynamic category) {
                String MedidorID = category['id_Medidor'].toString();
                String consumo = category['consumo'].toString();
                String text = '$MedidorID, $consumo';
                return DropdownMenuItem<String>(
                  value: MedidorID,
                  child: Text(text),
                );
              }).toList(),
            )
          ), */

          Container(
            child: DropdownButton<String>(
              value: selectedCategoriaValue,
              icon: Icon(Icons.menu),
              style: TextStyle(color: Colors.black),
              underline: Container(
                height: 2,
                color: Colors.black,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategoriaValue = newValue!;
                });
              },
              items: categoryData.map<DropdownMenuItem<String>>((dynamic category) {
                String CategoriaID = category['id_Categoria'].toString();
                String tipo = category['tipo'].toString();
                String text = '$CategoriaID, $tipo';
                return DropdownMenuItem<String>(
                  value: CategoriaID,
                  child: Text(text),
                );
              }).toList(),
            )
          ),

          /* Container(
            child: DropdownButton<String>(
              value: selectedCiudadValue,
              icon: Icon(Icons.menu),
              style: TextStyle(color: Colors.black),
              underline: Container(
                height: 2,
                color: Colors.black,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCiudadValue = newValue!;
                });
              },
              items: ciudadData.map<DropdownMenuItem<String>>((dynamic category) {
                String CiudadID = category['id_Ciudad'].toString();
                String nombre = category['nombre'].toString();
                String text = '$CiudadID, $nombre';
                return DropdownMenuItem<String>(
                  value: CiudadID,
                  child: Text(text),
                );
              }).toList(),
            )
          ), */

          Container(
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: (){
                updatefactura(widget.id_Factura.toString());
              }, 
              child: Text('Actualizar'),
            ),
          ),
        ],
      ),
    );
  }
}