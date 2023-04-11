import 'dart:convert';

import 'package:gestor_de_inventario/Models/Item.dart';

class ItemAlmacen {
  late String id;
  late Item item;
  late int cantidad;
  late int cantidadCambiada = this.cantidad;

  ItemAlmacen(this.id, this.item, this.cantidad);

  //toJSON
  Map toJson() => {
        'id': id,
        'item': item,
        'cantidad': cantidad,
        'cantidadCambiada': cantidadCambiada,
      };

  //Override the equals method
  @override
  bool operator ==(Object other) => this.id == (other as ItemAlmacen).id;
}
