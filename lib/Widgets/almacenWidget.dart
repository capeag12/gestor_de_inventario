import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AlmacenWidget extends StatefulWidget {
  const AlmacenWidget({super.key});

  @override
  State<AlmacenWidget> createState() => _AlmacenWidgetState();
}

class _AlmacenWidgetState extends State<AlmacenWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 12),
      child: Card(
        child: InkWell(
          onTap: () {
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
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Nombre del almacén",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Text(
                      "Calle la loba Nº15 11170, Paterna de Rivera",
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
