import 'package:gestor_de_inventario/Models/service.dart';

class MenuLateralVM {
  Service _service = Service.getInstance();

  MenuLateralVM();

  Future<void> cerrarSesion() async {
    await _service.removeToken();
    await _service.logout();
  }
}
