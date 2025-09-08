import 'package:flutter/material.dart';
import 'package:prueba_1/loging_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: "Login y Tareas", home: LogingScreen());
  }
}
