import 'package:gestor_de_inventario/Models/almacen.dart';
import 'package:gestor_de_inventario/Models/serviceAlmacenes.dart';

class AlmacenpageVM {
  late Almacen _almacen;
  ServiceAlmacenes _serviceAlmacenes = ServiceAlmacenes.getInstance();

  AlmacenpageVM(this._almacen);

  Almacen get almacen => _almacen;

  Future<bool> obtenerItemsAlmacen() async {
    bool? obtenido = await _serviceAlmacenes.obtenerItemsAlmacen(_almacen);

    if (obtenido == true) {
      return true;
    } else {
      return false;
    }
  }
}
