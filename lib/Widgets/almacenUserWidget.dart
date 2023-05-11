import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AlmacenUserWidget extends StatelessWidget {
  late String nombre;

  AlmacenUserWidget(this.nombre);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 2, right: 2),
      height: MediaQuery.of(context).size.height > 400 ? 45 : 34,
      child: Card(
          child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                nombre,
                style: TextStyle(
                    fontSize:
                        MediaQuery.of(context).size.height > 400 ? 17 : 10,
                    color: Colors.black),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      )),
    );
  }
}
