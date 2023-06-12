
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lora_app/Login%20&%20Signup/SignUpPage.dart';
import 'package:http/http.dart' as http;
import 'package:lora_app/web/home_page_admin.dart';
import 'package:lora_app/web/home_page_cliente.dart';
import 'package:lora_app/web/home_page_web.dart';
// ignore: unused_import
import 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatefulWidget {

  
  
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  List<dynamic> categorydata = [];


  Future getRoles() async {
    String uri = "http://localhost/LoRa_API/get_role.php";
    try
    {
      var response = await http.get(Uri.parse(uri));

      if(response.statusCode == 200) {
        
        setState(() {
          categorydata = jsonDecode(response.body);
        });
      }
    }
    catch(e)
    {
      print(e);
    }
  }

  Future login() async {
    String uri = "http://localhost/LoRa_API/login.php";
    try
    {
      var response = await http.get(Uri.parse(uri));

      if(response.statusCode == 200) {
        
        setState(() {
          categorydata = jsonDecode(response.body);
        });
      }
    }
    catch(e)
    {
      print(e);
    }
  }

  Future getUser(String email, String password) async {
  String uri = "http://localhost/LoRa_API/get_user.php";

  try {
    var response = await http.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      var users = jsonDecode(response.body);

      var user = users.firstWhere(
        (user) =>
            user['correo'] == email && user['contraseña'] == password,
        orElse: () => null,
      );

      if (user != null) {

        print('Login Successful');

        String nombre = user['nombre'];
        String userRole = user['RoleID'] ?? '';

        /* SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt('RoleID', 1); */

        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(builder: (context) {
            if(int.parse(userRole) == 1) {
              return homePageAdminWeb(nombre: nombre);
              // ignore: dead_code
              print("Home Page Admin");
            } else if (int.parse(userRole) == 3) {
              return homePageClienteWeb(nombre: nombre);
              // ignore: dead_code
              print("Home Page Cliente");
            } 
            else {
              return homePageWeb(nombre: nombre, userRole: userRole);
              // ignore: dead_code
              print("Home Page Regular");
            }
          }),
        );

      } else {
        print('Invalid email or password');
      }
    } 
    else 
    {
      print('Failed to fetch user details. Status code: ${response.statusCode}');
    }
    } 
    catch (e) 
    {
      print(e);
    }
  }


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar Sesion'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10.0),
                child: Image.asset('assets/elfec.png', width: 100, height: 100),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: email,
                decoration: InputDecoration(
                  labelText: 'Correo',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10.0),
              TextField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  getUser(email.text, password.text);
                },
                child: Text('Iniciar Sesion'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage()), 
                  );
                },
                child: Text("Aun no tiene cuenta? Registrarse"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





