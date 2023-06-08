import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gestor_de_inventario/Models/Item.dart';
import 'package:gestor_de_inventario/Models/ItemAlmacen.dart';
import 'package:gestor_de_inventario/Models/almacen.dart';
import 'package:gestor_de_inventario/VM/AddItemVM.dart';

class DialogAddItem {
  static AddItemVM _addItemVM = AddItemVM();
  static GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Future<bool> _addItem(Almacen a) async {
    _formKey.currentState?.save();
    bool? validated = _formKey.currentState?.validate();
    if (validated == false) {
      return false;
    } else if (validated == true) {
      ItemAlmacen itemAl = ItemAlmacen(
          "",
          Item("", _addItemVM.nombreItem, _addItemVM.valorItem),
          _addItemVM.cantidadItem);
      bool added = await _addItemVM.addItem(itemAl, a);
      if (added == true) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  static Future<void> dialogAddItem(BuildContext context, Almacen a) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Añadir Almacen',
              style: TextStyle(fontWeight: FontWeight.bold)),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Nombre del Item",
                          hintText: 'Nombre del Item',
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
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Valor(€)",
                                hintText: 'Valor(€)',
                              ),
                              onSaved: (value) {
                                num parsed = num.tryParse(value ?? "") ?? 0;
                                _addItemVM.valorItem = parsed.toDouble();
                              },
                              onChanged: (value) {
                                num parsed = num.tryParse(value) ?? 0;
                                _addItemVM.valorItem = parsed.toDouble();
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
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: 10, left: 10),
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Cantidad",
                                hintText: 'Cantidad',
                              ),
                              onSaved: (value) {
                                int parsed = int.tryParse(value ?? "") ?? 0;
                                _addItemVM.cantidadItem = parsed;
                              },
                              onChanged: (value) {
                                int parsed = int.tryParse(value ?? "") ?? 0;
                                _addItemVM.cantidadItem = parsed;
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
                                    RegExp(r'^\d+')),
                              ],
                              keyboardType: TextInputType.numberWithOptions(
                                decimal: false,
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Añadir'),
              onPressed: () async {
                bool addAlmacen = await _addItem(a);
                Navigator.pop(context);
                if (addAlmacen == true) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Item añadido"),
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
