import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gestor_de_inventario/pages/login_page.dart';
import 'package:gestor_de_inventario/pages/main_page.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  if (Platform.isWindows) {
    WidgetsFlutterBinding.ensureInitialized();
    await windowManager.ensureInitialized();
    WindowManager.instance.setTitle("Gestor de almacenes");
    WindowManager.instance.setMinimumSize(const Size(621, 475));
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.red,
      ),
      home: const Main_Page(),
      routes: {
        '/login': (context) => const Login_Page(),
      },
    );
  }
}
