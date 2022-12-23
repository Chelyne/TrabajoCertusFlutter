import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registro_firebase/services/auth_services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Bienvenido a la aplicacion de la tarea'),
          Center(
            child: ElevatedButton(
              child: const Text('LogOut'),
              onPressed: () async {
                await authService.signOut();
              },
            ),
          )
        ],
      ),
    );
  }
}
