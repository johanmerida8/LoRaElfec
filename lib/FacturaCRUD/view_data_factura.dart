import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lora_app/FacturaCRUD/UpdateFactura.dart';

class viewDataFacturaPage extends StatefulWidget {
  viewDataFacturaPage({Key? key}) : super(key: key);

  @override
  _viewDataFacturaPageState createState() => _viewDataFacturaPageState(); 
}

//Parte de Johan tarea de factura de ver datos//

class _viewDataFacturaPageState extends State<viewDataFacturaPage> {

  List facturadata = [];
  List importedata = [];
  List clientedata = [];
  /* List medidordata = []; */
  List categoriadata = [];
  /* List ciudadData = []; */

  Future<void> deletefactura(String id_Factura) async 
  {
    String uri = "http://localhost/LoRa_API/delete_factura.php";
    try
    {
      var res = await http.post(Uri.parse(uri),body:{
        "id_Factura": id_Factura
      });
      var response = jsonDecode(res.body);
      if(response["success"] == "true")
        {
          print("Factura Borrado");
          getfactura();
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

  Future<List<dynamic>?> getcliente() async {
    String uri = "http://localhost/LoRa_API/get_user.php";
    try
    {
      var response = await http.get(Uri.parse(uri));

      setState(() {
        clientedata = jsonDecode(response.body);
      });
    }
    catch(e)
    {
      print(e);
    }
    return [];
  }

  Future<List<dynamic>> getimporte() async {
    String uri = "http://localhost/LoRa_API/view_data_importe.php";
    try
    {
      var response = await http.get(Uri.parse(uri));

      setState(() {
        importedata = jsonDecode(response.body);
      });
    }
    catch(e)
    {
      print(e);
    }
    return [];
  }

  /* Future<List<dynamic>?> getmedidor() async {
    String uri = "http://localhost/LoRa_API/get_medidor.php";
    try
    {
      var response = await http.get(Uri.parse(uri));

      setState(() {
        medidordata = jsonDecode(response.body);
      });
    }
    catch(e)
    {
      print(e);
    }
    return [];
  } */

  Future<List<dynamic>?> getcategory() async {
    String uri = "http://localhost/LoRa_API/get_categoria.php";
    try
    {
      var response = await http.get(Uri.parse(uri));

      setState(() {
        categoriadata = jsonDecode(response.body);
      });
    }
    catch(e)
    {
      print(e);
    }
    return null;
  }

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

  @override
  void initState() {
    // TODO: implement initState
    getimporte();
    getfactura();
    getcliente();
    /* getmedidor(); */
    getcategory();
    /* getciudad(); */
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Facturas'),
      ),
      body: importedata.isNotEmpty ? ListView.builder(
        itemCount: facturadata.length,
        itemBuilder: (context, index) {
          // ignore: unused_local_variable
          var factura = facturadata[index];
          var clienteID = factura["ClienteID"];
          var cliente = clientedata.firstWhere((client) => client["id_Usuario"] == clienteID, orElse: () => null);
          var importeID = factura["ImporteID"];
          var importe = importedata.firstWhere((importe) => importe["id_Importe"] == importeID, orElse: () => null);
          /* var medidorID = factura["MedidorID"];
          var medidor = medidordata.firstWhere((medidor) => medidor["id_Medidor"] == medidorID, orElse: () => null); */
          var categoryID = factura["CategoriaID"];
          var category = categoriadata.firstWhere((category) => category["id_Categoria"] == categoryID, orElse: () => null);
          /* var ciudadID = factura["CiudadID"];
          var ciudad = ciudadData.firstWhere((ciudad) => ciudad["id_Ciudad"] == ciudadID, orElse: () => null); */
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder:(context) => updateFacturaPage(
                        facturadata[index]["id_Factura"],
                        facturadata[index]["descripcion"],
                        facturadata[index]["fecha"],
                        facturadata[index]["fechaLimite"],
                        facturadata[index]["ClienteID"],
                        facturadata[index]["ImporteID"],
                        /* facturadata[index]["MedidorID"], */
                        facturadata[index]["CategoriaID"],
                        /* facturadata[index]["CiudadID"], */
                      )));
              },
              leading: Icon(
                CupertinoIcons.star, 
                color: Colors.yellow,
                ),

              title: Text('${cliente != null ? cliente["nombre"] : "Cargando..."}'),
              
              subtitle: importe != null && category != null
              ? Text('${factura["fecha"]} ${factura["fechaLimite"]} ${importe["descripcion"]} ${importe["precio"]} ${category["tipo"]}') : Text("Cargando..."),
              trailing: 
                IconButton(
                  icon: Icon(Icons.delete), 
                  onPressed: (){
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Confirmar'),
                          content: Text('Estas seguro de borrar?'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Cancelar'),
                              onPressed: (){
                                Navigator.of(context).pop();
                              }, 
                            ),
                            TextButton(
                              child: Text('Borrar'),
                              onPressed: (){
                                deletefactura(facturadata[index]["id_Factura"]);
                                Navigator.of(context).pop();
                              }, 
                            )
                          ],
                        );
                      }
                    );
                  },
                ),
              ),
            );
          },
        ):null,
      );
    }
  }
