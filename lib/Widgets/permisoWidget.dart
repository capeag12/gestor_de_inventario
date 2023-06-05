import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gestor_de_inventario/Models/permiso.dart';

class PermisoWidget extends StatefulWidget {
  late Permiso permiso;
  Future<bool> Function(String id) deletePermiso;
  PermisoWidget(this.permiso, this.deletePermiso);

  @override
  State<PermisoWidget> createState() =>
      _PermisoWidgetState(this.permiso, this.deletePermiso);
}

class _PermisoWidgetState extends State<PermisoWidget> {
  late Permiso permiso;

  Future<bool> Function(String id) deletePermiso;
  _PermisoWidgetState(this.permiso, this.deletePermiso);

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
          IconButton(
              onPressed: () async {
                await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Eliminando permiso"),
                        content: Text(
                            "¿Estas seguro de que quieres eliminar este permiso?"),
                        actions: [
                          TextButton(onPressed: () {}, child: Text("Cancelar")),
                          TextButton(
                              onPressed: () async {}, child: Text("Aceptar")),
                        ],
                      );
                    });
              },
              icon: Icon(Icons.delete)),
        ]),
      ),
    );
  }
}
