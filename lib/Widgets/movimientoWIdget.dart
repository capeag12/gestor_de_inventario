import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Movimiento_Widget extends StatelessWidget {
  const Movimiento_Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 2, bottom: 2),
        child: Card(
          child: InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(15),
              child: Row(children: [
                Expanded(
                    child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text("Nombre Almacen",
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
