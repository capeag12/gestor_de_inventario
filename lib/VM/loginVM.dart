import 'package:flutter/cupertino.dart';
import 'package:gestor_de_inventario/Models/serviceLogin.dart';
import 'package:gestor_de_inventario/Models/usuario.dart';

class LoginVM {
  late ServiceLogin _service;
  late String email;
  late String password;

  LoginVM() {
    _service = ServiceLogin.getInstance();
  }

  Future<bool> login() async {
    Usuario? u = await _service.realizarLogin(email, password);

    if (u != null) {
      return true;
    } else {
      return false;
    }
  }
}
