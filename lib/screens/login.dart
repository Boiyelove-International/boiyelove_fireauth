import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController =
      TextEditingController(text: "testuser@boiyelove.website");
  final TextEditingController _passwordController =
      TextEditingController(text: "Somepass123!");

  _loginUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text)
            .then((value) => {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("/profile", (route) => false)
                });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          log('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          log('Wrong password provided for that user.');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text("Login"),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "Email Address")),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: _loginUser, child: const Text("Login")),
            const SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () async {
                  Navigator.of(context).pushReplacementNamed("/register");
                },
                child: const Text("Create an account"))
          ]),
        )),
      ),
    );
  }
}
