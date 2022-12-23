import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registro_firebase/services/auth_services.dart';

class registerScreen extends StatelessWidget {
  const registerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailControler = TextEditingController();
    final TextEditingController passwordControler = TextEditingController();
    final formKey = GlobalKey<FormState>();

    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
      ),
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://cdn-icons-png.flaticon.com/512/25/25231.png',
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: emailControler,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                    return "Ingrese un correo válido";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: passwordControler,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Ingrese un correo";
                  } else if (value.length <= 4) {
                    return "Ingrese al menos 4 dígitos";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    print('todo esta valido , consulta en firebase');
                    await authService
                        .createUserWithEmailAndPassword(
                            emailControler.text, passwordControler.text)
                        .then((value) => _showToast(context, 'Datos válidos',
                            Icons.check, Colors.green));
                  } else {
                    print('No valido');
                    _showToast(context, 'Ingrese Datos Correctamente',
                        Icons.warning, Colors.redAccent);
                  }
                },
                child: const Text('Registrarme')),
            const SizedBox(height: 25),
            Text('Ya tengo una cuenta. ',
                style: TextStyle(
                    color: Color.fromARGB(255, 15, 15, 16), fontSize: 15)),
            SizedBox(height: 8.0),
            InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text(
                  'Iniciar Sesion',
                  style: TextStyle(color: Colors.blueAccent, fontSize: 15),
                )),
          ],
        ),
      ),
    );
  }

  void _showToast(
      BuildContext context, String texto, IconData icono, Color color) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icono),
            Text(texto),
          ],
        ),
        action: SnackBarAction(
            textColor: Color.fromARGB(255, 4, 4, 4),
            label: 'Ok',
            onPressed: scaffold.hideCurrentSnackBar),
        backgroundColor: color,
      ),
    );
  }
}
