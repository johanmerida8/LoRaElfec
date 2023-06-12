import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lora_app/CiudadCRUD/UpdateCiudad.dart';

class viewDataCiudadPage extends StatefulWidget {

  @override
  _viewDataCiudadPageState createState() => _viewDataCiudadPageState();
}

class _viewDataCiudadPageState extends State<viewDataCiudadPage> {

  List ciudaddata = [];

  Future<void> deleteciudad(String CiudadID) async 
  {
    String uri = "http://localhost/LoRa_API/delete_ciudad.php";
    try
    {
      var res = await http.post(Uri.parse(uri),body:{
        "id_Ciudad": CiudadID
      });
      var response = jsonDecode(res.body);
      if(response["success"] == "true")
        {
          print("Ciudad Borrado");
          getciudad();
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

  Future<void> getciudad() async {
    String uri = "http://localhost/LoRa_API/get_ciudad.php";
    try
    {
      var response = await http.get(Uri.parse(uri));

      setState(() {
        ciudaddata = jsonDecode(response.body);
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
    getciudad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Localidades'),
      ),
      body: ListView.builder(
        itemCount: ciudaddata.length,
        itemBuilder: (context, index)
        {
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder:(context) => updateCiudadPage(
                        ciudaddata[index]["id_Ciudad"],
                        ciudaddata[index]["nombre"],
                      )));
              },
              leading: Icon(
                CupertinoIcons.star, 
                color: Colors.yellow,
                ),
              title: Text(
                ciudaddata[index]["nombre"]
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
                                deleteciudad(ciudaddata[index]["id_Ciudad"]);
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