import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gestor_de_inventario/VM/AddItemVM.dart';

class DialogAddItem {
  static AddItemVM _addItemVM = AddItemVM();
  static GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Future<bool> _addAlmacen() async {
    _formKey.currentState?.save();
    bool? validated = _formKey.currentState?.validate();
    if (validated == false) {
      return false;
    } else if (validated == true) {
      bool added = await _addItemVM.addItem();
      if (added == true) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  static Future<void> dialogAddAlmacen(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Añadir Almacen',
              style: TextStyle(fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Nombre del Almacen",
                        hintText: 'Nombre del Almacen',
                      ),
                      onSaved: (value) {
                        _addItemVM.nombreItem = value ?? "";
                      },
                      onChanged: (value) {
                        _addItemVM.nombreItem = value ?? "";
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "El campo no puede estar vacio";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Valor del Item",
                        hintText: 'Valor del item',
                      ),
                      onSaved: (value) {
                        _addItemVM.nombreItem = value ?? "";
                      },
                      onChanged: (value) {
                        _addItemVM.nombreItem = value ?? "";
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "El campo no puede estar vacio";
                        } else {
                          return null;
                        }
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}')),
                      ],
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Cantidad del item",
                        hintText: 'Cantidad del item',
                      ),
                      onSaved: (value) {
                        _addItemVM.nombreItem = value ?? "";
                      },
                      onChanged: (value) {
                        _addItemVM.nombreItem = value ?? "";
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "El campo no puede estar vacio";
                        } else {
                          return null;
                        }
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}')),
                      ],
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Añadir'),
              onPressed: () async {
                bool addAlmacen = await _addAlmacen();
                Navigator.pop(context);
                if (addAlmacen == true) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Almacen añadido"),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("No se pudo añadir el almacen"),
                  ));
                }
              },
            ),
          ],
        );
      },
    );
  }
}
