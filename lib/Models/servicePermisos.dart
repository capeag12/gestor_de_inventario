import 'dart:convert';
import 'dart:math';
import 'package:gestor_de_inventario/Models/Item.dart';
import 'package:gestor_de_inventario/Models/ItemAlmacen.dart';
import 'package:gestor_de_inventario/Models/almacen.dart';
import 'package:gestor_de_inventario/Models/permiso.dart';
import 'package:gestor_de_inventario/Models/serviceLogin.dart';
import 'package:http/http.dart' as http;

class ServicePermisos {
  ServiceLogin _serviceLogin = ServiceLogin.getInstance();

  final String _baseURL =
      "http://localhost:3000"; //cambiar a "http://10.0.2.2:3000" para probar en el emulador, cambiar a "http://localhost:3000" para probar en el ordenador
  static ServicePermisos _service = ServicePermisos();
  _ServicePermisos() {}

  static getInstance() {
    if (_service == null) {
      _service = ServicePermisos();
    }
    return _service;
  }

  Future<List<Permiso>?> getPermisos() async {
    final String url = "$_baseURL/permisos/getPermisos";
    try {
      var respuesta = await http.get(
        Uri.parse(url),
        headers: _serviceLogin.getHeaders(),
      );

      if (respuesta.statusCode == 200) {
        print(respuesta.body);
        var respuestaDecoded = jsonDecode(respuesta.body);
        List<Permiso> listaPermisos = [];

        for (var permiso in respuestaDecoded['permisos']) {
          Permiso p = Permiso(
            permiso['_id'],
            permiso['nombre'],
            permiso['tipo'],
            permiso['tokenAcceso'],
          );
          listaPermisos.add(p);
        }
        return listaPermisos;
      } else {
        return null;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
