import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gestor_de_inventario/Models/serviceLogin.dart';
import 'package:gestor_de_inventario/pages/login_page.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuWidget {
  static PopupMenuButton getPopUpMenuButton() {
    ServiceLogin serviceLogin = ServiceLogin.getInstance();

    return PopupMenuButton(
      icon: Icon(Icons.more_vert, color: Color.fromARGB(255, 248, 248, 202)),
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: "Acerca de",
          onTap: () async {
            await showDialog(
                context: context,
                builder: (BuildContext builder) => AlertDialog(
                      title: Text("Acerca de"),
                      content: Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: SingleChildScrollView(
                          child: Column(children: [
                            Row(
                              children: [
                                Text("Documentación de usuario:"),
                                TextButton(
                                    onPressed: () async {
                                      final Uri url = Uri.parse(
                                          'https://documenter.getpostman.com/view/24736333/2s93sc5YQJ');
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
