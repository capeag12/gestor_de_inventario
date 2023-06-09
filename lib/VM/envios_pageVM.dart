import 'package:gestor_de_inventario/Models/envio.dart';
import 'package:gestor_de_inventario/Models/serviceLogin.dart';
import 'package:gestor_de_inventario/Models/serviceMovimientos.dart';

class Envios_PageVM {
  late ServiceMovimientos _serviceMovimientos;
  List<Envio>? envios = [];

  ServiceLogin serviceLogin = ServiceLogin.getInstance();

  Envios_PageVM() {
    _serviceMovimientos = ServiceMovimientos.getInstance();
  }

  Future<List<Envio>?> getAllEnvios() async {
    this.envios = await _serviceMovimientos.getAllEnvios();
    if (this.envios == null) {
      this.envios = [];
      return [];
    }
    return this.envios;
  }
}
