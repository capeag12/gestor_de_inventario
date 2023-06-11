import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gestor_de_inventario/Models/movimiento.dart';
import 'package:gestor_de_inventario/Models/serviceMovimientos.dart';
import 'package:gestor_de_inventario/Widgets/Noti.dart';
import 'package:gestor_de_inventario/Widgets/widgetItemMov.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class Movimiento_Widget extends StatelessWidget {
  late Movimiento _movimiento;
  bool loading = false;

  ServiceMovimientos _serviceMovimientos = ServiceMovimientos();

  Movimiento_Widget(this._movimiento) {
    Noti.initialize(flutterLocalNotificationsPlugin);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 2, bottom: 2),
        child: Card(
          child: InkWell(
            onTap: () {
              print(_movimiento.items);
              showDialog(
                  context: context,
                  builder: (BuildContext context) => Container(
                        height: MediaQuery.of(context).size.height * 0.95,
                        child: Dialog(
                            child: Container(
                                child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(15),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              '${_movimiento.almacenOrigen ?? "Added from outside"}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                              '${_movimiento.almacenDestino ?? "Eliminados"}',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    )
                                  ]),
                            ),
                            Expanded(
                                child: Container(
                                    padding:
                                        EdgeInsets.only(left: 12, right: 12),
                                    child: ListView(
                                        shrinkWrap: true,
                                        children: _movimiento.items
                                            .map((e) => WidgetItemMov(e))
                                            .toList()))),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: 15, right: 15, bottom: 7),
                                    child: Column(
                                      children: [
                                        Text(
                                          '${_movimiento.valorTotal.toStringAsFixed(2)} €',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '${_movimiento.fechaCreacion.day}-${_movimiento.fechaCreacion.month}-${_movimiento.fechaCreacion.year}',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      padding: EdgeInsets.only(
                                          left: 15, right: 15, bottom: 7),
                                      child: TextButton(
                                        onPressed: () {
                                          showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                      title: Text(
                                                          'Obteniendo PDF'),
                                                      content: Container(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            CircularProgressIndicator(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        164,
                                                                        22,
                                                                        34)),
                                                          ],
                                                        ),
                                                      )));
                                          _serviceMovimientos
                                              .getAsPDF(_movimiento.id)
                                              .then((value) {
                                            if (value == true) {
                                              if (Platform.isAndroid) {
                                                Noti.showBigTextNotification(
                                                    title: "PDF Guardado",
                                                    body:
                                                        'PDF Guardado en la carpeta Downloads del teléfono',
                                                    fln:
                                                        flutterLocalNotificationsPlugin);
                                              } else if (Platform.isWindows) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'PDF Guardado correctamente'),
                                                  duration:
                                                      Duration(seconds: 3),
                                                ));
                                              }
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Error al guardar el PDF'),
                                                duration: Duration(seconds: 3),
                                              ));
                                            }
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: Text('Generar PDF'),
                                      )),
                                ])
                          ],
                        ))),
                      ));
            },
            child: Container(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                                '${_movimiento.almacenOrigen ?? "Added from outside"}',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2),
                          ),
                          Container(
                            child: Text(
                                '${_movimiento.fechaCreacion.day}-${_movimiento.fechaCreacion.month}-${_movimiento.fechaCreacion.year}',
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                                _movimiento.almacenDestino ?? "Eliminado",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.end,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Valor total: ${_movimiento.valorTotal.toStringAsFixed(2)} €',
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
