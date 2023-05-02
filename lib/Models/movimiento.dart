import 'dart:ffi';

import 'package:gestor_de_inventario/Models/almacen.dart';
import 'package:gestor_de_inventario/Models/itemMovimiento.dart';

class Movimiento {
  late String _id;
  late Almacen? _almacenOrigen;
  late Almacen _almacenDestino;
  late String _tipo;
  late DateTime _fechaCreacion;
  late List<ItemMovimiento> _items;

  Movimiento(this._id, this._almacenOrigen, this._almacenDestino, this._tipo,
      this._fechaCreacion, this._items);

  String get id => _id;
  Almacen? get almacenOrigen => _almacenOrigen;
  Almacen get almacenDestino => _almacenDestino;
  String get tipo => _tipo;
  DateTime get fechaCreacion => _fechaCreacion;
  List<ItemMovimiento> get items => _items;

  double get valorTotal {
    double valor = 0;
    for (ItemMovimiento item in _items) {
      valor += item.item.valor * item.cantidad;
    }
    if (valor < 0) {
      valor = valor * -1;
    }

    return valor;
  }
}
