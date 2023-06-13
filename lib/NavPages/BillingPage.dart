// ignore: unused_import
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//Parte de Isaac, Yamil, Johan, facturacion para cliente//

class InvoicePage extends StatelessWidget {
  const InvoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Facturacion'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => InvoiceDetailsPage()),
            );
          },
          child: Text('Ver Facturacion'),
        ),
      )
    );
  }
}

class InvoiceDetailsPage extends StatefulWidget {



  @override
  State<InvoiceDetailsPage> createState() => _InvoiceDetailsPageState();
}

class _InvoiceDetailsPageState extends State<InvoiceDetailsPage> {

  List<dynamic> facturadata = [];
  List<dynamic> userdata = [];
  List<dynamic> importedata = [];
  List<dynamic> categoriadata = [];
  
  /* List<dynamic> medidordata = [];
  List<dynamic> ciudadData = []; */

  

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

  Future<List<dynamic>?> getimporte() async {
    String uri = "http://localhost/LoRa_API/view_data_importe.php";
    try
    {
      var response = await http.get(Uri.parse(uri));

      setState(() {
        importedata = jsonDecode(response.body);
      });
    }
    catch(e)
    {
      print(e);
    }
    return null;
  }

  Future<void> getfactura() async {
    String uri = "http://localhost/LoRa_API/view_data_factura.php";
    try
    {
      var response = await http.get(Uri.parse(uri));

      setState(() {
        facturadata = jsonDecode(response.body);
      });
    }
    catch(e)
    {
      print(e);
    }
  }

  Future<List<dynamic>?> getcategory() async {
    String uri = "http://localhost/LoRa_API/get_categoria.php";
    try
    {
      var response = await http.get(Uri.parse(uri));

      setState(() {
        categoriadata = jsonDecode(response.body);
      });
    }
    catch(e)
    {
      print(e);
    }
    return null;
  }

  /* Future<List<dynamic>?> getmedidor() async {
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
    return [];
  } */

  /* Future<List<dynamic>?> getciudad() async {
    String uri = "http://localhost/LoRa_API/get_ciudad.php";
    try
    {
      var response = await http.get(Uri.parse(uri));

      setState(() {
        ciudadData = jsonDecode(response.body);
      });
    }
    catch(e)
    {
      print(e);
    }
    return null;
  } */

  @override
  void initState() {
    // TODO: implement initState
    getimporte();
    getfactura();
    getuser();
    
    /* getmedidor(); */
    getcategory();
    /* getciudad(); */
    super.initState();
  }

  String? loggedInUserID;

  @override
  Widget build(BuildContext context) {

    /* Set<dynamic> uniqueClienteIDs = facturadata.map((factura) => factura["ClienteID"]).toSet();

    List<dynamic> filtedFacturaData = facturadata.where((factura) => factura["ClienteID"] == loggedInUserID).toList(); */

    return Scaffold(
      appBar: AppBar(
        title: Text('Facturacion'),
      ),
      body: ListView.builder(
        itemCount: facturadata.length,
        itemBuilder: (context, index) {
            var factura = facturadata[index];
            var clienteID = factura["ClienteID"];
            var cliente = userdata.firstWhere((client) => client["id_Usuario"] == clienteID, orElse: () => null);
            var importeID = factura["ImporteID"];
            var importe = importedata.firstWhere((importe) => importe["id_Importe"] == importeID, orElse: () => null);
            var categoriaID = factura["CategoriaID"];
            var categoria = categoriadata.firstWhere((categoria) => categoria["id_Categoria"] == categoriaID, orElse: () => null);
          /* var localidadID = factura["LocalidadID"];
            var localidad = userdata.firstWhere((localidad) => localidad["id_Usuario"] == localidadID, orElse: () => null);
            var consumoID = factura["ConsumoID"];
            var consumo = userdata.firstWhere((consumo) => consumo["id_Usuario"] == consumoID, orElse: () => null); */
            var consumo = cliente != null ? double.parse(cliente["consumo"].toString()) : 0.0;
            var precio = importe != null ? double.parse(importe['precio'].toString()) : 0.0;

            // Realizar la multiplicación
            var totalAPagar = precio * consumo;


            /* var medidorID = factura["MedidorID"];
            var medidor = medidordata.firstWhere((medidor) => medidor["id_Medidor"] == medidorID, orElse: () => null); */
            /* var ciudadID = factura["CiudadID"];
            var ciudad = ciudadData.firstWhere((ciudad) => ciudad["id_Ciudad"] == ciudadID, orElse: () => null); */

            if (importe != null) {
              return ListTile(
                leading: Icon(
                  CupertinoIcons.star,
                  color: Colors.yellow,
                ),
                title: Text('Cliente: ${cliente != null ? cliente["nombre"] : "Cargando..."}'),
                subtitle: importe != null && categoria != null
                ? Text('Fecha de Emision: ${factura["fecha"]} | Fecha de Vencimiento: ${factura["fechaLimite"]} | Factura: ${factura["descripcion"]} | Descripcion: ${importe["descripcion"]} | Tipo: ${categoria["tipo"]} | Localidad: ${cliente["localidad"]} | Consumo mensual: ${cliente["consumo"]}') 
                : Text("Cargando..."),
                trailing: importe != null ? Text('TOTAL BS A PAGAR: ${totalAPagar}') : Text("Cargando..."),
              );
            }
            return null;
        },   
      ),
    );
  }
}