import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lora_app/MultaCRUD/updateMulta.dart';

class viewDataMultaPage extends StatefulWidget {
  viewDataMultaPage({super.key});

  @override
  _viewDataMultaPageState createState() => _viewDataMultaPageState();
}

class _viewDataMultaPageState extends State<viewDataMultaPage> {

  List multadata = [];

  Future<void> deletemulta(String id_Multa) async 
  {
    String uri = "http://localhost/LoRa_API/delete_multa.php";
    try
    {
      var res = await http.post(Uri.parse(uri), body: {
        "id_Multa": id_Multa
      });
      var response = jsonDecode(res.body);
      if(response["success"] == "true")
        {
          print("Multa Borrado");
          getmulta();
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

  Future<void> getmulta() async {
    String uri = "http://localhost/LoRa_API/view_data_multa.php";
    try
    {
      var response = await http.get(Uri.parse(uri));

      setState(() {
        multadata = jsonDecode(response.body);
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
    getmulta();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Data Multas')
      ),
      body: ListView.builder(
        itemCount: multadata.length,
        itemBuilder: (context, index)
        {
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:(context) => updateMultaPage(
                      multadata[index]["id_Multa"],
                      multadata[index]["cliente"],
                      multadata[index]["ci"],
                      multadata[index]["direccion"],
                      multadata[index]["numeroMedidor"],
                      multadata[index]["descripcion"],
                      multadata[index]["monto"],
                      multadata[index]["fecha"],
                      multadata[index]["fechaLimite"],
                      multadata[index]["estado"],
                    )
                  ),
                );
              },
              leading: Icon(
                CupertinoIcons.star,
                color: Colors.yellow,
              ),
              title: Text(
                multadata[index]["cliente"]
              ),
              subtitle: Text(
                multadata[index]["descripcion"]
              ),
              trailing:
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    deletemulta(multadata[index]["id_Multa"]);
                },
              ),
            ),
          );
        }
      ),
    );
  }
}