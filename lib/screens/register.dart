import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController =
      TextEditingController(text: "testuser@boiyelove.website");
  final TextEditingController _passwordController =
      TextEditingController(text: "Somepass123!");

  _registerUser() async {
    log("enter register user");
    if (_formKey.currentState!.validate()) {
      log("form state is valid");
      try {
        log("Enter try register user");
        FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text)
            .then((value) {
          Navigator.of(context).pushReplacementNamed("/profile");
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          log('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          log('The account already exists for that email.');
        }
      } catch (e) {
        log(e.toString());
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
            const Text("Create Account"),
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
            ElevatedButton(
                onPressed: _registerUser, child: const Text("Create Account")),
            const SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () async {
                  Navigator.of(context).pushReplacementNamed("/login");
                },
                child: const Text("I already have an account"))
          ]),
        )),
      ),
    );
  }
}
