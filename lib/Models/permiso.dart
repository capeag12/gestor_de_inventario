class Permiso {
  late String _id;
  late String _nombre;
  late String _tipo;
  late String _tokenAcceso;

  Permiso(this._id, this._nombre, this._tipo, this._tokenAcceso);

  Permiso.map(dynamic obj) {
    this._id = obj['id'];
    this._nombre = obj['nombre'];
    this._tipo = obj['tipo'];
    this._tokenAcceso = obj['tokenAcceso'];
  }

  String get id => _id;
  String get nombre => _nombre;
  String get tipo => _tipo;
  String get tokenAcceso => _tokenAcceso;
}
