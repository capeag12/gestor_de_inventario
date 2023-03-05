import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gestor_de_inventario/pages/main_page.dart';

class Almacen_Page extends StatefulWidget {
  const Almacen_Page({super.key});

  @override
  State<Almacen_Page> createState() => _Almacen_PageState();
}

class _Almacen_PageState extends State<Almacen_Page> {
  _returnToMainPage() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Main_Page()));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
              title: Text("Nombre del almacen"),
              backgroundColor: Colors.cyan,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  _returnToMainPage();
                },
              )),
          body: Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: ListView(
                children: [DetallesAlmacen()],
              )),
        ),
        onWillPop: () async {
          _returnToMainPage();
          return false;
        });
  }
}

class DetallesAlmacen extends StatelessWidget {
  const DetallesAlmacen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isScreenWide = MediaQuery.of(context).size.width > 600;

    return Container(
      padding: EdgeInsets.only(bottom: 12),
      child: Card(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Flex(
            direction: isScreenWide ? Axis.horizontal : Axis.vertical,
            children: [
              Image.asset(
                "assets/images/default.png",
                fit: BoxFit.contain,
                height: 150,
              ),
              Container(
                padding: EdgeInsets.only(left: 15),
                color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        "Nombre del almacenNombre del almacenNombre del almacenNombre del almacen",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    Text("Ubicacion"),
                    Text("Descripcion"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
