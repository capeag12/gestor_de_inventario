import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:document_file_save_plus/document_file_save_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:gestor_de_inventario/Models/Item.dart';
import 'package:gestor_de_inventario/Models/almacen.dart';
import 'package:gestor_de_inventario/Models/itemMovimiento.dart';
import 'package:gestor_de_inventario/Models/movimiento.dart';
import 'package:gestor_de_inventario/Models/serviceLogin.dart';
import 'package:http/http.dart' as http;
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ServiceMovimientos {
  ServiceLogin _serviceLogin = ServiceLogin.getInstance();
  final String _baseURL =
      "http://10.0.2.2:3000"; //cambiar a "http://10.0.2.2:3000" para probar en el emulador, cambiar a "http://localhost:3000" para probar en el ordenador
  static ServiceMovimientos? _service;

  List<Movimiento> movimientos = [];

  ServiceMovimientos();

  static getInstance() {
    if (_service == null) {
      _service = ServiceMovimientos();
    }
    return _service;
  }

  Future<List<Movimiento>?> getAllMovements() async {
    final String url = "$_baseURL/movimientos/getAllMovements";
    try {
      var respuesta = await http.get(
        Uri.parse(url),
        headers: _serviceLogin.getHeaders(),
      );

      if (respuesta.statusCode == 200) {
        var decoded = jsonDecode(respuesta.body);

        List<Movimiento> movements = [];

        for (var movimiento in decoded) {
          Almacen? almacenOrigen = null;
          if (movimiento['almacenOrigen'] != null) {
            almacenOrigen = new Almacen(
                movimiento['almacenOrigen']['_id'],
                movimiento['almacenOrigen']['nombre'],
                movimiento['almacenOrigen']['direccion']);
          }

          Almacen almacenDestino = new Almacen(
              movimiento['almacenDestino']['_id'],
              movimiento['almacenDestino']['nombre'],
              movimiento['almacenDestino']['direccion']);
          List<ItemMovimiento> items = [];
          for (var item in movimiento['items']) {
            print(item);
            num valorParser = item['item']['valor'];
            ItemMovimiento itemMovimiento = ItemMovimiento(
                Item(item['item']['_id'], item['item']['nombre'],
                    valorParser.toDouble()),
                item['diferencia']);

            items.add(itemMovimiento);
          }

          Movimiento movimientoNuevo = Movimiento(
              movimiento['id'],
              almacenOrigen,
              almacenDestino,
              movimiento['tipo'],
              DateTime.parse(movimiento['fecha']),
              items);
          print(movimientoNuevo);
          movements.add(movimientoNuevo);
        }
        print(movements);
        this.movimientos = movements;
        return movements;
      } else
        return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> getAsPDF(String idMov) async {
    final String url = "$_baseURL/movimientos/getPDF/$idMov";
    try {
      var respuesta = await http.get(
        Uri.parse(url),
        headers: _serviceLogin.getHeaders(),
      );

      if (respuesta.statusCode == 200) {
        if (Platform.isAndroid) {
          File file = File("/storage/emulated/0/Download/mov$idMov.pdf");
          bool existe = await file.exists();
          if (existe == false) {
            await DocumentFileSavePlus().saveFile(
                respuesta.bodyBytes, "mov$idMov.pdf", "appliation/pdf");
          }

          var result = await OpenFile.open(
            "/storage/emulated/0/Download/mov$idMov.pdf",
            type: "application/pdf",
          );

          print(result.message);
          print("Saved pdf");
        } else if (Platform.isWindows) {
          String? selectedDirectory = await FilePicker.platform
              .getDirectoryPath(
                  dialogTitle:
                      "Por favor, seleccione donde desea guardar el PDF");
          if (selectedDirectory == null) {
            return false;
          } else {
            File file = File("$selectedDirectory/mov$idMov.pdf");
            bool existe = await file.exists();
            if (existe == false) {
              await file.writeAsBytes(respuesta.bodyBytes);
            }
            return true;
          }
        }
        return true;
      } else {
        print(respuesta.statusCode);
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
