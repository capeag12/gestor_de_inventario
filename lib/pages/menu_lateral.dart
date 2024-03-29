import 'package:flutter/material.dart';
import 'package:gestor_de_inventario/Models/serviceLogin.dart';
import 'package:gestor_de_inventario/Models/usuario.dart';
import 'package:gestor_de_inventario/VM/menu_lateralVM.dart';
import 'package:gestor_de_inventario/pages/envios_page.dart';
import 'package:gestor_de_inventario/pages/login_page.dart';
import 'package:gestor_de_inventario/pages/movimientos_page.dart';
import 'package:gestor_de_inventario/pages/permisos_page.dart';
import 'package:gestor_de_inventario/pages/user_page.dart';
import 'package:url_launcher/url_launcher.dart';

class Menu_Lateral {
  Menu_Lateral();
  static MenuLateralVM _menuLateralVM = MenuLateralVM();

  static Drawer CrearMenuLateral(BuildContext context) {
    ServiceLogin service = ServiceLogin.getInstance();
    return Drawer(
      child: Container(
        child: ListView(children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Color.fromARGB(255, 164, 22, 34)),
            child: Container(
                padding: EdgeInsets.only(top: 20, left: 10),
                child: Text(
                  "Gestor de Inventario",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(227, 248, 248, 202)),
                )),
          ),
          _menuLateralVM.service.usuario!.tipo == "admin"
              ? ListTile(
                  hoverColor: Color.fromARGB(227, 248, 248, 202),
                  leading: Icon(Icons.person),
                  title: Text("Perfil"),
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => User_page()));
                  },
                )
              : Container(),
          _menuLateralVM.service.usuario!.tipo == "admin"
              ? Divider()
              : Container(),
          _menuLateralVM.service.usuario!.tipo == "admin"
              ? ListTile(
                  hoverColor: Color.fromARGB(227, 248, 248, 202),
                  leading: Icon(Icons.inventory),
                  title: Text("Movimientos"),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Movimientos_Page()));
                  },
                )
              : Container(),
          _menuLateralVM.service.usuario!.tipo == "admin"
              ? ListTile(
                  hoverColor: Color.fromARGB(227, 248, 248, 202),
                  leading: Icon(Icons.local_shipping),
                  title: Text("Envios"),
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Envios_Page()));
                  },
                )
              : Container(),
          _menuLateralVM.service.usuario!.tipo == "admin"
              ? ListTile(
                  hoverColor: Color.fromARGB(227, 248, 248, 202),
                  leading: Icon(Icons.group),
                  title: Text("Permisos"),
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Permisos_Page()));
                  },
                )
              : Container(),
          ListTile(
            hoverColor: Color.fromARGB(227, 248, 248, 202),
            leading: Icon(Icons.info),
            title: Text("Acerca de"),
            onTap: () async {
              await showDialog(
                  context: context,
                  builder: (BuildContext builder) => AlertDialog(
                        title: Text(
                          "Acerca de",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        content: Container(
                          child: SingleChildScrollView(
                            child: Column(children: [
                              Row(
                                children: [
                                  Text(
                                    "Documentación de usuario:",
                                  ),
                                  TextButton(
                                      onPressed: () async {
                                        final Uri url = Uri.parse(
                                            'https://first-tornado-84b.notion.site/Gestor-de-Inventario-059f8b0837604120a668c567f56de3d7?pvs=4');
                                        await launchUrl(url);
                                      },
                                      child: Text("Abrir"))
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Documentación de la API:"),
                                  TextButton(
                                      onPressed: () async {
                                        final Uri url = Uri.parse(
                                            'https://documenter.getpostman.com/view/24736333/2s93sc5YQJ');
                                        await launchUrl(url);
                                      },
                                      child: Text("Abrir"))
                                ],
                              )
                            ]),
                          ),
                        ),
                      ));
            },
          ),
          Divider(),
          ListTile(
            hoverColor: Color.fromARGB(227, 248, 248, 202),
            leading: Icon(Icons.logout),
            title: Text("Cerrar Sesión"),
            onTap: () async {
              await _menuLateralVM.cerrarSesion();
              Navigator.pushReplacementNamed(context, "/login");
            },
          ),
        ]),
      ),
    );
  }
}
