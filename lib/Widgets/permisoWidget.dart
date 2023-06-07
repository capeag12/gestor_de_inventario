import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
              Text(permiso.nombre,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          )),
          IconButton(
              onPressed: () async {
                await showDialog(
                    context: context,
                    builder: (BuildContext contextModal) {
                      return AlertDialog(
                        title: Text(
                          "Información del permiso",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Text("Name: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                  Text(permiso.nombre,
                                      style: TextStyle(fontSize: 20)),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  Text("Tipo Permiso: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                  Text(permiso.tipo,
                                      style: TextStyle(fontSize: 20)),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateColor.resolveWith(
                                              (states) => Color.fromARGB(
                                                  255, 164, 22, 34))),
                                  onPressed: () {
                                    Clipboard.setData(ClipboardData(
                                        text: permiso.tokenAcceso));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            backgroundColor: Color.fromARGB(
                                                255, 164, 22, 34),
                                            content: Text(
                                                "Se ha copiado el token de acceso a tu portapapeles")));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    child: Text("Copiar token",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Color.fromARGB(
                                                227, 248, 248, 202))),
                                  )),
                            )
                          ],
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(contextModal).pop();
                              },
                              child: Text("Aceptar")),
                        ],
                      );
                    });
              },
              icon: Icon(Icons.info)),
          IconButton(
              onPressed: () async {
                await showDialog(
                    context: context,
                    builder: (BuildContext contextModal) {
                      return AlertDialog(
                        title: Text("Eliminando permiso"),
                        content: Text(
                            "¿Estas seguro de que quieres eliminar este permiso?"),
                        actions: [
                          TextButton(onPressed: () {}, child: Text("Cancelar")),
                          TextButton(
                              onPressed: () async {
                                Navigator.of(contextModal).pop();
                                bool eliminado =
                                    await deletePermiso(permiso.id);
                                if (eliminado == true) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text("Permiso eliminado"),
                                          backgroundColor: Color.fromARGB(
                                              255, 164, 22, 34)));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "No se pudo eliminar el permiso"),
                                          backgroundColor: Color.fromARGB(
                                              255, 164, 22, 34)));
                                }
                              },
                              child: Text("Aceptar")),
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
