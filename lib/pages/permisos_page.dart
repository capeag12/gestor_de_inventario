import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gestor_de_inventario/Widgets/permisoWidget.dart';
import 'package:gestor_de_inventario/pages/main_page.dart';

class Permisos_Page extends StatefulWidget {
  const Permisos_Page({super.key});

  @override
  State<Permisos_Page> createState() => _Permisos_PageState();
}

class _Permisos_PageState extends State<Permisos_Page> {
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
            title: Text("Permisos"),
            backgroundColor: Colors.cyan,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                _returnToMainPage();
              },
            ),
          ),
          body: Container(
            child: ListView(
              children: [PermisoWidget(), PermisoWidget(), PermisoWidget()],
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
