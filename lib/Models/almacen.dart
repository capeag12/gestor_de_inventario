import 'package:gestor_de_inventario/Models/ItemAlmacen.dart';

class Almacen {
  String _id = "";
  String _nombre = "";
  String _direccion = "";
  List<ItemAlmacen> _listaItems = [];

  Almacen(this._id, this._nombre, this._direccion);

  String get id => _id;
  String get nombre => _nombre;
  String get direccion => _direccion;

  List<ItemAlmacen> get listaItems => _listaItems;

  set listaItems(List<ItemAlmacen> listaItems) {
    _listaItems = listaItems;
  }
}
