import 'package:gestor_de_inventario/Models/almacen.dart';

enum TipoMovimiento { entrada, salida }

class Movimiento {
  late String _id;
  late Almacen _almacenOrigen;
  late Almacen _almacenDestino;
  late TipoMovimiento _tipo;
  late DateTime _fechaCreacion;

  Movimiento(this._id, this._almacenOrigen, this._almacenDestino, this._tipo,
      this._fechaCreacion);

  String get id => _id;
  Almacen get almacenOrigen => _almacenOrigen;
  Almacen get almacenDestino => _almacenDestino;
  TipoMovimiento get tipo => _tipo;
  DateTime get fechaCreacion => _fechaCreacion;
}
