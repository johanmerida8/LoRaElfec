import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lora_app/CategoriaCRUD/UpdateCategoria.dart';


//Parte de Yamil tarea de categoria de ver datos//

class viewDataCategoriaPage extends StatefulWidget {

  @override
  _viewDataCategoriaPageState createState() => _viewDataCategoriaPageState();
}


class _viewDataCategoriaPageState extends State<viewDataCategoriaPage> {

  List categoriadata = [];

  Future<void> deletecategoria(String CategoriaID) async 
  {
    String uri = "http://localhost/LoRa_API/delete_categoria.php";
    try
    {
      var res = await http.post(Uri.parse(uri),body:{
        "id_Categoria": CategoriaID
      });
      var response = jsonDecode(res.body);
      if(response["success"] == "true")
        {
          print("Categoria Borrado");
          getcategoria();
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

  Future<void> getcategoria() async {
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
  }

  @override
  void initState() {
    // TODO: implement initState
    getcategoria();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Categorias'),
      ),
      body: ListView.builder(
        itemCount: categoriadata.length,
        itemBuilder: (context, index)
        {
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder:(context) => updateCategoriaPage(
                        categoriadata[index]["id_Categoria"],
                        categoriadata[index]["tipo"],
                      )));
              },
              leading: Icon(
                CupertinoIcons.star, 
                color: Colors.yellow,
                ),
              title: Text(
                categoriadata[index]["tipo"]
              ),
              /* subtitle: Text(
                categoriadata[index]["descripcion"]
              ), */
              trailing: 
                IconButton(
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
                                deletecategoria(categoriadata[index]["id_Categoria"]);
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
          },
        ),
      );
    }
  }