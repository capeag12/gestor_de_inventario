class Almacen {
  String _id = "";
  String _nome = "";
  String _direccion = "";

  Almacen(this._id, this._nome, this._direccion);

  Almacen.map(dynamic obj) {
    this._id = obj['id'];
    this._nome = obj['nome'];
    this._direccion = obj['direccion'];
  }

  String get id => _id;
  String get nome => _nome;
  String get direccion => _direccion;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['id'] = _id;
    map['nome'] = _nome;
    map['direccion'] = _direccion;

    return map;
  }

  Almacen.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._nome = map['nome'];
    this._direccion = map['direccion'];
  }
}
