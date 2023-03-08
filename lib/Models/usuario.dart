import 'package:gestor_de_inventario/Models/almacen.dart';

class Usuario {
  String _id = "";
  String _nombre = "";
  String _email = "";
  List<Almacen> _listaAlmacenes = [];

  Usuario(this._id, this._nombre, this._email);

  Usuario.map(dynamic obj) {
    this._id = obj['id'];
    this._nombre = obj['nome'];
    this._email = obj['email'];
  }

  String get id => _id;
  String get nome => _nombre;
  String get email => _email;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['id'] = _id;
    map['nome'] = _nombre;
    map['email'] = _email;

    return map;
  }

  Usuario.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._nombre = map['nome'];
    this._email = map['email'];
  }

  List<Almacen> get listaAlmacenes => _listaAlmacenes;

  addAlmacen(Almacen almacen) {
    _listaAlmacenes.add(almacen);
  }
}
