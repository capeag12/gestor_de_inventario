import 'package:flutter/material.dart';
import 'package:gestor_de_inventario/Models/ItemAlmacen.dart';
import 'package:gestor_de_inventario/Models/itemMovimiento.dart';

class WidgetItemMov extends StatelessWidget {
  late ItemMovimiento itemMovimiento;

  WidgetItemMov(this.itemMovimiento);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Card(
          color: (itemMovimiento.cantidad > 0)
              ? Color.fromARGB(255, 185, 255, 105)
              : (itemMovimiento.cantidad <= 0)
                  ? Color.fromARGB(255, 238, 89, 126)
                  : Colors.white,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    itemMovimiento.item.nombre,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 15),
                child: Text(
                    itemMovimiento.cantidad > 0
                        ? "+ ${itemMovimiento.cantidad}"
                        : "${itemMovimiento.cantidad}",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
            ],
          )),
    );
  }
}
