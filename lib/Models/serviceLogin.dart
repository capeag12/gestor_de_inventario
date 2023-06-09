import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gestor_de_inventario/Models/almacen.dart';
import 'package:http/http.dart' as http;
import 'package:gestor_de_inventario/Models/usuario.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ServiceLogin {
  Usuario? _usuario;
  static ServiceLogin? _service;
  final String _baseURL =
      "http://10.0.2.2:3000"; //cambiar a "http://10.0.2.2:3000" para probar en el emulador, cambiar a "http://localhost:3000" para probar en el ordenador
  String _token = "";

  _Service() {
    _usuario = null;
  }

  login(String email, String password) {}

  static getInstance() {
    if (_service == null) {
      _service = ServiceLogin();
    }
    return _service;
  }

  Future<Usuario?> realizarLogin(String email, String password) async {
    final String url = "$_baseURL/usuarios/login";
    try {
      var respuesta = await http.post(
        Uri.parse(url),
        headers: getHeaders(),
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );
      var decoded = jsonDecode(respuesta.body);

      Usuario usuario = Usuario(decoded['usuario']['_id'],
          decoded['usuario']['nombre'], decoded['usuario']['email']);

      _token = decoded['token'];
      await writeToken();
      _usuario = usuario;

      return _usuario;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Usuario?> loginWithToken() async {
    final String url = "$_baseURL/usuarios/loginToken";
    try {
      var respuesta = await http.post(Uri.parse(url), headers: getHeaders());

      var decoded = jsonDecode(respuesta.body);

      Usuario usuario = Usuario(decoded['usuario']['_id'],
          decoded['usuario']['nombre'], decoded['usuario']['email']);
      for (var element in decoded['almacenes']) {
        Almacen almacen =
            Almacen(element['_id'], element['nombre'], element['direccion']);
        usuario.addAlmacen(almacen);
      }

      _usuario = usuario;

      return _usuario;
    } catch (e) {
      print(e);
      return null;
    }
  }

  getHeaders() {
    return {
      "Content-Type": "application/json",
      "Access-Control-Allow-Origin": "*",
      "Authorization": "Bearer ${getToken()}"
    };
  }

  writeToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', _token);
    } catch (e) {
      print(e);
    }
  }

  Future<String> readTokenFromStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _token = prefs.getString('token') ?? "";
      return _token;
    } catch (e) {
      print(e);
      return "";
    }
  }

  Future<void> removeToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
    } catch (e) {
      print(e);
    }
  }

  Future<void> logout() async {
    final String url = "$_baseURL/usuarios/logout";
    try {
      var respuesta = await http.post(Uri.parse(url), headers: getHeaders());
    } catch (e) {
      print(e);
    }
  }

  Future<bool> cambiarAvatar(String path) async {
    final String url = "$_baseURL/usuarios/me/avatar";
    try {
      var headers = {
        "Access-Control-Allow-Origin": "*",
        "Authorization": "Bearer ${getToken()}"
      };

      var request = http.MultipartRequest('PATCH', Uri.parse(url));
      var image = await http.MultipartFile.fromPath('avatar', path);
      request.files.add(image);
      request.headers.addAll(headers);

      var respuesta = await request.send();
      print(respuesta.statusCode);
      if (respuesta.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<XFile?> getAvatar() async {
    final String url = "$_baseURL/usuarios/me/avatar";
    try {
      var respuesta = await http.get(
        Uri.parse(url),
        headers: getHeaders(),
      );
      if (respuesta.statusCode == 200) {
        Directory tempDir = await getTemporaryDirectory();
        String tempPath = tempDir.path;

        File file = File('$tempPath/avatar.png');

        bool existe = await file.exists();
        if (existe == true) {
          await file.delete();
        }
        imageCache.clear();
        await file.writeAsBytes(respuesta.bodyBytes);
        return XFile(file.path);
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> logoutAll() async {
    final String url = "$_baseURL/usuarios/logoutAll";
    try {
      var respuesta = await http.post(Uri.parse(url), headers: getHeaders());
      await removeToken();
      if (respuesta.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  getToken() {
    return _token;
  }

  setToken(String token) {
    _token = token;
  }

  Usuario? get usuario => _usuario;

  Future<Usuario?> registrarme(
      String nombre, String email, String password) async {
    final String url = "$_baseURL/usuarios/registrarUsuario";
    try {
      var respuesta = await http.post(
        Uri.parse(url),
        headers: getHeaders(),
        body: jsonEncode({
          "nombre": nombre,
          "email": email,
          "password": password,
        }),
      );
      var decoded = jsonDecode(respuesta.body);

      Usuario usuario = Usuario(decoded['usuario']['_id'],
          decoded['usuario']['nombre'], decoded['usuario']['email']);

      _token = decoded['token'];
      await writeToken();
      _usuario = usuario;
      print(_usuario);
      return _usuario;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
