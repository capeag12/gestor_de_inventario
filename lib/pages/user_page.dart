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

  XFile? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Usuario"),
        backgroundColor: Colors.cyan,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Main_Page()));
          },
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.logout)),
          _userPageVM.image != null
              ? IconButton(
                  onPressed: () {
                    _userPageVM.uploadImage();
                  },
                  icon: Icon(Icons.save))
              : Container(),
        ],
      ),
      body: Container(
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
                                  onPressed: () {}, icon: Icon(Icons.edit)),
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
                            color: Colors.cyan,
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
                          Image(
                            fit: BoxFit.cover,
                            image:
                                Image.asset('assets/images/default.png').image,
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
                                    onPressed: () {}, icon: Icon(Icons.edit)),
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
                            color: Colors.cyan,
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
