import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gestor_de_inventario/Models/almacen.dart';
import 'package:gestor_de_inventario/pages/almacen_page.dart';

class AlmacenWidget extends StatelessWidget {
  late Almacen _almacen;

  AlmacenWidget(this._almacen);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 12),
      child: Card(
        child: InkWell(
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => Almacen_Page(_almacen)));
            print("Almacen pulsado");
          },
          child: Container(
            padding: EdgeInsets.all(15),
            child: Row(children: [
              Container(
                child: Image.asset(
                  "assets/images/default.png",
                  fit: BoxFit.contain,
                  width: 50,
                  height: 50,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_almacen.nombre,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Text(
                      _almacen.direccion,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
