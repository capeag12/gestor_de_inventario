import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class WidgetCambio extends StatelessWidget {
  const WidgetCambio({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Card(
          child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                "Nombre del item",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 15),
            child: Text("Cantidad",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
        ],
      )),
    );
  }
}
