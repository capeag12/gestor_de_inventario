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
            title: Text(
              "Permisos",
              style: TextStyle(color: Color.fromARGB(227, 248, 248, 202)),
            ),
            backgroundColor: Color.fromARGB(255, 164, 22, 34),
            leading: IconButton(
              icon: Icon(Icons.arrow_back,
                  color: Color.fromARGB(227, 248, 248, 202)),
              onPressed: () {
                _returnToMainPage();
              },
            ),
          ),
          body: Container(
            color: Colors.grey[200],
            padding: EdgeInsets.only(left: 15, right: 15),
            child: ListView(
              children: [PermisoWidget(), PermisoWidget(), PermisoWidget()],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: Icon(
              Icons.add,
              color: Color.fromARGB(227, 248, 248, 202),
            ),
            backgroundColor: Color.fromARGB(255, 164, 22, 34),
          )),
    );
  }
}
