import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gestor_de_inventario/Models/serviceLogin.dart';
import 'package:gestor_de_inventario/pages/login_page.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuWidget {
  static PopupMenuButton getPopUpMenuButton(BuildContext contextBuild) {
    ServiceLogin serviceLogin = ServiceLogin.getInstance();

    return PopupMenuButton(
      icon: Icon(Icons.more_vert, color: Color.fromARGB(255, 248, 248, 202)),
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: "Acerca de",
          onTap: () {
            print("Presionado");
            Future.delayed(
              Duration(seconds: 0),
              () async {
                await showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: Text("Acerca de"),
                          content: Container(
                            child: SingleChildScrollView(
                              child: Column(children: [
                                Row(
                                  children: [
                                    Text("Documentación de usuario:"),
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
            );
          },
          child: Text('Acerca de'),
        ),
        PopupMenuItem(
          value: "Cerrar sesion",
          child: Text('Cerrar sesion'),
          onTap: () {
            serviceLogin.logout().then((value) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Login_Page()));
            });
          },
        ),
      ],
    );
  }
}
