import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gestor_de_inventario/pages/main_page.dart';

class User_page extends StatefulWidget {
  const User_page({super.key});

  @override
  State<User_page> createState() => _User_pageState();
}

class _User_pageState extends State<User_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Usuario"),
          backgroundColor: Colors.cyan,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Main_Page()));
            },
          )),
      body: Container(
        child: MediaQuery.of(context).size.width < 600
            ? Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15, bottom: 5),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: TextFormField(
                            initialValue: 'Carlos Pérez Aguilera',
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
                            initialValue: 'correoCarlos@gmail.com',
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
                              children: [
                                Text('Almacen1'),
                                Text('Almacen2'),
                                Text('Almacen1'),
                                Text('Almacen2'),
                                Text('Almacen1'),
                                Text('Almacen2'),
                                Text('Almacen1'),
                                Text('Almacen2'),
                                Text('Almacen1'),
                                Text('Almacen2'),
                              ],
                            ),
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
                      child: Column(
                        children: [
                          Flexible(
                              child: Container(
                            padding: EdgeInsets.only(bottom: 10, top: 10),
                            child: TextFormField(
                              initialValue: 'Carlos Pérez Aguilera',
                              readOnly: true,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Nombre completo",
                                hintText: 'Usuario',
                              ),
                            ),
                          )),
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.only(bottom: 10),
                              child: TextFormField(
                                readOnly: true,
                                initialValue: 'correoCarlos@gmail.com',
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: "Correo electrónico",
                                ),
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
                              children: [
                                Text('Almacen1'),
                                Text('Almacen2'),
                                Text('Almacen1'),
                                Text('Almacen2'),
                                Text('Almacen1'),
                                Text('Almacen2'),
                                Text('Almacen1'),
                                Text('Almacen2'),
                                Text('Almacen1'),
                                Text('Almacen2'),
                                Text('Almacen1'),
                                Text('Almacen2'),
                                Text('Almacen1'),
                                Text('Almacen2'),
                                Text('Almacen1'),
                                Text('Almacen2'),
                                Text('Almacen1'),
                                Text('Almacen2'),
                                Text('Almacen1'),
                                Text('Almacen2'),
                              ],
                            ),
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
