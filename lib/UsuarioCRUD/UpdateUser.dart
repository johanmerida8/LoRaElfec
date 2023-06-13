import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


//Parte de Isaac del tarea de actualizacion de Sensor//


// ignore: must_be_immutable
class UpdateUser extends StatefulWidget {
  
  String id_Usuario;
  String nombre;
  /* String apellido; */
  String correo;
  String contrasena;
  String RoleID;
  String localidad;
  String consumo;
  


  UpdateUser(this.id_Usuario, this.nombre, this.correo, this.contrasena, this.RoleID, this.localidad, this.consumo);

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}


class _UpdateUserState extends State<UpdateUser> {

  TextEditingController username = TextEditingController();
  /* TextEditingController surname = TextEditingController(); */
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController localidad = TextEditingController();
  TextEditingController consumo = TextEditingController();
  /* TextEditingController confirm = TextEditingController(); */

  Future<List<dynamic>?> getrol() async {
    String uri = "http://localhost/LoRa_API/get_role.php";
    try
    {
      var response = await http.get(Uri.parse(uri));

      setState(() {
        rolData = jsonDecode(response.body);
      });
    }
    catch(e)
    {
      print(e);
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    getrol();
    username.text = widget.nombre;
    /* surname.text = widget.apellido; */
    email.text = widget.correo;
    pass.text = widget.contrasena;
    /* confirm.text = widget.contrasena; */
    selectedRolValue = widget.RoleID;
    /* selectedRolValue ??= rolData.isNotEmpty ? rolData[0]['id_Role'].toString() : null; */
    localidad.text = widget.localidad;
    consumo.text = widget.consumo;
  }

  Future<void> updateuser(String UserID) async {
    try
    {
      String uri = "http://localhost/LoRa_API/admin_update_user.php";

      var res = await http.post(Uri.parse(uri),
      body: {
        "id_Usuario": UserID,
        "nombre": username.text,
        /* "apellido": surname.text, */
        "correo": email.text,
        "contraseña": pass.text,
        "RoleID": selectedRolValue!,
        "localidad": localidad.text,
        "consumo": consumo.text,
      });
      var response = jsonDecode(res.body);
        if(response["success"] == "true")
        {
          print("Usuario Actualizado");
          
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

  String? selectedRolValue;
  List<dynamic> rolData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actualizar Usuario')
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: username,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Ingrese su Nombre de Usuario'),
              ),
            ),
          ),
          /* Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: surname,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Ingrese su Apellido'),
              ),
            ),
          ), */
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: email,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Ingrese un Correo'),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: pass,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Ingrese su Contraseña'),
              ),
              obscureText: true,
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: localidad,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Ingrese su localidad'),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: consumo,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Ingrese su consumo'),
              ),
            ),
          ),
          /* Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: confirm,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Ingrese su Contraseña'),
              ),
              obscureText: true,
              validator: (value) {
                if(value == null || value.isEmpty) {
                  return 'Porfavor, Digite su Contraseña.';
                } else if (value != pass.text) {
                  return 'Contraseña no corresponde.';
                }
                return null;
              },
            ),
          ), */
          Container(
            child: DropdownButton<String>(
              value: selectedRolValue,
              icon: Icon(Icons.menu),
              style: TextStyle(color: Colors.black),
              underline: Container(
                height: 2,
                color: Colors.black,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  selectedRolValue = newValue!;
                });
              },
              items: rolData.toSet().map<DropdownMenuItem<String>>((dynamic category) {
                String RoleID = category['id_Role'].toString();
                String tipo = category['tipo'].toString();
                String text = '$RoleID, $tipo';
                return DropdownMenuItem<String>(
                  value: RoleID,
                  child: Text(text),
                );
              }).toList(),
            )
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: (){
                updateuser(widget.id_Usuario.toString());
              }, 
              child: Text('Actualizar'),
            ),
          ),
        ],
      ),
    );
  }
}