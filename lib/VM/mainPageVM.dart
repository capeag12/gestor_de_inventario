import 'package:gestor_de_inventario/Models/almacen.dart';
import 'package:gestor_de_inventario/Models/serviceAlmacenes.dart';
import 'package:gestor_de_inventario/Models/serviceLogin.dart';
import 'package:gestor_de_inventario/Models/usuario.dart';

class MainPageVM {
  ServiceLogin _service = ServiceLogin.getInstance();
  ServiceAlmacenes _serviceAlmacenes = ServiceAlmacenes.getInstance();
  MainPageVM();
  Usuario? _usuario = null;
  List<Almacen> _listaAlmacenes = [];

  Future<Usuario?> iniciarSesion() async {
    ServiceLogin service = ServiceLogin.getInstance();
    service.readTokenFromStorage().then((value) {
      service.loginWithToken().then((value) {
        if (value == null) {
          return null;
        } else {
          _usuario = value;

          return value;
        }
      }).catchError((e) {
        return null;
      });
    }).catchError((err) {
      return null;
    });
  }

  Future<bool> eliminarAlmacen(Almacen almacen) async {
    bool? eliminado = await _serviceAlmacenes.eliminarAlmacen(almacen);
    if (eliminado != null) {
      return true;
    } else {
      return false;
    }
  }

  refrescarUsuario() {
    _usuario = _service.usuario;
  }

  refrescarListaAlmacenes() {
    if (_usuario == null) {
      this._listaAlmacenes = [];
    } else {
      this._listaAlmacenes = _usuario!.listaAlmacenes;
    }
  }

  ServiceLogin get service => _service;
  Usuario? get usuario => usuario;

  List<Almacen> get listaAlmacenes => _listaAlmacenes;
}
