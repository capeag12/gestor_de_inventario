import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gestor_de_inventario/Models/serviceLogin.dart';
import 'package:gestor_de_inventario/Models/usuario.dart';
import 'package:gestor_de_inventario/VM/user_pageVM.dart';
import 'package:gestor_de_inventario/Widgets/almacenUserWidget.dart';
import 'package:gestor_de_inventario/pages/main_page.dart';
import 'package:image_picker/image_picker.dart';

class User_page extends StatefulWidget {
  const User_page({super.key});

  @override
  State<User_page> createState() => _User_pageState();
}

class _User_pageState extends State<User_page> {
  UserPageVM _userPageVM = UserPageVM();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _User_pageState() {
    _userPageVM.serviceLogin.getAvatar().then((value) {
      setState(() {
        _userPageVM.image = value;
      });
    });
  }

  changePasswd() async {
    String originalPasswd = '';
    String newPasswd = '';
    String repeatPasswd = '';
    await showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text('Cambiar contraseña',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              content: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: ListBody(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: TextFormField(
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Contraseña actual",
                            hintText: 'Contraseña actual',
                          ),
                          onSaved: (value) {
                            originalPasswd = value ?? "";
                          },
                          onChanged: (value) {
                            originalPasswd = value ?? "";
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
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Nueva contraseña",
                            hintText: 'Nueva contraseña',
                          ),
                          onSaved: (value) {
                            newPasswd = value ?? "";
                          },
                          onChanged: (value) {
                            newPasswd = value ?? "";
                          },
                          validator: (value) {
                            if (value!.contains('password')) {
                              return "No puede ser 'password'";
                            }

                            if (value.length < 6) {
                              return "La contraseña debe tener al menos 6 caracteres";
                            }

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
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Repite la contraseña",
                            hintText: 'Repite la contraseña',
                          ),
                          onSaved: (value) {
                            repeatPasswd = value ?? "";
                          },
                          onChanged: (value) {
                            repeatPasswd = value ?? "";
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "El campo no puede estar vacio";
                            } else if (newPasswd != repeatPasswd) {
                              return "Las contraseñas no coinciden";
                            } else {
                              return null;
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Añadir'),
                  onPressed: () async {
                    _formKey.currentState!.save();
                    bool valida = _formKey.currentState!.validate();
                    if (valida == true) {
                      String texto = await _userPageVM.changePassword(
                          originalPasswd, newPasswd);
                      Navigator.pop(context);
                      await showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: Text('Alerta'),
                                content: Container(
                                  child: Text(texto),
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        bool existe = await _userPageVM
                                            .serviceLogin
                                            .checkIfTokenExists();
                                        if (existe == true) {
                                          Navigator.pushReplacementNamed(
                                              context, "/login");
                                        }
                                      },
                                      child: Text('Ok'))
                                ],
                              ));
                    }
                  },
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Usuario",
          style: TextStyle(color: Color.fromARGB(255, 248, 248, 202)),
        ),
        backgroundColor: Color.fromARGB(255, 164, 22, 34),
        leading: IconButton(
          color: Color.fromARGB(255, 248, 248, 202),
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Main_Page()));
          },
        ),
        actions: [
          Tooltip(
            message: 'Log out from all sessions',
            child: IconButton(
                onPressed: () async {
                  bool cerrado = await _userPageVM.logoutAll();
                  await Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Main_Page()));
                  await showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: Text('Se ha cerrado la sesión'),
                            content: Container(
                              child: Text(cerrado == true
                                  ? 'Se ha cerrado sesión en todos los dispositivos'
                                  : 'Solo se pudo cerrar sesión localmente'),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Ok'))
                            ],
                          ));
                },
                color: Color.fromARGB(255, 248, 248, 202),
                icon: Icon(Icons.logout)),
          ),
          _userPageVM.changedImg == true
              ? Tooltip(
                  message: 'Change avatar image',
                  child: IconButton(
                      color: Color.fromARGB(255, 248, 248, 202),
                      onPressed: () {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                title: Text('Subiendo imagen'),
                                content: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircularProgressIndicator(
                                          color:
                                              Color.fromARGB(255, 164, 22, 34)),
                                    ],
                                  ),
                                )));

                        _userPageVM.uploadImage().then((value) {
                          if (value == true) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "La imagen se ha subido correctamente")));
                          } else {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "Ha ocurrido un error al subir la imagen")));
                          }

                          setState(() {});
                        });
                      },
                      icon: Icon(Icons.save)),
                )
              : Container(),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10),
        child: MediaQuery.of(context).size.width < 600
            ? Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15, bottom: 5),
                    child: Column(
                      children: [
                        Container(
                          child: InkWell(
                            onTap: () async {
                              await _userPageVM.getImage();
                              setState(() {});
                            },
                            child: _userPageVM.image == null
                                ? Image(
                                    fit: BoxFit.scaleDown,
                                    image:
                                        Image.asset('assets/images/default.png')
                                            .image,
                                    height:
                                        MediaQuery.of(context).size.width < 400
                                            ? 200
                                            : null,
                                  )
                                : Image.file(File(_userPageVM.image!.path),
                                    fit: BoxFit.scaleDown,
                                    height:
                                        MediaQuery.of(context).size.width < 400
                                            ? 200
                                            : null),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: TextFormField(
                            initialValue:
                                _userPageVM.serviceLogin.usuario!.nombre,
                            readOnly: true,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Nombre completo",
                              hintText: 'Usuario',
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 10),
                          child: TextFormField(
                            readOnly: true,
                            initialValue:
                                _userPageVM.serviceLogin.usuario!.email,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Correo electrónico",
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(right: 5),
                                child: TextFormField(
                                  obscureText: true,
                                  readOnly: true,
                                  initialValue:
                                      _userPageVM.serviceLogin.usuario!.email,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Contraseña",
                                  ),
                                ),
                              ),
                            ),
                            Tooltip(
                              message: 'Cambiar contraseña',
                              child: IconButton(
                                  onPressed: () async {
                                    await changePasswd();
                                  },
                                  icon: Icon(Icons.edit)),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Container(
                          padding:
                              EdgeInsets.only(left: 15, right: 15, bottom: 5),
                          child: Card(
                            color: Color.fromARGB(255, 164, 22, 34),
                            child: ListView(
                                shrinkWrap: true,
                                children: _userPageVM.serviceLogin.usuario!
                                        .listaAlmacenes.isEmpty
                                    ? [
                                        Center(
                                          child: Text('No hay almacenses'),
                                        ),
                                      ]
                                    : _userPageVM.serviceLogin.usuario!
                                        .getAlmacenesName()
                                        .map((e) => AlmacenUserWidget(
                                              e,
                                            ))
                                        .toList()),
                          ),
                        ))
                      ],
                    ),
                  )
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 15,
                        right: 5,
                      ),
                      child: ListView(
                        children: [
                          InkWell(
                            onTap: () async {
                              await _userPageVM.getImage();
                              setState(() {});
                            },
                            child: Container(
                              child: _userPageVM.image == null
                                  ? Image(
                                      fit: BoxFit.scaleDown,
                                      image: Image.asset(
                                              'assets/images/default.png')
                                          .image,
                                      height:
                                          MediaQuery.of(context).size.width <
                                                  400
                                              ? 200
                                              : null,
                                    )
                                  : Image.file(File(_userPageVM.image!.path),
                                      fit: BoxFit.scaleDown,
                                      height:
                                          MediaQuery.of(context).size.width <
                                                  400
                                              ? 200
                                              : null),
                              constraints: BoxConstraints(
                                  maxHeight:
                                      MediaQuery.of(context).size.height / 2),
                            ),
                          ),
                          Row(
                            children: [
                              Flexible(
                                  child: Container(
                                padding: EdgeInsets.only(bottom: 10, top: 10),
                                child: TextFormField(
                                  initialValue:
                                      _userPageVM.serviceLogin.usuario!.nombre,
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Nombre completo",
                                    hintText: 'Usuario',
                                  ),
                                ),
                              )),
                            ],
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: Container(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: TextFormField(
                                    readOnly: true,
                                    initialValue:
                                        _userPageVM.serviceLogin.usuario!.email,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Correo electrónico",
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(right: 5),
                                  child: TextFormField(
                                    obscureText: true,
                                    readOnly: true,
                                    initialValue: 'correoCarlos@gmail.com',
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Contraseña",
                                    ),
                                  ),
                                ),
                              ),
                              Tooltip(
                                message: 'Cambiar contraseña',
                                child: IconButton(
                                    onPressed: () async {
                                      await changePasswd();
                                    },
                                    icon: Icon(Icons.edit)),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          padding:
                              EdgeInsets.only(left: 5, right: 10, bottom: 5),
                          child: Card(
                            color: Color.fromARGB(255, 164, 22, 34),
                            child: ListView(
                                shrinkWrap: true,
                                children: _userPageVM.serviceLogin.usuario!
                                        .listaAlmacenes.isEmpty
                                    ? [
                                        Center(
                                          child: Text('No hay almacenses'),
                                        ),
                                      ]
                                    : _userPageVM.serviceLogin.usuario!
                                        .getAlmacenesName()
                                        .map((e) => AlmacenUserWidget(
                                              e,
                                            ))
                                        .toList()),
                          ),
                        ),
                      ),
                    ],
                  ))
                ],
              ),
      ),
    );
  }
}
