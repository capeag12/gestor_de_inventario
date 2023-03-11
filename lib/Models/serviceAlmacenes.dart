import 'dart:convert';

import 'package:gestor_de_inventario/Models/almacen.dart';
import 'package:gestor_de_inventario/Models/serviceLogin.dart';
import 'package:http/http.dart' as http;

class ServiceAlmacenes {
  ServiceLogin _serviceLogin = ServiceLogin.getInstance();

  final String _baseURL = "http://localhost:3000";
  static ServiceAlmacenes _service = ServiceAlmacenes();
  _ServiceAlmacenes() {}

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

      if (respuesta.statusCode == 404 || respuesta.statusCode == 400) {
        return null;
      } else if (respuesta.statusCode == 201) {
        var decoded = jsonDecode(respuesta.body);

        Almacen almacen = Almacen(
          decoded['_id'],
          decoded['nombre'],
          decoded['direccion'],
        );
        _serviceLogin.usuario!.listaAlmacenes.add(almacen);

        return almacen;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool?> eliminarAlmacen(Almacen a) async {
    final String url = "$_baseURL/almacenes/eliminarAlmacen/${a.id}";
    try {
      var respuesta = await http.delete(
        Uri.parse(url),
        headers: _serviceLogin.getHeaders(),
      );
      print("");
      if (respuesta.statusCode == 404 || respuesta.statusCode == 500) {
        return false;
      } else if (respuesta.statusCode == 204) {
        _serviceLogin.usuario!.listaAlmacenes.remove(a);

        return true;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
