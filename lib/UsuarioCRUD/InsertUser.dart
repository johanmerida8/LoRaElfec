import 'dart:convert';

// ignore: unnecessary_import
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lora_app/UsuarioCRUD/ViewUser.dart';


//Parte de Isaac del tarea de insercion de Sensor//

class InsertUsuario extends StatefulWidget {

  @override
  State<InsertUsuario> createState() => _InsertUsuarioState();
}

class _InsertUsuarioState extends State<InsertUsuario> {

  /* final _formKey = GlobalKey<FormState>(); */
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
  }

  Future insertuser() async 
  {
    if(username.text.isNotEmpty&& email.text.isNotEmpty && pass.text.isNotEmpty && localidad.text.isNotEmpty && consumo.text.isNotEmpty && selectedRolValue != null)
    {
      try{
        if(selectedRolValue == null) {
          print("Por favor, seleccione una categoría");
          return;
        }
        String uri = "http://localhost/LoRa_API/admin_create_user.php";
        var res = await http.post(Uri.parse(uri), body: {
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
          print("Usuario Insertado");
          username.clear();
          /* surname.clear(); */
          email.clear();
          pass.clear();
          localidad.clear();
          consumo.clear();
          /* confirm.clear(); */
          setState(() {
            selectedRolValue = null;
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

  String? selectedRolValue;
  List<dynamic> rolData = [];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simulacion Sensor')
      ),

      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: username,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Ingrese un Nombre de Usuario'),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor, Ingrese un Nombre de Usuario';
                }
                return null;
              },
            ),
          ),
          /* Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: surname,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Ingrese un Apellido'),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor, Ingrese un Apellido';
                }
                return null;
              },
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
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor, Ingrese un Correo';
                }
                return null;
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: pass,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Ingrese un Contraseña'),
              ),
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor, Ingrese un Contraseña';
                }
                return null;
              },
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
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor, Ingrese su localidad';
                }
                return null;
              },
            ),
          ),

           Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: consumo,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Ingrese un Consumo'),
              ),              
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor, Ingrese un Consumo';
                }
                return null;
              },
            ),
          ),
          /* Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: confirm,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Confirmar Contraseña'),
              ),
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Por favor, Digite su Contraseña de nuevo.';
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
              items: [
                DropdownMenuItem<String>(
                  value: null,
                  child: Text('Seleccione'),
                ),
                  ...rolData.map<DropdownMenuItem<String>>((dynamic category) {
                    String RoleID = category['id_Role'].toString();
                    String tipo = category['tipo'].toString();
                    String text = '$tipo';
                    return DropdownMenuItem<String>(
                      value: RoleID,
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
                insertuser();
              }, 
              child: Text('Insertar'),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Builder(
              builder: (cont){
                return ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder:(context) => ViewUser()));
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