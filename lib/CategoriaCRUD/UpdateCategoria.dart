import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class updateCategoriaPage extends StatefulWidget {

  String id_Categoria;
  String tipo;
  updateCategoriaPage(this.id_Categoria, this.tipo);

  @override
  _updateCategoriaPageState createState() => _updateCategoriaPageState();
}

class _updateCategoriaPageState extends State<updateCategoriaPage> {

  TextEditingController tipo = TextEditingController();

  Future<void> updatecategoria(String CategoriaID) async {
    try
    {
      String uri = "http://localhost/LoRa_API/update_categoria.php";

      var res = await http.post(Uri.parse(uri),
      body: {
        "id_Categoria": CategoriaID,
        "tipo": tipo.text,
      });
      var response = jsonDecode(res.body);
        if(response["success"] == "true")
        {
          print("Categoria Actualizado");
          
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

  @override
  void initState() {
    // TODO: implement initState
    tipo.text = widget.tipo;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actualizar Categoria')
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: tipo,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Ingrese Nombre del Categoria'),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: (){
                updatecategoria(widget.id_Categoria.toString());
              }, 
              child: Text('Actualizar'),
            ),
          ),
        ],
      ),
    );
  }
}