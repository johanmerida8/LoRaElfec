/* import 'dart:convert'; */

/* import 'dart:convert'; */

import 'dart:convert';

import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:google_fonts/google_fonts.dart';
import 'package:lora_app/CategoriaCRUD/InsertCategoria.dart';
import 'package:lora_app/CiudadCRUD/InsertCiudad.dart';
// ignore: unused_import
import 'package:lora_app/FacturaCRUD/DetalleFactura.dart';
import 'package:lora_app/FacturaCRUD/InsertFactura.dart';
/* import 'package:lora_app/ImporteCRUD/CategoriaImporte.dart'; */
import 'package:lora_app/ImporteCRUD/InsertImporte.dart';
import 'package:lora_app/Login%20&%20Signup/LoginPage.dart';
import 'package:lora_app/MedidorCRUD/InsertMedidor.dart';
import 'package:lora_app/UsuarioCRUD/InsertUser.dart';

/* import 'package:lora_app/MultaCRUD/InsertMulta.dart'; */
import 'package:lora_app/components.dart';
/* import 'package:lora_app/NavPages/FinesPage.dart'; */
// ignore: unused_import
import 'package:lora_app/NavPages/HomePage.dart';

import 'package:lora_app/NavPages/BillingPage.dart';
/* import 'package:lora_app/NavPages/HistoryPage.dart'; */

import 'package:http/http.dart' as http;
import 'package:lora_app/mobile/home_page_mobile.dart';


//Parte de Johan tarea de la pagina principal usuario regular//

class homePageWeb extends StatefulWidget {
  

  final String nombre;
  /* final String apellido; */
  final String userRole;
  

  homePageWeb({required this.nombre, required this.userRole});

  @override
  _homePageWebState createState() => _homePageWebState();
}

class _homePageWebState extends State<homePageWeb> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  List<dynamic> roldata = [];
  List<dynamic> userdata = [];


  Future getRoles() async {
    String uri = "http://localhost/LoRa_API/get_role.php";
    try
    {
      var response = await http.get(Uri.parse(uri));

      if(response.statusCode == 200) {
        
        setState(() {
          roldata = jsonDecode(response.body);
        });
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
        userdata = jsonDecode(response.body);
      });
    }
    catch(e)
    {
      print(e);
    }
  }

    @override
    void initState() {
      super.initState();
      getRoles();
      getuser();
    }



    Future logout() async {

      String uri = "http://localhost/LoRa_API/logout_user.php";

      
      try
      {
        var response = await http.get(Uri.parse(uri));

        if(response.statusCode == 200) 
        {

          /* isLoggedIn = false; */
          print('Logout Successful');
          
          
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()));
            
            
        }
        else
        {
          print('Logout failed with status code: ${response.statusCode}');
        }
      }
      catch(e) 
      {
        print(e);
      }
    }
    
    
    String? userRole = "CLIENTE";

  @override
  Widget build(BuildContext context) {
    
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              iconTheme: IconThemeData(
                size: 25.0,
                color: Colors.black
              ),
              title: Row(
                children: [
                  Spacer(flex: 3),
                  
                  /* GestureDetector(
                    onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => homePageWeb(nombre: '', apellido: '', userRole: '',)));
                      },
                      child: TabsWeb("Hogar"),
                  ),
                  Spacer(), */
                  
                  /* GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryPage()));
                      
                    },
                    child: TabsWeb("Historial")
                  ),
                  Spacer(), */
                  

                  
                  GestureDetector(
                    onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => InvoicePage()));
                      },
                      child: TabsWeb("Facturacion")
                  ),
                  Spacer(),
                  
                  
                  /* GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FinesPage()));
                      
                    },
                    child: TabsWeb("Multas")
                  ),
                  Spacer(), */

                    GestureDetector(
                      onTap: ()  {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => InsertMedidorPage()));
                        },
                        child: TabsWeb("Crear Consumo"),
                    ),
                    Spacer(),

                    GestureDetector(
                      onTap: ()  {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => InsertCiudadPage()));
                        },
                        child: TabsWeb("Crear Localidad"),
                    ),
                    Spacer(),

                    GestureDetector(
                    onTap: ()  {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => InsertUsuario()));
                      },
                      child: TabsWeb("Simulacion Sensor"),
                  ),
                  Spacer(),

                  GestureDetector(
                    onTap: ()  {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => InsertFacturaPage()));
                      },
                      child: TabsWeb("Crear Factura"),
                  ),
                  Spacer(),
                  
                  GestureDetector(
                    onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => insertImportePage()));
                      },
                      child: TabsWeb("Crear Importe"),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => InsertCategoriaPage()));
                      },
                      child: TabsWeb("Crear Categoria"),
                  ),
                  Spacer(),
                
                  
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                      
                    },
                    child: TabsWeb("Iniciar Session")
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      logout();
                    },
                    child: Text('Cerrar Session'),
                  ),
                ],
              ),
            ), 
            backgroundColor: Colors.white,
            

            body: ListView(
              children:[
                //First section
                Container(
                  height: heightDevice > 56 ? heightDevice : 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.tealAccent,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0),
                              )
                            ),
                            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                            child: Text(
                              'Hola bienvenido ${widget.nombre}',
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                          SizedBox(height: 15.0),
                          SansBold("LoRa Elfec", 55.0),
                          Sans("Crecemos con energia", 30.0),
                          // Rest of the first section
                        ],
                      ),
                      CircleAvatar(
                        radius: 147.0,
                        backgroundColor: Colors.tealAccent,
                        child: CircleAvatar(
                          radius: 143.0,
                          backgroundColor: Colors.black,
                          child: CircleAvatar(
                            radius: 140.0,     
                            backgroundColor: Colors.white,
                            child: ClipOval(
                              child: Image.asset(
                                "assets/elfec.png",
                                fit: BoxFit.cover,
                                width: 300.0,
                                height: 300.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //Second section
                Container(
                  height: heightDevice/1.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset("assets/elfec.png", height: widthDevice/1.9,),
                    
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SansBold("Sobre", 40.0),
                          SizedBox(height: 15.0),
                          Sans("Empresa de Luz y Fuerza Electrica Cochabamba S.A.", 
                          15.0),
                          Sans("CASA MATRIZ", 15),
                          Sans("Av.Heroinas o-686-casilla 89", 
                          15.0),
                          Sans("Telf.: 4200125-Fax: 4259427", 
                          15.0),
                          Sans("Empresa de Servicios", 
                          15.0),
                          Sans("Cochabamba-Bolivia", 
                          15.0),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              /* backgroundColor: Colors.white,
              elevation: 0.0, */
              iconTheme: IconThemeData(
                size: 25.0,
                color: Colors.black,
              ),
              /* title: Text('Mobile App Bar'), */
            ),
            body: homePageMobile(),
          );
        }
      },
    );
  }
}



