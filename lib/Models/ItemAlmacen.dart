import 'package:gestor_de_inventario/Models/Item.dart';

class ItemAlmacen {
  late String id;
  late Item item;
  late int cantidad;
  late int cantidadCambiada = this.cantidad;

  ItemAlmacen(this.id, this.item, this.cantidad);
}
