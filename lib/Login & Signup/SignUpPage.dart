import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lora_app/Login%20&%20Signup/LoginPage.dart';
import 'package:http/http.dart' as http;


//Parte de Isaac tarea de registro de usuario//

class SignUpPage extends StatefulWidget {
  
  @override
  _SignUpPageState createState() => _SignUpPageState();
}


class _SignUpPageState extends State<SignUpPage>{

  final _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  /* TextEditingController surname = TextEditingController(); */
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  
  
  

  Future insertuser() async 
  {
    if(name.text.isNotEmpty && email.text.isNotEmpty && pass.text.isNotEmpty)
    {
      try{
        String uri = "http://localhost/LoRa_API/insert_user.php";
        /* var dio = Dio();
        dio.options.connectTimeout = Duration(milliseconds: 10000); // 5 seconds
        dio.options.receiveTimeout = Duration(milliseconds: 10000); // 5 seconds */
        var res = await http.post(Uri.parse(uri), body: {
          "nombre": name.text,
          "correo": email.text,
          "contraseña": pass.text,
          /* "confirmar": confirm.text, */ 
        });

        var response = jsonDecode(res.body);
        if(response["success"] == "true")
        {
          print("Usuario Insertado");
          name.clear();
          email.clear();
          pass.clear();
          
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrarse'),
      ),
      
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Porfavor llene los campos para poder crear una cuenta',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: name,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ), 
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Porfavor, Introduzca una Nombre.';
                  }
                  return null;
                },
              ),
              /* SizedBox(height: 16.0),
              TextFormField(
                controller: surname,
                decoration: InputDecoration(
                  labelText: 'Apellido',
                  border: OutlineInputBorder(),
                ), 
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Porfavor, Introduzca una Apellido.';
                  }
                  return null;
                },
              ), */
              SizedBox(height: 16.0),
              TextFormField(
                controller: email,
                decoration: InputDecoration(
                  labelText: 'Correo',
                  border: OutlineInputBorder(),
                ), 
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Porfavor, Introduzca una Correo.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: pass,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ), 
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Porfavor, Introduzca una Contraseña.';
                  }
                  return null;
                },
              ),
              /* SizedBox(height: 16.0),
              TextFormField(
                controller: confirm,
                decoration: InputDecoration(
                  labelText: 'Confirmar contraseña',
                  border: OutlineInputBorder(),
                ), 
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Porfavor, Digite su Contraseña de nuevo.';
                  } else if (value != pass.text) {
                    return 'Contraseña no corresponde.';
                  }
                  return null;
                },
              ), */
              
              SizedBox(height: 16.0),
              Text(
                'Al crear una cuenta, acepta nuestros Términos y privacidad.',
                style: TextStyle(fontSize: 14.0),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: (){
                  insertuser();
                },
                child: Text('Registrar'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text("¿Ya tienes una cuenta? Iniciar Sesion")
              ),
            ],
          ),
        ),
      )
    );
  }
}

