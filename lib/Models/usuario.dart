class Usuario {
  String _id = "";
  String _nome = "";
  String _email = "";

  Usuario(this._id, this._nome, this._email);

  Usuario.map(dynamic obj) {
    this._id = obj['id'];
    this._nome = obj['nome'];
    this._email = obj['email'];
  }

  String get id => _id;
  String get nome => _nome;
  String get email => _email;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['id'] = _id;
    map['nome'] = _nome;
    map['email'] = _email;

    return map;
  }

  Usuario.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._nome = map['nome'];
    this._email = map['email'];
  }
}
