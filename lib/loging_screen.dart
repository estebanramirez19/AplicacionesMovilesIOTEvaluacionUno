import 'package:flutter/material.dart';
import 'package:prueba_1/login_fields.dart';

class LogingScreen extends StatelessWidget {
  const LogingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: SafeArea(
        //sirve para que las muescas de los dispositivos no oculten nuestro contenido
        child: Center(
          //center deja todo en el centro de manera vertical
          child: SingleChildScrollView(
            //cuando cualgo no cabe esto hace que se pueda scrolear
            padding: const EdgeInsets.all(
              16,
            ), //pading xd quizas se pueda ocupar otra cosa de frondEnd
            child: ConstrainedBox(
              //limita el tamaño del hijo que ya esta dentro de otro sin afectar al padre
              constraints: const BoxConstraints(
                maxWidth: 420,
              ), //aqui esta la limitante
              child: const LoginFields(),
            ),
          ),
        ),
      ),
    );
  }
}
