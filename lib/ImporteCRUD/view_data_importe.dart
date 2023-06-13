import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:lora_app/ImporteCRUD/UpdateImporte.dart';


//Parte de Yamil tarea de importe de ver datos//

class viewDataImportePage extends StatefulWidget {
  
  @override
  _viewDataImportePageState createState() => _viewDataImportePageState();
}

class _viewDataImportePageState extends State<viewDataImportePage> {

  List importedata = [];

  Future deleteimporte(String idImporte) async 
  {
    String uri = "http://localhost/LoRa_API/delete_importe.php";
    try
    {
      var res = await http.post(Uri.parse(uri),body:{
        "id_Importe": idImporte
      });
      var response = jsonDecode(res.body);
      if(response["success"] == "true")
        {
          print("Importe Borrado");
          getimporte();
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

  Future getimporte() async {
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
  }

  @override
  void initState() {
    // TODO: implement initState
    getimporte();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Importes'),
      ),
      body: ListView.builder(
        itemCount: importedata.length,
        itemBuilder: (context, index)
        {
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder:(context) => updateImportePage(
                        importedata[index]["id_Importe"],
                        importedata[index]["descripcion"],
                        importedata[index]["precio"],
                        importedata[index]["CategoriaID"]
                )));
              },
              leading: Icon(
                CupertinoIcons.star, 
                color: Colors.yellow,
                ),
              title: Text(
                importedata[index]["descripcion"]
              ),
              subtitle: Text(
                importedata[index]["precio"]
              ),
              
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
                                deleteimporte(importedata[index]["id_Importe"]);
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
        ),
      );
    }
  }

