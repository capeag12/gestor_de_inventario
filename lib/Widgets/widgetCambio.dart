import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gestor_de_inventario/Models/ItemAlmacen.dart';

class WidgetCambio extends StatelessWidget {
  late ItemAlmacen itemAlmacen;

  WidgetCambio(this.itemAlmacen);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Card(
          color: (itemAlmacen.cantidadCambiada > itemAlmacen.cantidad)
              ? Color.fromARGB(255, 185, 255, 105)
              : (itemAlmacen.cantidadCambiada < itemAlmacen.cantidad)
                  ? Color.fromARGB(255, 238, 89, 126)
                  : Colors.white,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    itemAlmacen.item.nombre,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 15),
                child: Text(
                    (itemAlmacen.cantidadCambiada > itemAlmacen.cantidad)
                        ? "+ ${itemAlmacen.cantidadCambiada - itemAlmacen.cantidad}"
                        : "${itemAlmacen.cantidadCambiada - itemAlmacen.cantidad}",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
            ],
          )),
    );
  }
}
