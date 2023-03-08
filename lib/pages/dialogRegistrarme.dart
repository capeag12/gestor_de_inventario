import 'package:flutter/material.dart';
import 'package:gestor_de_inventario/VM/registrarmeVM.dart';
import 'package:gestor_de_inventario/pages/main_page.dart';

class DialogRegistrarme extends StatefulWidget {
  const DialogRegistrarme({super.key});

  @override
  State<DialogRegistrarme> createState() => DialogRegistrarmeState();
}

class DialogRegistrarmeState extends State<DialogRegistrarme> {
  RegistrarmeVM _registrarmeVM = RegistrarmeVM();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  _aceptarCondiciones() {
    if (_registrarmeVM.aceptadas == false) {
      setState(() {
        _registrarmeVM.aceptadas = true;
      });
    } else {
      setState(() {
        _registrarmeVM.aceptadas = false;
      });
    }
  }

  registrarme() async {
    this._formKey.currentState?.save();
    this._formKey.currentState?.validate();
    bool registrado = await _registrarmeVM.registrarme();
    if (registrado) {
      Navigator.pop(context);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Main_Page()));
    } else {
      _dialogError();
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
            key: _formKey,
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
                    onSaved: (value) {
                      _registrarmeVM.nombre = value;
                    },
                    onChanged: (value) {
                      _registrarmeVM.nombre = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "El campo no puede estar vacio";
                      } else {
                        return null;
                      }
                    },
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
                    onSaved: (value) {
                      _registrarmeVM.correo = value;
                    },
                    onChanged: (value) {
                      _registrarmeVM.correo = value;
                    },
                    validator: (value) {
                      bool valid = _registrarmeVM.validMail(value);
                      if (valid == false) {
                        return "Correo no valido";
                      } else {
                        return null;
                      }
                    },
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
                    validator: (value) {
                      if (value != _registrarmeVM.correo) {
                        return "Los correos no coinciden";
                      } else {
                        return null;
                      }
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
                    onSaved: (value) {
                      _registrarmeVM.contrasena = value;
                    },
                    onChanged: (value) {
                      _registrarmeVM.contrasena = value;
                    },
                    validator: (value) {
                      bool valid = _registrarmeVM.validPassword(value);
                      if (valid == false) {
                        return "Contraseña no valida";
                      } else {
                        return null;
                      }
                    },
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
                          value: _registrarmeVM.aceptadas,
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
                        _registrarmeVM.aceptadas == false
                            ? Colors.grey
                            : Colors.cyan,
                      ),
                    ),
                    onPressed: _registrarmeVM.aceptadas == false
                        ? null
                        : () {
                            registrarme();
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
                    'No pudo registrarse, este mail ya se encuentra registrado'),
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
}
