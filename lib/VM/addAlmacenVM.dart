import 'package:gestor_de_inventario/Models/almacen.dart';
import 'package:gestor_de_inventario/Models/serviceAlmacenes.dart';
import 'package:gestor_de_inventario/Models/serviceLogin.dart';

class AddAlmacenVM {
  ServiceLogin _serviceLogin = ServiceLogin.getInstance();
  ServiceAlmacenes _serviceAlmacenes = ServiceAlmacenes.getInstance();
  String nombreAlmacen = "";
  String direccionAlmacen = "";
  AddAlmacenVM();

  Future<bool> addAlmacen() async {
    Almacen? a =
        await _serviceAlmacenes.addAlmacen(nombreAlmacen, direccionAlmacen);
    if (a != null) {
      return true;
    } else {
      return false;
    }
  }
}
