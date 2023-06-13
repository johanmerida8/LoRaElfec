import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lora_app/UsuarioCRUD/UpdateUser.dart';
import 'package:http/http.dart' as http;


//Parte de Isaac del tarea de ver datos de Sensor//
//modificado

class ViewUser extends StatefulWidget {
  const ViewUser({super.key});

  @override
  State<ViewUser> createState() => _ViewUserState();
}

//Parte de Isaac//

class _ViewUserState extends State<ViewUser> {

  List userData = [];

  Future deleteuser(String UserID) async 
  {
    String uri = "http://localhost/LoRa_API/delete_user.php";
    try
    {
      var res = await http.post(Uri.parse(uri),body:{
        "id_Usuario": UserID
      });
      var response = jsonDecode(res.body);
      if(response["success"] == "true")
        {
          print("Usuario Borrado");
          getuser();
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

  Future getuser() async {
    String uri = "http://localhost/LoRa_API/get_user.php";
    try
    {
      var response = await http.get(Uri.parse(uri));

      setState(() {
        userData = jsonDecode(response.body);
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
    getuser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Usuarios'),
      ),
      body: ListView.builder(
        itemCount: userData.length,
        itemBuilder: (context, index){
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:(context) => UpdateUser(
                      userData[index]["id_Usuario"],
                      userData[index]["nombre"],
                      userData[index]["correo"],
                      userData[index]["contraseña"],
                      userData[index]["RoleID"],
                      userData[index]["localidad"],
                      userData[index]["consumo"],
                      
                    ),
                  ),
                );
              },
              leading: Icon(
                CupertinoIcons.star,
                color: Colors.yellow,
              ),
              title: Text(
                userData[index]["nombre"]
              ),
              subtitle: Text(
                
                userData[index]["correo"],
                
              ),
              
              trailing: IconButton(
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
                                deleteuser(userData[index]["id_Usuario"]);
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
          }
        ),
      );
    }
  }