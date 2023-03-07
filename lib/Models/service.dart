import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:gestor_de_inventario/Models/usuario.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Service {
  Usuario? _usuario;
  static Service? _service;
  final String _baseURL = "http://localhost:3000";
  String _token = "";

  _Service() {
    _usuario = null;
  }

  login(String email, String password) {}

  static getInstance() {
    if (_service == null) {
      _service = Service();
    }
    return _service;
  }

  Future<Usuario?> realizarLogin(String email, String password) async {
    final String url = _baseURL + "/usuarios/login";
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
      print(_usuario);
      return _usuario;
      ;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Usuario?> loginWithToken() async {
    final String url = _baseURL + "/usuarios/loginToken";
    try {
      var respuesta = await http.post(Uri.parse(url), headers: getHeaders());
      var decoded = jsonDecode(respuesta.body);

      Usuario usuario = Usuario(decoded['usuario']['_id'],
          decoded['usuario']['nombre'], decoded['usuario']['email']);

      _usuario = usuario;
      print(_usuario);
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
    final String url = _baseURL + "/usuarios/logout";
    try {
      var respuesta = await http.post(Uri.parse(url), headers: getHeaders());
    } catch (e) {
      print(e);
    }
  }

  getToken() {
    return _token;
  }

  setToken(String token) {
    _token = token;
  }
}
