import 'package:gestor_de_inventario/Models/serviceLogin.dart';
import 'package:gestor_de_inventario/Models/usuario.dart';

class RegistrarmeVM {
  late ServiceLogin _service;
  bool aceptadas = false;
  bool correoIgual = true;
  bool contrasenaIgual = true;
  bool correoValido = true;
  bool contrasenaValida = true;
  late String? nombre;
  late String? correo;
  late String? confirmarCorreo;
  late String? contrasena;
  late String? confirmarContrasena;

  RegistrarmeVM() {
    _service = ServiceLogin.getInstance();
  }

  bool validMail(String? email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email ?? "");
    ;
  }

  bool validPassword(String? password) {
    String pass = password ?? "";
    return pass.contains("password") == false && pass.length >= 6;
  }

  bool comparePassword() {
    contrasenaIgual = contrasena == confirmarContrasena;
    return contrasena == confirmarContrasena;
  }

  bool compareMail() {
    correoIgual = correo == confirmarCorreo;
    return correo == confirmarCorreo;
  }

  Future<bool> registrarme() async {
    Usuario? u = await _service.registrarme(
        nombre ?? "", correo ?? "", contrasena ?? "");

    if (u != null) {
      return true;
    } else {
      return false;
    }
  }
}
