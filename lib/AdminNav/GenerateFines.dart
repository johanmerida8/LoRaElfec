// ignore: unused_import
import 'package:flutter/material.dart';

class Fines {
  final String description;
  final double value;

  Fines(this.description, this.value);
}

class GenerateFinesPage extends StatefulWidget {
  @override
  _GenerateFinesPageState createState() => _GenerateFinesPageState();
}

class _GenerateFinesPageState extends State<GenerateFinesPage> {
  final _fines = <Fines>[];
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _valueController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Control de Multas'),
      ),
      body: Column(
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Descripcion de la multa'
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, introduzca una descripcion';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _valueController,
                  decoration: InputDecoration(
                    labelText: 'Valor de la multa',
                  ),
                  keyboardType: TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, introduzca un valor';
                    }
                    final number = double.tryParse(value);
                    if (number == null) {
                      return 'Por favor, introduzca un numero valido';
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
                    final description = _descriptionController.text;
                    final value = double.parse(_valueController.text);
                    final newFine = Fines(description, value);
                    setState(() {
                      _fines.add(newFine);
                    });
                    _descriptionController.clear();
                    _valueController.clear();
                  }
                },
                child: Text('Agregar Multa'),
              ),
              SizedBox(width: 8.0),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _fines.clear();
                  });
                },
                child: Text('Borrar Multas'),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _fines.length,
              itemBuilder: (context, index) {
                final fine = _fines[index];
                return ListTile(
                  title: Text(fine.description),
                  subtitle: Text('Value: \$${fine.value}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        _fines.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

