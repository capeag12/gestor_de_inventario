import 'package:gestor_de_inventario/Models/ItemAlmacen.dart';
import 'package:gestor_de_inventario/Models/almacen.dart';
import 'package:gestor_de_inventario/Models/serviceAlmacenes.dart';
import 'package:gestor_de_inventario/Models/serviceLogin.dart';

class AlmacenpageVM {
  late Almacen _almacen;
  ServiceAlmacenes _serviceAlmacenes = ServiceAlmacenes.getInstance();
  ServiceLogin _serviceLogin = ServiceLogin.getInstance();
  AlmacenpageVM(this._almacen);

  Set<ItemAlmacen> setListaRestados = new Set<ItemAlmacen>();
  Set<ItemAlmacen> setListaSumados = new Set<ItemAlmacen>();

  Almacen get almacen => _almacen;

  Future<bool> obtenerItemsAlmacen() async {
    bool? obtenido = await _serviceAlmacenes.obtenerItemsAlmacen(_almacen);

    if (obtenido == true) {
      return true;
    } else {
      return false;
    }
  }

  void addItemToSet(ItemAlmacen item) {
    if (item.cantidadCambiada > item.cantidad) {
      setListaSumados.add(item);
    } else if (item.cantidadCambiada < item.cantidad) {
      setListaRestados.add(item);
    } else {
      setListaRestados.remove(item);
      setListaSumados.remove(item);
    }
  }

  List<ItemAlmacen> getListCambiados() {
    List<ItemAlmacen> listaCambiados = [];
    listaCambiados.addAll(setListaSumados);
    listaCambiados.addAll(setListaRestados);
    return listaCambiados;
  }

  ServiceLogin get serviceLogin => _serviceLogin;
}
