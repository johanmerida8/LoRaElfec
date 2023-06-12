import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// ignore: unused_import
import 'package:lora_app/FacturaCRUD/custom_dropDown.dart';
// ignore: unused_import
import 'package:lora_app/FacturaCRUD/custom_input_field.dart';
/* import 'package:lora_app/FacturaCRUD/totalLabel.dart'; */
import 'package:lora_app/FacturaCRUD/view_data_factura.dart';

class InsertFacturaPage extends StatefulWidget {
  InsertFacturaPage({Key? key}) : super(key: key);

  @override
  _InsertFacturaPageState createState() => _InsertFacturaPageState();
}

class _InsertFacturaPageState extends State<InsertFacturaPage> {
  TextEditingController descripcion = TextEditingController();
  TextEditingController importe = TextEditingController();
  TextEditingController consumo = TextEditingController();
  TextEditingController tipo = TextEditingController();
  TextEditingController localidad = TextEditingController();

  Usuario ud = new Usuario("", "", 0, "");

  DateTime fechaE = DateTime.now();
  DateTime fechaV = DateTime.now();
  List<Usuario> listUsuario = [];

  Future<List<dynamic>?> getuser() async {
    String uri = "http://localhost/LoRa_API/get_user.php";
    try {
      var response = await http.get(Uri.parse(uri));

      setState(() {
        listUsuario = clienteData = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
    return null;
  }

  /* Future<List<dynamic>?> getciudad() async {
    String uri = "http://localhost/LoRa_API/get_ciudad.php";
    try {
      var response = await http.get(Uri.parse(uri));

      setState(() {
        ciudadData = jsonDecode(response.body);

        /* listUsuario =
            Usuario('s', 'sas').convertirListaJson(jsonDecode(response.body)); */
      });
    } catch (e) {
      print(e);
    }
    return null;
  } */

  Future<List<dynamic>?> getcategory() async {
    String uri = "http://localhost/LoRa_API/get_categoria.php";
    try {
      var response = await http.get(Uri.parse(uri));

      setState(() {
        categoryData = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<List<dynamic>?> getimporte() async {
    String uri = "http://localhost/LoRa_API/view_data_importe.php";
    try {
      var response = await http.get(Uri.parse(uri));

      setState(() {
        importeData = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
    return null;
  }

  /* Future<List<dynamic>?> getmedidor() async {
    String uri = "http://localhost/LoRa_API/get_medidor.php";
    try {
      var response = await http.get(Uri.parse(uri));

      setState(() {
        medidorData = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
    return [];
  } */

  //[{"0":"39","id_Usuario":"39","1":"pablo2023","nombre":"pablo2023","2":"pablo2023@gmail.com","correo":"pablo2023@gmail.com","3":"12
//3","contrase\u00f1a":"123","4":"3","RoleID":"3","5":"Punata","localidad":"Punata","6":"5","consumo":"5"}]
//
  Future<Usuario?> getInformation(String id) async {
    String url = 'http://localhost/LoRa_API/userbyid.php?id=' + id;
    print(url);
    //try {
    var response = await http.get(Uri.parse(url));
    /* var response = await http.post(url); */
    //if (response.statusCode == 200) {
    // Los datos se han recibido correctamente

    List<dynamic> jsonData = json.decode(response.body);
    List<Usuario> usuarios =
        jsonData.map((json) => Usuario.fromJson(json)).toList();

    // Acceder a los datos del primer usuario en la lista
    Usuario primerUsuario = usuarios.first;
    print('Nombre: ${primerUsuario.name}, Correo: ${primerUsuario.name}');

    /*var data = response.body;
    print(data);
    var jsonData = json.decode(response.body);
     List<Usuario> usuarios = jsonData.map((json) => Usuario.fromJson(json)).toList();
         
    
    // Procesa los datos recibidos como desees
    var usuario = usuarios.first;*/

    print(primerUsuario);
    return primerUsuario;
    /*} else {
        // Ocurrió un error al recibir los datos
        print('Error en la solicitud POST: ${response.statusCode}');
      }*/
    //} catch (e) {
    // print(e);
    //}
    //return null;
    /* return []; */
  }

  @override
  void initState() {
    super.initState();
    getuser();
    /* getmedidor(); */
    getimporte();
    getcategory();
    /* getciudad(); */
  }

  Future<void> insertfactura() async {
    if (descripcion.text.isNotEmpty && selectedClienteValue != null &&selectedImporteValue != null && selectedCategoriaValue != null) {
      try {
        if (selectedImporteValue == null || selectedClienteValue == null || selectedCategoriaValue == null) {
          print("Por favor, seleccione una categoría");
          return;
        }
        String uri = "http://localhost/LoRa_API/insert_factura.php";
        var res = await http.post(Uri.parse(uri), body: {
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
        if (response["success"] == "true") {
          print("Factura Insertado");
          descripcion.clear();
          setState(() {
            selectedImporteValue = null;
            selectedClienteValue = null;
            /* selectedMedidorValue = null; */
            selectedCategoriaValue = null;
            /* selectedCiudadValue = null; */
          });
        } else {
          print("hubo algun fallo");
        }
      } catch (e) {
        print(e);
      }
    } else {
      print("Porfavor llene todo los campos");
    }
  }

  String? selectedClienteValue;
  String? selectedImporteValue;
  /* String? selectedMedidorValue; */
  String? selectedCategoriaValue;
  /* String? selectedCiudadValue; */

  List<dynamic> importeData = [];
  List<dynamic> clienteData = [];
  List<dynamic> categoryData = [];
  /* List<dynamic> medidorData = []; */
  /* List<dynamic> ciudadData = []; */
  String textFieldValue1 = 'Nombre Automatico';
  String textFieldValue2 = 'Localidad Automatica';
  String textFieldValue3 = 'Consumo Automatico';

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insertar Factura'),
      ),
      body: Column(
        children: [
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
            child: Center(
              child: DropdownButton<String>(
                value: selectedClienteValue,
                icon: Icon(Icons.menu),
                style: TextStyle(color: Colors.black),
                underline: Container(
                  height: 2,
                  color: Colors.black,
                ),
                onChanged: (String? newValue) async {
                  //setState(() {});
                  selectedClienteValue = newValue!;
                  Usuario? u = await getInformation(newValue);
                  setState(() {
                    //if (u == null) return;
                    ud = u!;
                    textFieldValue1 = ud.name;
                    textFieldValue2 = ud.localidad;
                    textFieldValue3 = ud.consumo.toString();
                  });

                  print(u);
                },
                items: [
                  DropdownMenuItem<String>(
                    value: null,
                    child: Text('Seleccione un Cliente'),
                  ),
                  ...clienteData
                      .map<DropdownMenuItem<String>>((dynamic category) {
                        String UserID = category['id_Usuario'].toString();
                        String nombre = category['nombre'].toString();
                        /* String? apellido = category['apellido'].toString(); */
                        String text = '$UserID -$nombre';
                        return DropdownMenuItem<String>(
                          value: UserID,
                          child: Text(text),
                        );
                      })
                      .toSet()
                      .toList(),
                ],
              ),
            ),
          ),
          
          TextField(
            controller: TextEditingController(text: textFieldValue1),
            onChanged: (value) {
              setState(() {
                textFieldValue1 = value;
              });
            },
            decoration: InputDecoration(
              labelText: 'Nombre',
              hintText: 'Nombre',
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(),
            ),
          ),
          TextField(
            controller: TextEditingController(text: textFieldValue2),
            onChanged: (value) {
              setState(() {
                textFieldValue2 = value;
              });
            },
            decoration: InputDecoration(
              labelText: 'Localidad',
              hintText: 'Nombre',
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(),
            ),
          ),
          
          TextField(
            controller: TextEditingController(text: textFieldValue3),
            onChanged: (value) {
              setState(() {
                textFieldValue3 = value;
              });
            },
            decoration: InputDecoration(
              labelText: 'Consumo',
              hintText: 'Nombre',
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(),
            ),
          ),

          
          Container(
            child: Center(
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
                items: [
                  DropdownMenuItem<String>(
                    value: null,
                    child: Text('Seleccione un Importe'),
                  ),
                  ...importeData
                      .map<DropdownMenuItem<String>>((dynamic category) {
                        String? ImporteID = category['id_Importe'].toString();
                        String? descripcion =category['descripcion'].toString();
                        String? precio = category['precio'].toString();
                        String? CategoriaID = category['CategoriaID'].toString();
                        String? text = '$descripcion, $precio, ${CategoriaID.toString()}';
                        return DropdownMenuItem<String>(
                          value: ImporteID,
                          child: Text(text),
                        );
                      })
                      .toSet()
                      .toList(),
                ],
              ),
            ),
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
              items: [
                DropdownMenuItem<String>(
                  value: null,
                  child: Text('Seleccione un Medidor'),
                ),
                ...medidorData
                    .map<DropdownMenuItem<String>>((dynamic category) {
                      String MedidorID = category['id_Medidor'].toString();
                      String consumo = category['consumo'].toString();
                      String text = '$MedidorID - $consumo';
                      return DropdownMenuItem<String>(
                        value: MedidorID,
                        child: Text(text),
                      );
                    })
                    .toSet()
                    .toList(),
              ],
            ),
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
              items: [
                DropdownMenuItem<String>(
                  value: null,
                  child: Text('Seleccione un Tipo'),
                ),
                ...categoryData
                    .map<DropdownMenuItem<String>>((dynamic category) {
                      String CategoriaID = category['id_Categoria'].toString();
                      String tipo = category['tipo'].toString();
                      String text = '$CategoriaID - $tipo';
                      return DropdownMenuItem<String>(
                        value: CategoriaID,
                        child: Text(text),
                      );
                    })
                    .toSet()
                    .toList(),
              ],
            ),
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
              items: [
                DropdownMenuItem<String>(
                  value: null,
                  child: Text('Seleccione un Localidad'),
                ),
                ...ciudadData
                    .map<DropdownMenuItem<String>>((dynamic category) {
                      String CiudadID = category['id_Ciudad'].toString();
                      String nombre = category['nombre'].toString();
                      String text = '$CiudadID - $nombre';
                      return DropdownMenuItem<String>(
                        value: CiudadID,
                        child: Text(text),
                      );
                    })
                    .toSet()
                    .toList(),
              ],
            ),
          ), */
          Container(
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                insertfactura();
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
          Container(
            margin: EdgeInsets.all(10),
            child: Builder(
              builder: (cont) {
                return ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => viewDataFacturaPage()));
                    },
                    child: Text("Ver Datos"));
              },
            ),
          ),
        ],
      ),
    );
  }
}

/* class InvoiceDisplayPage extends StatelessWidget {
  final String cliente;
  final String descripcion;
  final String? ImporteID;
  final String? UsuarioID;

  InvoiceDisplayPage({required this.cliente, required this.descripcion, required this.ImporteID, required this.UsuarioID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles Factura'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cliente: $cliente',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text('Descripcion: $descripcion'),
            SizedBox(height: 16),
            Text('Importe: $ImporteID'),
            SizedBox(height: 16),
            Text('Usuario: $UsuarioID'),
          ],
        ),
      ),
    );
  }
} */

class Country {
  final String name;
  final String extensionNumber;

  Country(this.name, this.extensionNumber);

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(json['name'], json['extensionNumber']);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'extensionNumber': extensionNumber,
      };
}

/*
id_Usuario'].toString();
                        String nombre = category['nombre
*/

class Usuario {
  final String name;
  final String id;
  final String localidad;
  final int consumo;

  Usuario(this.id, this.name, this.consumo, this.localidad);

 
  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(json['id_Usuario'], json['nombre'],
        int.parse(json['consumo']), json['localidad']);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id_Usuario': id,
        'nombre': name,
      };
}
