import 'package:gestor_de_inventario/Models/serviceAlmacenes.dart';

class AddItemVM {
  ServiceAlmacenes _serviceAlmacenes = ServiceAlmacenes.getInstance();
  String nombreItem = "";
  double valorItem = 0.0;
  int cantidadItem = 0;

  AddItemVM();

  Future<bool> addItem() async {
    return false;
  }
}
