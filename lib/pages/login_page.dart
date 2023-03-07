import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gestor_de_inventario/VM/loginVM.dart';
import 'package:gestor_de_inventario/pages/main_page.dart';

class Login_Page extends StatefulWidget {
  const Login_Page({super.key});

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  LoginVM _loginVM = LoginVM();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;

  realizarLogin() async {
    _formKey.currentState?.save();
    bool logeado = await _loginVM.login(_email, _password);

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
                            _email = newValue!;
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
                            _password = newValue!;
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
                                          _DialogRegistrarme()),
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

class _DialogRegistrarme extends StatefulWidget {
  const _DialogRegistrarme({super.key});

  @override
  State<_DialogRegistrarme> createState() => __DialogRegistrarmeState();
}

class __DialogRegistrarmeState extends State<_DialogRegistrarme> {
  bool _aceptadas = false;

  _aceptarCondiciones() {
    if (_aceptadas == false) {
      setState(() {
        _aceptadas = true;
      });
    } else {
      setState(() {
        _aceptadas = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registrarme"),
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: 600,
          ),
          padding: EdgeInsets.all(45),
          child: Form(
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Text(
                    "Registrate",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Nombre Completo",
                      hintText: 'Nombre Completo',
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Correo",
                      hintText: 'Correo',
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Confirmar Correo",
                      hintText: 'Confirmar Correo',
                    ),
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
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Confirmar Contraseña",
                      hintText: 'Confirmar Contraseña',
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Checkbox(
                          value: _aceptadas,
                          onChanged: (value) {
                            _aceptarCondiciones();
                          }),
                      Text("Acepto las condiciones"),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        _aceptadas == false ? Colors.grey : Colors.cyan,
                      ),
                    ),
                    onPressed: _aceptadas == false
                        ? null
                        : () {
                            Navigator.pop(context);
                          },
                    child: const Text('Registrarme',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
