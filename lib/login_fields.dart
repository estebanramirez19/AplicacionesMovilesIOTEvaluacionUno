import 'package:flutter/material.dart';
import 'package:prueba_1/task_screen.dart';

//este se supone que es el archivo mas largo de todos
class LoginFields extends StatefulWidget {
  const LoginFields({super.key});

  @override
  State<LoginFields> createState() => _LoginFieldState();
}

class _LoginFieldState extends State<LoginFields> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController(); //controladores para validar
  final _passCtrl = TextEditingController();

  bool _obscure = true;
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    //metodo para limpiar la wea
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus(); // esto oculta el teclado
    final ok =
        //validamos que el resultado este ok para que pase a ser true
        _formKey.currentState?.validate() ?? false;
    // aqui al ser true(estar ok) el return hace que se envie lo que corresponde del codigo
    if (!ok) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      await Future.delayed(const Duration(microseconds: 600));

      if (!mounted) return;
      final email = _emailCtrl
          .text; //guardamos en una variable el email y lo convertimos en texto
      // Seguridad: evita usar context si el widget se removió.
      Navigator.of(context).pushReplacement(
        // Reemplaza la pantalla actual por la de Tareas.
        MaterialPageRoute(
          builder: (_) => TaskScreen(
            userEmail: email,
          ), //enviamos los datos listos para que lo reciba task screen
        ), // Define la ruta a TasksScreen.
      );
    } catch (e) {
      // Si algo falla (ej. credenciales/red) entra aquí.
      if (!mounted) return; // Evita setState si el widget ya no existe.
      setState(
        () => _error = 'Credenciales inválidas o error de red',
      ); // Guarda un mensaje de error global.
      ScaffoldMessenger.of(context).showSnackBar(
        // Muestra un SnackBar con feedback al usuario.
        const SnackBar(content: Text('No pudimos iniciar sesión')),
      );
    } finally {
      // Se ejecuta siempre (haya éxito o error).
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
      //autofill agrupa los widgets que sirven de complemento
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode
            .onUserInteraction, //auto validacion por parte del usuario
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.stretch, //espandelos elememtos horizontalmente
          mainAxisSize: MainAxisSize
              .min, //minimiza el espacio de las filas a solo el espacio que deben ocupar
          children: [
            Center(
              child: Image.network(
                "https://www.shutterstock.com/image-vector/inamiku-indonesia-august-26-2023-600nw-2352888015.jpg",
                height: 150, //altura. tambien puede agregarse el width
                fit: BoxFit
                    .contain, //el contain es para que la imagen no se desforme o recorte. esta puede cambiarse
              ),
            ),
            const SizedBox(height: 160),
            const Text(
              "Bienvenido miembro de Akatski",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
              textAlign: TextAlign.center,
            ),

            TextFormField(
              enabled: !_loading,
              controller: _emailCtrl, //traemos la variable del principio
              keyboardType: TextInputType.emailAddress, //tipo de teclado
              textCapitalization: TextCapitalization.none,
              autocorrect: false,
              enableSuggestions: true,
              autofillHints: const [AutofillHints.email],
              decoration: const InputDecoration(
                //desde aqui comienza a crearse el label
                labelText: "Email",
                hintText: "ejemplo@akatski.com",
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
              validator: (v) {
                //validador de que seingrese el formato correcto
                final value = v?.trim() ?? '';
                if (value.isEmpty) return "ingresa tu email";
                final emailOk = RegExp(
                  r'^\S+@\S+\.\S+$',
                ).hasMatch(value); //caracteres de la validacion
                return emailOk ? null : "Email inválido";
              },
              textInputAction: TextInputAction.next,
              //cuando apretes enter pasa alsiguiente label
              onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
            ),
            const SizedBox(height: 12),
            TextFormField(
              enabled: !_loading,
              controller: _passCtrl,
              obscureText: _obscure,
              enableSuggestions: false,
              autocorrect: false,
              autofillHints: const [AutofillHints.password],
              decoration: InputDecoration(
                labelText: "Contraseña",
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  onPressed: () => setState(() => _obscure = !_obscure),
                  icon: Icon(
                    _obscure ? Icons.visibility : Icons.visibility_off,
                  ),
                  tooltip: _obscure ? "Mostrar" : "Ocultar",
                ),
              ),
              validator: (v) {
                //opciones de validacion aqui creo que se puede conctar a una base de datos donde
                if (v == null || v.isEmpty) return "Ingrese la contraseña";
                if (v.length < 8) return "Minimo 8 caracteres";
                return null; //cuando es valida
              },
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: 8),
            if (_error != null)
              Text(
                _error!,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 16),

            ///---------Boton----------
            SizedBox(
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.black,
                ),
                onPressed: _loading ? null : _submit,
                child: _loading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                    : const Text("Ingresar"),
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: _loading ? null : () {},
              child: const Text("¿Olvidaste tu contraseña?"),
            ),
          ],
        ),
      ),
    );
  }
}
