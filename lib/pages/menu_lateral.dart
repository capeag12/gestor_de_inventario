import 'package:flutter/material.dart';
import 'package:gestor_de_inventario/Models/serviceLogin.dart';
import 'package:gestor_de_inventario/Models/usuario.dart';
import 'package:gestor_de_inventario/VM/menu_lateralVM.dart';
import 'package:gestor_de_inventario/pages/login_page.dart';
import 'package:gestor_de_inventario/pages/movimientos_page.dart';
import 'package:gestor_de_inventario/pages/permisos_page.dart';

class Menu_Lateral {
  Menu_Lateral();
  static MenuLateralVM _menuLateralVM = MenuLateralVM();

  static Drawer CrearMenuLateral(BuildContext context) {
    ServiceLogin service = ServiceLogin.getInstance();
    return Drawer(
      child: ListView(children: [
        DrawerHeader(
          decoration: BoxDecoration(color: Colors.cyan),
          child: Container(
              padding: EdgeInsets.only(top: 20, left: 10),
              child: Text(
                "Gestor de Inventario",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              )),
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text("Perfil"),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.inventory_outlined),
          title: Text("Movimientos"),
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => Movimientos_Page()));
          },
        ),
        ListTile(
          leading: Icon(Icons.group),
          title: Text("Permisos"),
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => Permisos_Page()));
          },
        ),
        ListTile(
          leading: Icon(Icons.info_outline),
          title: Text("Acerca de"),
          onTap: () {},
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text("Cerrar Sesión"),
          onTap: () async {
            await _menuLateralVM.cerrarSesion();
            Navigator.pushReplacementNamed(context, "/login");
          },
        ),
      ]),
    );
  }
}
