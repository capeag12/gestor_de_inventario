import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gestor_de_inventario/VM/loginVM.dart';
import 'package:gestor_de_inventario/VM/registrarmeVM.dart';
import 'package:gestor_de_inventario/pages/dialogRegistrarme.dart';
import 'package:gestor_de_inventario/pages/main_page.dart';

class Login_Page extends StatefulWidget {
  const Login_Page({super.key});

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  LoginVM _loginVM = LoginVM();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  realizarLogin() async {
    _formKey.currentState?.save();
    bool logeado = await _loginVM.login();

    if (logeado) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Main_Page()));
    } else {
      _dialogError();
    }
  }

  Future<void> _dialogError() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error', style: TextStyle(fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'No se pudo iniciar sesion, comprueba el usuario y la contraseña'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Form(
              key: _formKey,
              child: Container(
                  constraints: BoxConstraints(
                    maxWidth: 600,
                  ),
                  padding: EdgeInsets.all(45),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text(
                          "Bienvenido",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            log(value.toString());
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Usuario",
                            hintText: 'Usuario',
                          ),
                          onSaved: (newValue) {
                            _loginVM.email = newValue!;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: TextFormField(
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Contraseña",
                            hintText: 'Contraseña',
                          ),
                          onSaved: (newValue) {
                            _loginVM.password = newValue!;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Text("¿No tienes una cuenta?"),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      fullscreenDialog: true,
                                      builder: (context) =>
                                          DialogRegistrarme()),
                                );
                              },
                              child: Text("Registrate"),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.cyan),
                          ),
                          onPressed: () {
                            realizarLogin();
                          },
                          child: const Text(
                            'Iniciar Sesión',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ))),
        ),
      ),
    );
  }
}
