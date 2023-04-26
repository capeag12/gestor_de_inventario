import 'package:gestor_de_inventario/Models/movimiento.dart';
import 'package:gestor_de_inventario/Models/serviceMovimientos.dart';

class MovimientoPageVM {
  ServiceMovimientos _serviceMovimientos = ServiceMovimientos.getInstance();

  MovimientoPageVM();

  Future<List<Movimiento>?> getMovimientos() async {
    await _serviceMovimientos.getAllMovements();
    return null;
  }
}
