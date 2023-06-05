import 'package:gestor_de_inventario/Models/permiso.dart';
import 'package:gestor_de_inventario/Models/servicePermisos.dart';

class PermisosVM {
  List<Permiso> listaPermisos = [];
  ServicePermisos _servicePermisos = ServicePermisos.getInstance();
  String? tipoPermiso = "Movimientos";
  String nombrePermiso = "";

  PermisosVM();

  Future<List<Permiso>> getPermisos() async {
    listaPermisos = await _servicePermisos.getPermisos() ?? [];
    return listaPermisos;
  }

  Future<bool> addPermiso() async {
    Permiso? permiso =
        await _servicePermisos.addPermiso(nombrePermiso, tipoPermiso!);
    if (permiso != null) {
      listaPermisos.add(permiso);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deletePermiso(String id) async {
    return await _servicePermisos.eliminarPermiso(id);
  }
}
