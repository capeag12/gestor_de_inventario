import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gestor_de_inventario/Models/almacen.dart';
import 'package:gestor_de_inventario/Models/serviceLogin.dart';
import 'package:gestor_de_inventario/VM/mainPageVM.dart';
import 'package:gestor_de_inventario/Widgets/almacenWidget.dart';
import 'package:gestor_de_inventario/pages/dialogAddAlmacen.dart';
import 'package:gestor_de_inventario/pages/menu_lateral.dart';

class Main_Page extends StatefulWidget {
  const Main_Page({super.key});

  @override
  State<Main_Page> createState() => _Main_PageState();
}

class _Main_PageState extends State<Main_Page> {
  bool loading = true;
  MainPageVM _mainPageVM = MainPageVM();
  _Main_PageState() {
    iniciarSesion();
  }

  void eliminarAlmacen(Almacen a) async {
    setState(() {
      loading = true;
    });
    bool eliminado = await _mainPageVM.eliminarAlmacen(a);
    print(eliminado);
    if (eliminado == true) {
      setState(() {
        _mainPageVM.refrescarListaAlmacenes();
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Almacen eliminado"),
      ));
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("No se pudo eliminar el almacen"),
      ));
    }
  }

  iniciarSesion() {
    ServiceLogin service = ServiceLogin.getInstance();
    service.readTokenFromStorage().then((value) {
      service.loginWithToken().then((value) {
        if (value == null) {
          Navigator.pushReplacementNamed(context, "/login");
        } else {}
        setState(() {
          loading = false;
          _mainPageVM.refrescarUsuario();
          _mainPageVM.refrescarListaAlmacenes();
        });
      }).catchError((e) {});
    }).catchError((err) {
      Navigator.pushReplacementNamed(context, "/login");
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gestor de Inventario"),
        backgroundColor: Colors.cyan,
      ),
      drawer: loading ? null : Menu_Lateral.CrearMenuLateral(context),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: _mainPageVM.listaAlmacenes.isEmpty == true
                  ? Center(
                      child: Text("No hay almacenes"),
                    )
                  : ListView(
                      children: _mainPageVM.listaAlmacenes
                          .map((almacen) =>
                              AlmacenWidget(almacen, eliminarAlmacen))
                          .toList(),
                    )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          {
            DialogAddAlmacen.dialogAddAlmacen(context).then((value) {
              setState(() {
                _mainPageVM.refrescarListaAlmacenes();
              });
              print("Lista pagina ${_mainPageVM.listaAlmacenes}");
            });
          }
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.cyan,
      ),
    );
  }
}
