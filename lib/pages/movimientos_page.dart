import 'package:flutter/material.dart';
import 'package:gestor_de_inventario/VM/movimientoPageVM.dart';
import 'package:gestor_de_inventario/Widgets/menuWidget.dart';
import 'package:gestor_de_inventario/Widgets/movimientoWIdget.dart';
import 'package:gestor_de_inventario/Widgets/permisoWidget.dart';
import 'package:gestor_de_inventario/pages/main_page.dart';

class Movimientos_Page extends StatefulWidget {
  const Movimientos_Page({super.key});

  @override
  State<Movimientos_Page> createState() => _Movimientos_PageState();
}

class _Movimientos_PageState extends State<Movimientos_Page> {
  MovimientoPageVM _movimientoPageVM = MovimientoPageVM();
  bool _cargando = true;
  _Movimientos_PageState() {
    _movimientoPageVM.getMovimientos().then((value) {
      setState(() {
        _cargando = false;
      });
    });
  }
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
          title: Text(
            "Movimientos",
            style: TextStyle(color: Color.fromARGB(227, 248, 248, 202)),
          ),
          backgroundColor: Color.fromARGB(255, 164, 22, 34),
          leading: _movimientoPageVM.serviceLogin.usuario!.tipo == "admin"
              ? IconButton(
                  icon: Icon(Icons.arrow_back,
                      color: Color.fromARGB(227, 248, 248, 202)),
                  onPressed: () {
                    _returnToMainPage();
                  },
                )
              : null,
          actions: [MenuWidget.getPopUpMenuButton()],
        ),
        body: this._cargando == true
            ? Container(
                color: Colors.grey[200],
                child: Center(
                  child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 164, 22, 34)),
                ),
              )
            : this._movimientoPageVM.serviceMovimientos.movimientos.isEmpty ==
                    true
                ? Container(
                    color: Colors.grey[200],
                    child: Center(
                      child: Text("No hay movimientos"),
                    ),
                  )
                : Container(
                    color: Colors.grey[200],
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: ListView(
                      children: _movimientoPageVM.serviceMovimientos.movimientos
                          .map((movimiento) => Movimiento_Widget(movimiento))
                          .toList(),
                    ),
                  ),
      ),
    );
  }
}
