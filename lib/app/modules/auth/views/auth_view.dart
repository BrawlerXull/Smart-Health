import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Authentication"), centerTitle: true),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.signInWithEmail(
                  emailController.text,
                  passwordController.text,
                );
              },
              child: const Text("Sign In with Email"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                controller.registerWithEmail(
                  emailController.text,
                  passwordController.text,
                );
              },
              child: const Text("Register with Email"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: controller.signInWithGoogle,
              child: const Text("Continue with Google"),
            ),
          ],
        ),
      )

          // }

          ),
    );
  }
}
