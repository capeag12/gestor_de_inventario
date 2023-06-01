import 'package:gestor_de_inventario/Models/permiso.dart';
import 'package:gestor_de_inventario/Models/servicePermisos.dart';

class PermisosVM {
  List<Permiso> listaPermisos = [];
  ServicePermisos _servicePermisos = ServicePermisos.getInstance();
  PermisosVM();

  Future<List<Permiso>> getPermisos() async {
    listaPermisos = await _servicePermisos.getPermisos() ?? [];
    return listaPermisos;
  }
}
