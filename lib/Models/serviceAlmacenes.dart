import 'dart:convert';
import 'dart:math';
import 'package:gestor_de_inventario/Models/Item.dart';
import 'package:gestor_de_inventario/Models/ItemAlmacen.dart';
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

  Future<bool?> obtenerItemsAlmacen(Almacen a) async {
    final String url = "$_baseURL/almacenes/getItemsAlmacen/${a.id}";
    try {
      var respuesta = await http.get(
        Uri.parse(url),
        headers: _serviceLogin.getHeaders(),
      );
      print("");
      if (respuesta.statusCode == 404 || respuesta.statusCode == 500) {
        return false;
      } else if (respuesta.statusCode == 200) {
        var decoded = jsonDecode(respuesta.body);
        print(decoded);
        decoded.forEach((element) {
          num valorParser = element['item']['valor'];
          print(element);
          a.listaItems.add(ItemAlmacen(
              element["id"],
              Item(element["item"]["_id"], element["item"]["nombre"],
                  valorParser.toDouble()),
              element["cantidad"]));
        });
        print(a.listaItems);
        return true;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<ItemAlmacen?> agregarItem(ItemAlmacen itemadd, Almacen almacen) async {
    final String url = "$_baseURL/almacenes/addProducto/${almacen.id}";
    try {
      var respuesta = await http.put(
        Uri.parse(url),
        headers: _serviceLogin.getHeaders(),
        body: jsonEncode({
          "nombre": itemadd.item.nombre,
          "valor": itemadd.item.valor,
          "cantidad": itemadd.cantidad,
        }),
      );
      if (respuesta.statusCode == 404 ||
          respuesta.statusCode == 400 ||
          respuesta.statusCode == 500) {
        return null;
      } else if (respuesta.statusCode == 201) {
        var decoded = jsonDecode(respuesta.body);
        num valorParser = decoded['item']['valor'];
        ItemAlmacen item = ItemAlmacen(
          decoded['id'],
          Item(decoded['item']['_id'], decoded['item']['nombre'],
              valorParser.toDouble()),
          decoded['cantidad'],
        );

        almacen.listaItems.add(item);
        return item;
      }
      return null;
    } catch (e) {
      print(e);

      return null;
    }
  }

  Future<bool> actualizarMercancia(Almacen origen, Almacen destino,
      List<ItemAlmacen> added, List<ItemAlmacen> restados) async {
    final String url = "$_baseURL/almacenes/actualizarMercancia";
    try {
      String encoded = jsonEncode({
        "start": origen.id,
        "end": destino.id,
        "added": added,
        "restados": restados,
      });
      var respuesta = await http.put(
        Uri.parse(url),
        headers: _serviceLogin.getHeaders(),
        body: encoded,
      );
      if (respuesta.statusCode != 200) {
        return false;
      } else if (respuesta.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print(e);

      return false;
    }

    return true;
  }
}
