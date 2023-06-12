// ignore: unused_import
import 'package:flutter/material.dart';

class Factura {
  final String nombreCliente;
  final String descripcion;
  final double monto;

  Factura(this.nombreCliente, this.descripcion, this.monto);

  
}

class GenerateInvoicePage extends StatefulWidget {

  

  @override
  _GenerateInvoicePageState createState() => _GenerateInvoicePageState();
}

class _GenerateInvoicePageState extends State<GenerateInvoicePage> {
  final _factura = <Factura>[];
  final _formKey = GlobalKey<FormState>();
  final _nombreClienteController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _montoController = TextEditingController();
  
  
  

  @override
  void dispose() {
    _nombreClienteController.dispose();
    _descripcionController.dispose();
    _montoController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generar Factura'),
      ),
      
      body: Column(
        children: [
          Form(
            
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _nombreClienteController,
                  decoration: InputDecoration(
                    labelText: 'Nombre del Cliente',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Porfavor, introduzca nombre del cliente';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _descripcionController,
                  decoration: InputDecoration(
                    labelText: 'Descripcion',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Porfavor, introduzca una descripcion';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _montoController,
                  decoration: InputDecoration(
                    labelText: 'Monto',
                  ),
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Porfavor, introduzca el monto';
                    }
                    final number = double.tryParse(value);
                    if (number == null) {
                      return 'Porfavor, introduzca un numero valido';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final nombreCliente = _nombreClienteController.text;
                    final descripcion = _descripcionController.text;
                    final monto = double.parse(_montoController.text);
                    final nuevaFactura = Factura(nombreCliente, descripcion, monto);
                    setState(() {
                      _factura.add(nuevaFactura);
                    });
                    _nombreClienteController.clear();
                    _descripcionController.clear();
                    _montoController.clear();
                  }
                },
                child: Text('Agregar Factura'),
              ),
              SizedBox(width: 8.0),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _factura.clear();
                  });
                },
                child: Text('Borrar Factura'),
              ),
              SizedBox(width: 8.0),
              ElevatedButton(
                onPressed: () {
                  if(_factura.isNotEmpty){
                    final nombreCliente = _nombreClienteController.text;
                    final descripcion = _descripcionController.text;
                    final monto = double.parse(_montoController.text); 
                    final facturaActualizada = Factura(nombreCliente, descripcion, monto);
                    setState(() {
                      _factura[0] = facturaActualizada;
                    });
                    _nombreClienteController.clear();
                    _descripcionController.clear();
                    _montoController.clear();
                  }
                },
                child: Text('Actualizar Factura'),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _factura.length,
              itemBuilder: (context, index) {
                final factura = _factura[index];
                return ListTile(
                  title: Text(factura.nombreCliente),
                  subtitle: Text('Descripcion: ${factura.descripcion}, Monto: \$${factura.monto}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        _factura.removeAt(index);
                      });
                    },
                  )
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _factura.length,
              itemBuilder: (context, index) {
                final factura = _factura[index];
                return ListTile(
                  title: Text(factura.nombreCliente),
                  subtitle: Text('Descripcion: ${factura.descripcion}, Monto: \$${factura.monto}'),
                  trailing: InkWell(
                    child: Icon(Icons.update),
                    onTap: () async {
                      final result = await Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => GenerateInvoicePage()),
                      );
                      if(result != null) {
                        setState(() {
                          _factura[index] = result;
                        });
                      }
                    }
                  )
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
