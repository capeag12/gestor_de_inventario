import 'package:flutter/material.dart';
import 'package:gestor_de_inventario/Widgets/movimientoWIdget.dart';
import 'package:gestor_de_inventario/Widgets/permisoWidget.dart';
import 'package:gestor_de_inventario/pages/main_page.dart';

class Movimientos_Page extends StatefulWidget {
  const Movimientos_Page({super.key});

  @override
  State<Movimientos_Page> createState() => _Movimientos_PageState();
}

class _Movimientos_PageState extends State<Movimientos_Page> {
  _returnToMainPage() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Main_Page()));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _returnToMainPage();
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text("Movimientos"),
            backgroundColor: Colors.cyan,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                _returnToMainPage();
              },
            ),
          ),
          body: Container(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: ListView(
              children: [
                Movimiento_Widget(),
                Movimiento_Widget(),
                Movimiento_Widget()
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.add),
            backgroundColor: Colors.cyan,
          )),
    );
  }
}
