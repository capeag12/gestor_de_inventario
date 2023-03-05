import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gestor_de_inventario/Widgets/almacenWidget.dart';
import 'package:gestor_de_inventario/pages/menu_lateral.dart';

class Main_Page extends StatefulWidget {
  const Main_Page({super.key});

  @override
  State<Main_Page> createState() => _Main_PageState();
}

class _Main_PageState extends State<Main_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gestor de Inventario"),
        backgroundColor: Colors.cyan,
      ),
      drawer: Menu_Lateral.CrearMenuLateral(context),
      body: Container(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: ListView(
          children: [AlmacenWidget(), AlmacenWidget(), AlmacenWidget()],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Colors.cyan,
      ),
    );
  }
}
