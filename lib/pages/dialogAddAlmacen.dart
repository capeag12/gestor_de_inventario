import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gestor_de_inventario/VM/addAlmacenVM.dart';

class DialogAddAlmacen {
  static AddAlmacenVM _addAlmacenVM = AddAlmacenVM();
  static GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static Future<bool> _addAlmacen() async {
    _formKey.currentState?.save();
    bool? validated = _formKey.currentState?.validate();
    if (validated == false) {
      return false;
    } else if (validated == true) {
      bool added = await _addAlmacenVM.addAlmacen();
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
              child: ListBody(
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
                        _addAlmacenVM.nombreAlmacen = value ?? "";
                      },
                      onChanged: (value) {
                        _addAlmacenVM.nombreAlmacen = value ?? "";
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
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Dirección del Almacen",
                        hintText: 'Dirección del Almacen',
                      ),
                      onSaved: (value) {
                        _addAlmacenVM.direccionAlmacen = value ?? "";
                      },
                      onChanged: (value) {
                        _addAlmacenVM.direccionAlmacen = value ?? "";
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "El campo no puede estar vacio";
                        } else {
                          return null;
                        }
                      },
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
                await _addAlmacen();

                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
