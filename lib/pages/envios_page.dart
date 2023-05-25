import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gestor_de_inventario/Models/envio.dart';
import 'package:gestor_de_inventario/VM/envios_pageVM.dart';
import 'package:gestor_de_inventario/Widgets/envioWidget.dart';
import 'package:gestor_de_inventario/pages/main_page.dart';
import 'package:responsive_grid/responsive_grid.dart';

class Envios_Page extends StatefulWidget {
  const Envios_Page({super.key});

  @override
  State<Envios_Page> createState() => _Envios_PageState();
}

class _Envios_PageState extends State<Envios_Page> {
  Envios_PageVM _envios_pageVM = Envios_PageVM();
  bool _isLoading = true;

  _Envios_PageState() {
    _envios_pageVM.getAllEnvios().then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
              title: Text(
                'Envios',
                style: TextStyle(color: Color.fromARGB(255, 248, 248, 202)),
              ),
              backgroundColor: Color.fromARGB(255, 164, 22, 34),
              leading: IconButton(
                color: Color.fromARGB(255, 248, 248, 202),
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Main_Page()));
                },
              )),
          body: _isLoading == true
              ? Container(
                  color: Colors.grey[200],
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : _envios_pageVM.envios!.isEmpty == true
                  ? Container(
                      color: Colors.grey[200],
                      child: Center(
                        child: Text("No hay envios",
                            style: TextStyle(fontSize: 20)),
                      ),
                    )
                  : Container(
                      color: Colors.grey[200],
                      padding: EdgeInsets.only(left: 15, right: 15, top: 5),
                      child: ListView(children: [
                        ResponsiveGridRow(
                          children: _envios_pageVM.envios!.map((e) {
                            return ResponsiveGridCol(
                              xs: 12,
                              sm: 6,
                              md: 6,
                              xl: 3,
                              child: Container(
                                alignment: Alignment(0, 0),
                                child: EnvioWidget(e),
                              ),
                            );
                          }).toList(),
                        ),
                      ]),
                    )),
    );
  }
}
