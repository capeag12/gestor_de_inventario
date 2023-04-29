import 'package:gestor_de_inventario/Models/movimiento.dart';
import 'package:gestor_de_inventario/Models/serviceMovimientos.dart';

class MovimientoPageVM {
  ServiceMovimientos _serviceMovimientos = ServiceMovimientos.getInstance();

  MovimientoPageVM();

  Future<List<Movimiento>?> getMovimientos() async {
    List<Movimiento>? movimientos = await _serviceMovimientos.getAllMovements();
    if (movimientos != null) {
      return movimientos;
    } else
      return null;
  }

  ServiceMovimientos get serviceMovimientos => _serviceMovimientos;
}
