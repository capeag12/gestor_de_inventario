class Usuario {
  String _id = "";
  String _nome = "";
  String _email = "";
  String _password = "";

  Usuario(this._id, this._nome, this._email, this._password);

  Usuario.map(dynamic obj) {
    this._id = obj['id'];
    this._nome = obj['nome'];
    this._email = obj['email'];
    this._password = obj['password'];
  }

  String get id => _id;
  String get nome => _nome;
  String get email => _email;
  String get password => _password;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['id'] = _id;
    map['nome'] = _nome;
    map['email'] = _email;
    map['password'] = _password;

    return map;
  }

  Usuario.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._nome = map['nome'];
    this._email = map['email'];
    this._password = map['password'];
  }
}
