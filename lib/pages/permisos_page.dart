import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gestor_de_inventario/VM/permisosVM.dart';
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

  bool loading = false;

  PermisosVM _permisosVM = PermisosVM();

  _Permisos_PageState() {
    _permisosVM.getPermisos().then((value) => {setState(() {})});
  }

  Future<bool> eliminarPermiso(String id) async {
    bool eliminado = await _permisosVM.deletePermiso(id);
    if (eliminado == true) {
      setState(() {});
    }
    return eliminado;
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
              child: (loading == false)
                  ? _permisosVM.listaPermisos.isEmpty == true
                      ? Center(
                          child: Text("No hay permisos",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        )
                      : ListView(
                          children: _permisosVM.listaPermisos
                              .map((e) => PermisoWidget(e, eliminarPermiso))
                              .toList())
                  : Center(
                      child: CircularProgressIndicator(),
                    )),
          floatingActionButton: FloatingActionButton.small(
            onPressed: () async {
              await showDialog(
                  context: context,
                  builder: (BuildContext contexto) {
                    return StatefulBuilder(
                      builder: (context, setStateSB) => AlertDialog(
                        title: Text("Agregar Permiso"),
                        content: Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextField(
                                    decoration: InputDecoration(
                                        labelText: "Nombre del Permiso"),
                                    onChanged: (value) {
                                      this._permisosVM.nombrePermiso = value;

                                      setStateSB(() {});
                                    }),
                                Container(
                                    padding: EdgeInsets.only(top: 10),
                                    child: DropdownButton(
                                      onChanged: (String? value) {
                                        this._permisosVM.tipoPermiso = value;
                                        setStateSB(() {});
                                        print(this._permisosVM.tipoPermiso);
                                      },
                                      value: this._permisosVM.tipoPermiso,
                                      hint: Text("Tipo de Permiso"),
                                      items: [
                                        DropdownMenuItem<String>(
                                          child: Text("Movimientos"),
                                          value: "Movimientos",
                                        ),
                                        DropdownMenuItem<String>(
                                          child: Text("Almacenes"),
                                          value: "Almacenes",
                                        ),
                                        DropdownMenuItem<String>(
                                          child: Text("Envios"),
                                          value: "Envios",
                                        ),
                                      ],
                                    ))
                              ],
                            ),
                          ),
                        ),
                        actions: [
                          TextButton(
                              onPressed: this
                                          ._permisosVM
                                          .nombrePermiso
                                          .isEmpty ||
                                      this._permisosVM.tipoPermiso!.isEmpty
                                  ? null
                                  : () async {
                                      this.loading = true;

                                      this
                                          ._permisosVM
                                          .addPermiso()
                                          .then((value) async {
                                        if (value == true) {
                                          this._permisosVM.nombrePermiso = "";
                                          this.loading = false;
                                          setState(() {});

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                "Permiso Agregado Correctamente"),
                                            backgroundColor: Color.fromARGB(
                                                255, 164, 22, 34),
                                          ));
                                        } else {
                                          this.loading = false;
                                          setState(() {});
                                          await showDialog(
                                              context: context,
                                              builder:
                                                  (BuildContext contextoError) {
                                                return AlertDialog(
                                                  title: Text(
                                                    "Error",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  content: Text(
                                                      "No se pudo agregar el permiso"),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text("Aceptar"))
                                                  ],
                                                );
                                              });
                                        }
                                      });
                                      Navigator.pop(context);
                                    },
                              child: Text("Agregar")),
                        ],
                      ),
                    );
                  });
            },
            child: Icon(
              Icons.add,
              color: Color.fromARGB(227, 248, 248, 202),
            ),
            backgroundColor: Color.fromARGB(255, 164, 22, 34),
          )),
    );
  }
}
