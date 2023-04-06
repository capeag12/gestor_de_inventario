import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gestor_de_inventario/Models/almacen.dart';

class AlmacenWidgetEnviar extends StatelessWidget {
  Almacen almacen;
  AlmacenWidgetEnviar(this.almacen);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
      child: InkWell(
        onTap: () {
          print("Almacen pulsado");
        },
        child: Container(
          padding: EdgeInsets.all(15),
          child: Row(children: [
            Expanded(
                child: Column(
              children: [
                Text(almacen.nombre,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(
                  almacen.direccion,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ))
          ]),
        ),
      ),
    ));
  }
}
