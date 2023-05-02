import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gestor_de_inventario/Models/movimiento.dart';
import 'package:gestor_de_inventario/Widgets/widgetItemMov.dart';

class Movimiento_Widget extends StatelessWidget {
  late Movimiento _movimiento;

  Movimiento_Widget(this._movimiento);

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
                        height: MediaQuery.of(context).size.height * 0.8,
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
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'Almacen Origen: ${_movimiento.almacenOrigen?.nombre ?? "Added from outside"}'),
                                          Text(
                                              '${_movimiento.fechaCreacion.day}-${_movimiento.fechaCreacion.month}-${_movimiento.fechaCreacion.year}'),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                              'Almacen Origen: ${_movimiento.almacenOrigen?.nombre ?? "Added from outside"}'),
                                          Text(
                                              'Valor total: ${_movimiento.valorTotal} €'),
                                        ],
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
                                              .toList())))
                            ],
                          ),
                        )),
                      ));
            },
            child: Container(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            '${_movimiento.almacenOrigen?.nombre ?? "Added from outside"}',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        Container(
                          child: Text(
                              '${_movimiento.fechaCreacion.day}-${_movimiento.fechaCreacion.month}-${_movimiento.fechaCreacion.year}'),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          alignment: Alignment.centerRight,
                          child: Text('${_movimiento.almacenDestino.nombre}',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold)),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          child:
                              Text('Valor total: ${_movimiento.valorTotal} €'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
