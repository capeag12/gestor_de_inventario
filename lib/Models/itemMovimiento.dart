import 'package:gestor_de_inventario/Models/Item.dart';

class ItemMovimiento {
  late Item _item;
  late int _cantidad;

  ItemMovimiento(this._item, this._cantidad);

  Item get item => _item;
  int get cantidad => _cantidad;
}
