import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gestor_de_inventario/Models/Item.dart';
import 'package:gestor_de_inventario/Models/ItemAlmacen.dart';
import 'package:gestor_de_inventario/Models/almacen.dart';
import 'package:gestor_de_inventario/VM/almacenPageVM.dart';
import 'package:gestor_de_inventario/Widgets/almacenWidgetEnviar.dart';
import 'package:gestor_de_inventario/Widgets/itemWidget.dart';
import 'package:gestor_de_inventario/Widgets/widgetCambio.dart';
import 'package:gestor_de_inventario/pages/dialogAddItem.dart';
import 'package:gestor_de_inventario/pages/main_page.dart';

class Almacen_Page extends StatefulWidget {
  Almacen a;
  Almacen_Page(this.a);
  @override
  State<Almacen_Page> createState() => _Almacen_PageState(a);
}

class _Almacen_PageState extends State<Almacen_Page> {
  late Almacen almacen;
  late AlmacenpageVM vm;
  bool loading = true;

  _Almacen_PageState(this.almacen) {
    vm = AlmacenpageVM(almacen);
    vm.obtenerItemsAlmacen().then((value) {
      print(value);
      setState(() {
        loading = false;
      });
    });
  }

  void addItem(itemAl) {
    setState(() {
      vm.addItemToSet(itemAl);
    });
  }

  void registrarMovimiento(Almacen a, BuildContext c) {
    vm.registrarMovimiento(a).then((value) {
      if (value == true) {
        ScaffoldMessenger.of(c).showSnackBar(SnackBar(
          content: Text("Movimiento registrado correctamente"),
        ));
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Main_Page()));
      } else {
        Navigator.pop(context);
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (BuildContext c) => AlertDialog(
                  title: Text("Error"),
                  content: Text("No se ha podido registrar el movimiento"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(c);
                      },
                      child: Text("Aceptar"),
                    )
                  ],
                ));
      }
    }).catchError((onError) {
      print(onError);
    });
  }

  _returnToMainPage() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Main_Page()));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              almacen.nombre,
              style: TextStyle(color: Color.fromARGB(255, 248, 248, 202)),
            ),
            backgroundColor: Color.fromARGB(255, 164, 22, 34),
            leading: IconButton(
              color: Color.fromARGB(255, 248, 248, 202),
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                _returnToMainPage();
              },
            ),
            actions: [
              vm.getListCambiados().length != 0
                  ? Container(
                      margin: EdgeInsets.only(right: 10),
                      child: IconButton(
                          onPressed: () {
                            //Create a dialog
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.8,
                                      child: Dialog(
                                        child: Container(
                                          child: Column(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(
                                                    top: 10, bottom: 10),
                                                child: Text(
                                                  "Cambios",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      left: 12, right: 12),
                                                  child: ListView(
                                                      shrinkWrap: true,
                                                      children: vm
                                                          .getListCambiados()
                                                          .toList()
                                                          .map((e) =>
                                                              WidgetCambio(e))
                                                          .toList()),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        top: 10,
                                                        bottom: 10,
                                                        left: 10),
                                                    child: TextButton(
                                                        onPressed: () {
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                          build) =>
                                                                      Container(
                                                                        height: MediaQuery.of(context).size.height *
                                                                            0.8,
                                                                        child:
                                                                            Dialog(
                                                                          child:
                                                                              Container(
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                Container(
                                                                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                                                                  child: Text(
                                                                                    "¿A donde deseas enviar los items restados?",
                                                                                    textAlign: TextAlign.center,
                                                                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                ),
                                                                                Expanded(
                                                                                  child: Container(
                                                                                    padding: EdgeInsets.only(left: 12, right: 12),
                                                                                    child: ListView(shrinkWrap: true, children: vm.serviceLogin.usuario == null ? [] : vm.serviceLogin.usuario!.getListaAlmacenesPodada(vm.almacen).map((e) => AlmacenWidgetEnviar(e, registrarMovimiento)).toList()),
                                                                                  ),
                                                                                ),
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    Container(
                                                                                      padding: EdgeInsets.only(top: 10, bottom: 10, right: 10),
                                                                                      child: TextButton(
                                                                                          onPressed: () {
                                                                                            registrarMovimiento(Almacen("", "", ""), context);
                                                                                          },
                                                                                          child: Text(
                                                                                            "Eliminar restados",
                                                                                          )),
                                                                                    ),
                                                                                    Container(
                                                                                      padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
                                                                                      child: TextButton(
                                                                                          onPressed: () {
                                                                                            Navigator.pop(context);
                                                                                          },
                                                                                          child: Text(
                                                                                            "Cerrar",
                                                                                            style: TextStyle(color: Color.fromARGB(255, 255, 64, 64)),
                                                                                          )),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ));
                                                        },
                                                        child: Text("Aceptar")),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        top: 10,
                                                        bottom: 10,
                                                        right: 10),
                                                    child: TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          "Cerrar",
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      255,
                                                                      64,
                                                                      64)),
                                                        )),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ));
                          },
                          icon: Icon(
                            Icons.maps_home_work_outlined,
                            color: Color.fromARGB(255, 248, 248, 202),
                          )))
                  : Container()
            ],
          ),
          body: Container(
              color: Colors.grey[200],
              padding: EdgeInsets.only(left: 15, right: 15),
              child: loading == true
                  ? Center(
                      child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 164, 22, 34),
                    ))
                  : Column(
                      mainAxisAlignment: vm.almacen.listaItems.length == 0
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.start,
                      children: [
                        vm.almacen.listaItems.length == 0
                            ? Container(
                                child: Center(
                                  child: Text("No hay items en este almacen"),
                                ),
                              )
                            : Expanded(
                                child: ListView(
                                children: vm.almacen.listaItems
                                    .map((e) => Item_Widget(e, addItem))
                                    .toList(),
                              ))
                      ],
                    )),
          floatingActionButton: FloatingActionButton.small(
            onPressed: () async {
              await DialogAddItem.dialogAddItem(context, almacen);
              setState(() {
                almacen;
              });
            },
            child: Icon(Icons.add, color: Color.fromARGB(227, 248, 248, 202)),
            backgroundColor: Color.fromARGB(255, 164, 22, 34),
          ),
        ),
        onWillPop: () async {
          _returnToMainPage();
          return false;
        });
  }
}
