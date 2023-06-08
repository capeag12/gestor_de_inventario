import 'package:gestor_de_inventario/Models/serviceLogin.dart';

class MenuLateralVM {
  ServiceLogin _service = ServiceLogin.getInstance();

  MenuLateralVM();

  Future<void> cerrarSesion() async {
    await _service.removeToken();
    await _service.logout();
  }

  ServiceLogin get service => _service;
}
