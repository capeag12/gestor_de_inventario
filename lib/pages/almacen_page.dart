import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gestor_de_inventario/Models/Item.dart';
import 'package:gestor_de_inventario/Models/ItemAlmacen.dart';
import 'package:gestor_de_inventario/Models/almacen.dart';
import 'package:gestor_de_inventario/Widgets/itemWidget.dart';
import 'package:gestor_de_inventario/pages/main_page.dart';

class Almacen_Page extends StatefulWidget {
  Almacen a;
  Almacen_Page(this.a);
  @override
  State<Almacen_Page> createState() => _Almacen_PageState(a);
}

class _Almacen_PageState extends State<Almacen_Page> {
  late Almacen almacen;

  _Almacen_PageState(this.almacen);

  _returnToMainPage() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Main_Page()));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
              title: Text(almacen.nombre),
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
                children: [
                  DetallesAlmacen(this.almacen),
                  Item_Widget(ItemAlmacen(Item("Nombre", 14.47), 9))
                ],
              )),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.add),
            backgroundColor: Colors.cyan,
          ),
        ),
        onWillPop: () async {
          _returnToMainPage();
          return false;
        });
  }
}

class DetallesAlmacen extends StatelessWidget {
  Almacen a;

  DetallesAlmacen(this.a);

  @override
  Widget build(BuildContext context) {
    bool isScreenWide = MediaQuery.of(context).size.width > 600;

    return Container(
      //Arreglar text overflow
      padding: const EdgeInsets.only(bottom: 12),
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
                padding: const EdgeInsets.only(left: 15),
                color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        this.a.nombre,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    Text(this.a.direccion,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(fontSize: 20)),
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
