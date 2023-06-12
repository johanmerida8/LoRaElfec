import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lora_app/MedidorCRUD/UpdateMedidor.dart';

class viewDataMedidorPage extends StatefulWidget {

  @override
  _viewDataMedidorPageState createState() => _viewDataMedidorPageState();
}

class _viewDataMedidorPageState extends State<viewDataMedidorPage> {

  List medidordata = [];

  Future<void> deletemedidor(String MedidorID) async 
  {
    String uri = "http://localhost/LoRa_API/delete_medidor.php";
    try
    {
      var res = await http.post(Uri.parse(uri),body:{
        "id_Medidor": MedidorID
      });
      var response = jsonDecode(res.body);
      if(response["success"] == "true")
        {
          print("Consumo Borrado");
          getmedidor();
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

  Future<void> getmedidor() async {
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
  }

  @override
  void initState() {
    // TODO: implement initState
    getmedidor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Consumos'),
      ),
      body: ListView.builder(
        itemCount: medidordata.length,
        itemBuilder: (context, index)
        {
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder:(context) => updateMedidorPage(
                        medidordata[index]["id_Medidor"],
                        medidordata[index]["consumo"],
                      )));
              },
              leading: Icon(
                CupertinoIcons.star, 
                color: Colors.yellow,
                ),
              title: Text(
                medidordata[index]["consumo"]
              ),
              /* subtitle: Text(
                categoriadata[index]["descripcion"]
              ), */
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
                                deletemedidor(medidordata[index]["id_Medidor"]);
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