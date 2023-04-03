import 'package:gestor_de_inventario/Models/ItemAlmacen.dart';
import 'package:gestor_de_inventario/Models/almacen.dart';
import 'package:gestor_de_inventario/Models/serviceAlmacenes.dart';

class AddItemVM {
  ServiceAlmacenes _serviceAlmacenes = ServiceAlmacenes.getInstance();
  String nombreItem = "";
  double valorItem = 0.0;
  int cantidadItem = 0;

  AddItemVM();

  Future<bool> addItem(ItemAlmacen itemAl, Almacen a) async {
    ItemAlmacen? i = await _serviceAlmacenes.agregarItem(itemAl, a);
    if (i != null) {
      return true;
    } else
      return false;
  }
}
