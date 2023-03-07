import 'package:flutter/cupertino.dart';
import 'package:gestor_de_inventario/Models/service.dart';
import 'package:gestor_de_inventario/Models/usuario.dart';

class LoginVM {
  late Service _service;

  LoginVM() {
    _service = Service.getInstance();
  }

  Future<bool> login(String email, String password) async {
    Usuario? u = await _service.realizarLogin(email, password);

    if (u != null) {
      return true;
    } else {
      return false;
    }
  }
}
