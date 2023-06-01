import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gestor_de_inventario/Models/permiso.dart';

class PermisoWidget extends StatefulWidget {
  late Permiso permiso;
  PermisoWidget(this.permiso);

  @override
  State<PermisoWidget> createState() => _PermisoWidgetState(this.permiso);
}

class _PermisoWidgetState extends State<PermisoWidget> {
  late Permiso permiso;
  _PermisoWidgetState(this.permiso);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(15),
        child: Row(children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(permiso.nombre ?? "Sin nombre",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          )),
          IconButton(onPressed: () {}, icon: Icon(Icons.info)),
          IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
        ]),
      ),
    );
  }
}
