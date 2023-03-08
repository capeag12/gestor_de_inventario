import 'package:flutter/material.dart';
import 'package:gestor_de_inventario/pages/login_page.dart';
import 'package:gestor_de_inventario/pages/main_page.dart';

void main() {
  runApp(ConstrainedBox(
      constraints: BoxConstraints(minWidth: 400), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.cyan,
      ),
      home: const Main_Page(),
      routes: {
        '/login': (context) => const Login_Page(),
      },
    );
  }
}
