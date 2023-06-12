import 'package:flutter/material.dart';
import 'package:lora_app/FacturaCRUD/InsertFactura.dart';
import 'package:lora_app/ImporteCRUD/InsertImporte.dart';
import 'package:lora_app/Login%20&%20Signup/LoginPage.dart';
import 'package:lora_app/MultaCRUD/InsertMulta.dart';
import 'package:lora_app/NavPages/BillingPage.dart';
import 'package:lora_app/NavPages/FinesPage.dart';
import 'package:lora_app/components.dart';

class homePageMobile extends StatefulWidget {
  

  @override
  _homePageMobileState createState() => _homePageMobileState();
}

class _homePageMobileState extends State<homePageMobile> {
  @override
  Widget build(BuildContext context) {

    /* var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width; */

    return Scaffold(
      appBar: AppBar(
        title: Text('LoRa Elfec'),
        backgroundColor: Colors.blue.shade700,
      ),
      drawer: NavigationDrawer(),

      body: ListView(
        children: [
        // First section
          Container(
            height: MediaQuery.of(context).size.height - 56,
            child: Column(
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
                        ),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      child: Text(
                        'Hola bienvenido',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Text(
                      'LoRa Elfec',
                      style: TextStyle(fontSize: 55.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Crecemos con energia',
                      style: TextStyle(fontSize: 30.0),
                    ),
                  ],
                ),
                SizedBox(height: 13.0),
                CircleAvatar(
                  radius: 147.0,
                  backgroundColor: Colors.tealAccent,
                  child: CircleAvatar(
                    radius: 143.0,
                    backgroundColor: Colors.black,
                    child: CircleAvatar(
                      radius: 140.0,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage("assets/elfec.png"),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Second section
          Container(
            height: MediaQuery.of(context).size.height / 1.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/elfec.png",
                  height: MediaQuery.of(context).size.width / 1.9,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Sobre",
                      style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 15.0),
                    Text(
                      "Empresa de Luz y Fuerza Electrica Cochabamba S.A.",
                      style: TextStyle(fontSize: 15.0),
                    ),
                    Text(
                      "CASA MATRIZ",
                      style: TextStyle(fontSize: 15.0),
                    ),
                    Text(
                      "Av.Heroinas o-686-casilla 89",
                      style: TextStyle(fontSize: 15.0),
                    ),
                    Text(
                      "Telf.: 4200125-Fax: 4259427",
                      style: TextStyle(fontSize: 15.0),
                    ),
                    Text(
                      "Empresa de Servicios",
                      style: TextStyle(fontSize: 15.0),
                    ),
                    Text(
                      "Cochabamba-Bolivia",
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NavigationDrawer extends StatefulWidget {
  

  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  
  @override
  Widget build(BuildContext context) {
    /* final bool isMobile = MediaQuery.of(context).size.width < 600; */
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }  
}

Widget buildHeader(BuildContext context) => Material(
  color: Colors.blue.shade700,
  child: Container(
    padding: EdgeInsets.only(
      top: 24 + MediaQuery.of(context).padding.top.toDouble(),
      bottom: 24,
    ),
    child: Column(
      children: [
        CircleAvatar(
          radius: 52.0,  
          backgroundColor: Colors.white,
          backgroundImage: AssetImage("assets/elfec.png"),
        ),
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
  ),
);

Widget buildMenuItems(BuildContext context) => Container(
  padding: EdgeInsets.all(24),
  child: Wrap(
    runSpacing: 16.0,
    children: [
      ListTile(
        leading: Icon(Icons.home_outlined),
        title: Text('Home'),
        onTap: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => homePageMobile()));
        },
      ),
      ListTile(
        leading: Icon(Icons.favorite_border),
        title: Text('Invoice'),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => InvoicePage()));
        },
      ),
      ListTile(
        leading: Icon(Icons.workspaces_outline),
        title: Text('Fine'),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => FinesPage()));
        },
      ),
      ListTile(
        leading: Icon(Icons.card_travel),
        title: Text('Create Factura'),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => InsertFacturaPage()));
        },
      ),
      ListTile(
        leading: Icon(Icons.airplane_ticket),
        title: Text('Create Multa'),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => InsertMultaPage()));
        },
      ),
      ListTile(
        leading: Icon(Icons.import_contacts),
        title: Text('Importe'),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => insertImportePage()));
        },
      ),
      Divider(color: Colors.black54),
      ListTile(
        leading: Icon(Icons.face),
        title: Text('Login'),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
        },
      ),
    ],
  ),
);