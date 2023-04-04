import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gestor_de_inventario/Models/Item.dart';
import 'package:gestor_de_inventario/Models/ItemAlmacen.dart';
import 'package:number_selection/number_selection.dart';

class Item_Widget extends StatefulWidget {
  late ItemAlmacen _itemAlmacen;

  Item_Widget(this._itemAlmacen);
  @override
  State<Item_Widget> createState() => _Item_WidgetState(_itemAlmacen);
}

class _Item_WidgetState extends State<Item_Widget> {
  late ItemAlmacen _itemAlmacen;

  _Item_WidgetState(this._itemAlmacen);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 12),
      child: Card(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Row(children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(this._itemAlmacen.item.nombre,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(
                    this._itemAlmacen.item.valor.toString() + " €",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            Container(
              //adjust the height of the container
              height: 50,
              //adjust the width of the container
              width: 75,
              child: NumberSelection(
                theme: NumberSelectionTheme(
                    numberColor: Colors.black,
                    iconsColor: Colors.black,
                    backgroundColor: (this._itemAlmacen.cantidadCambiada !=
                            this._itemAlmacen.cantidad)
                        ? Colors.yellow
                        : Colors.cyan),
                minValue: 0,
                initialValue: this._itemAlmacen.cantidad,
                direction: Axis.horizontal,
                withSpring: true,
                onChanged: (value) {
                  setState(() {
                    this._itemAlmacen.cantidadCambiada = value;
                  });
                },
              ),
            )
          ]),
        ),
      ),
    );
  }
}
