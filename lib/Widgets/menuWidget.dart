import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gestor_de_inventario/Models/serviceLogin.dart';
import 'package:gestor_de_inventario/pages/login_page.dart';

class MenuWidget {
  static PopupMenuButton getPopUpMenuButton() {
    ServiceLogin serviceLogin = ServiceLogin.getInstance();

    return PopupMenuButton(
      icon: Icon(Icons.more_vert, color: Color.fromARGB(255, 248, 248, 202)),
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem(
          value: "Acerca de",
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
