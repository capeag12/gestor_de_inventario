import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gestor_de_inventario/Models/movimiento.dart';

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
              showDialog(
                  context: context,
                  builder: (BuildContext context) => Container(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: Dialog(
                            child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Container(
                                      child: Text("Almacen Origen: " +
                                          _movimiento.fechaCreacion.toString()),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                      ));
            },
            child: Container(
              padding: EdgeInsets.all(15),
              child: Row(children: [
                Expanded(
                    child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      _movimiento.almacenOrigen?.nombre ?? "Added from outside",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                )),
                Container(
                    alignment: Alignment.center,
                    child: Icon(Icons.arrow_forward_ios)),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Text("Nombre Almacen 2",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                )
              ]),
            ),
          ),
        ));
  }
}
