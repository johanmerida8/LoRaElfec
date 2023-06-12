import 'package:flutter/material.dart';

class MyLogicPage extends StatefulWidget {
  @override
  _MyLogicStatePage createState() => _MyLogicStatePage();
}

class _MyLogicStatePage extends State<MyLogicPage> {
  double precioUnitario = 0;
  double unidad = 0;
  double importe = 0;

  void calculateTotal() {
    setState(() {
      importe = precioUnitario * unidad;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Importe"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          }
        )
      ),
    body: Container(
      padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Table(
              children: [
                TableRow(
                  children: [
                    TableCell(
                      child: Text('Unidad'),
                    ),
                    TableCell(
                      child: Text('Precio Unitario'),
                    ),
                    TableCell(
                      child: Text('Importe'),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          unidad = double.tryParse(value) ?? 0;
                          calculateTotal();
                        },
                      ),
                    ),
                    TableCell(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          precioUnitario = double.tryParse(value) ?? 0;
                          calculateTotal();
                        },
                      ),
                    ),
                    TableCell(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        enabled: false,
                        initialValue: importe.toString(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              
              onPressed: () {
                /* print('Unidad: $unidad');
                print('Precio Unitario: $precioUnitario');
                print('Importe: $importe'); */

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Invoice Details'),
                      content: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Unidad: $unidad'),
                          Text('Precio Unitario: $precioUnitario'),
                          Text('Importe: $importe'),
                        ],
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
  
}