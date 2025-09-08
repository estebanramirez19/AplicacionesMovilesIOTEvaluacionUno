import 'package:flutter/material.dart';

class TaskScreen extends StatelessWidget {
  final String userEmail;
  const TaskScreen({super.key, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(left: 16.0),
          child: Text("Bienvenido \n$userEmail", textAlign: TextAlign.start),
        ),
        backgroundColor: Colors.red,
        foregroundColor: Colors.black,
      ),
      body: const Center(child: Text("aqui ira la lista de tareas")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
