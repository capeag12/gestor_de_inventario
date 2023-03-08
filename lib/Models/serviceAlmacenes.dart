import 'dart:convert';

import 'package:gestor_de_inventario/Models/almacen.dart';
import 'package:gestor_de_inventario/Models/serviceLogin.dart';
import 'package:http/http.dart' as http;

class ServiceAlmacenes {
  late List<Almacen> almacenes;
  ServiceLogin _serviceLogin = ServiceLogin.getInstance();
  final String _baseURL = "http://localhost:3000";
  static ServiceAlmacenes _service = ServiceAlmacenes();
  _ServiceAlmacenes() {
    almacenes = [];
    getAlmacenesFromUser();
  }

  getAlmacenesFromUser() {
    if (_serviceLogin.usuario != null) {
      almacenes = _serviceLogin.usuario!.listaAlmacenes;
    }
    return almacenes;
  }

  static getInstance() {
    if (_service == null) {
      _service = ServiceAlmacenes();
    }
    return _service;
  }

  Future<Almacen?> addAlmacen(String nombre, String direccion) async {
    final String url = "$_baseURL/almacenes/crearAlmacen";
    try {
      var respuesta = await http.post(
        Uri.parse(url),
        headers: _serviceLogin.getHeaders(),
        body: jsonEncode({
          "nombre": nombre,
          "direccion": direccion,
          "imagen": "imagenNueva",
        }),
      );
      var decoded = jsonDecode(respuesta.body);

      Almacen almacen = Almacen(
        decoded['_id'],
        decoded['nombre'],
        decoded['direccion'],
      );

      almacenes.add(almacen);

      return almacen;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
