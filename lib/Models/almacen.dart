class Almacen {
  String _id = "";
  String _nombre = "";
  String _direccion = "";

  Almacen(this._id, this._nombre, this._direccion);

  Almacen.map(dynamic obj) {
    this._id = obj['id'];
    this._nombre = obj['nome'];
    this._direccion = obj['direccion'];
  }

  String get id => _id;
  String get nombre => _nombre;
  String get direccion => _direccion;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['id'] = _id;
    map['nome'] = _nombre;
    map['direccion'] = _direccion;

    return map;
  }

  Almacen.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._nombre = map['nome'];
    this._direccion = map['direccion'];
  }
}
