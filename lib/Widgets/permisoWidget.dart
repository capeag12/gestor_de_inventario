import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PermisoWidget extends StatefulWidget {
  const PermisoWidget({super.key});

  @override
  State<PermisoWidget> createState() => _PermisoWidgetState();
}

class _PermisoWidgetState extends State<PermisoWidget> {
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
              Text("Nombre usuario permiso",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(
                "Descripción del permiso",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          )),
          IconButton(onPressed: () {}, icon: Icon(Icons.info)),
          IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
        ]),
      ),
    );
  }
}
