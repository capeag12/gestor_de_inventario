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
  String get nombre => _nombre;
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

  List<Almacen> getListaAlmacenesPodada(Almacen a) {
    List<Almacen> listaAlmacenesPodada = [];
    for (Almacen almacen in _listaAlmacenes) {
      if (almacen.id != a.id) {
        listaAlmacenesPodada.add(almacen);
      }
    }
    return listaAlmacenesPodada;
  }

  List<String> getAlmacenesName() {
    List<String> listaAlmacenesName = [];
    for (Almacen almacen in _listaAlmacenes) {
      listaAlmacenesName.add(almacen.nombre);
    }
    return listaAlmacenesName;
  }

  addAlmacen(Almacen almacen) {
    _listaAlmacenes.add(almacen);
  }
}
