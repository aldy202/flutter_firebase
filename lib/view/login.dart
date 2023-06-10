import 'package:flutter/material.dart';
import 'package:materi_firebase/controller/auth_controller.dart';
import 'package:materi_firebase/model/user_model.dart';
import 'package:materi_firebase/view/contact.dart';
import 'package:materi_firebase/view/register.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  final authController = AuthController();

  String? email;

  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(hintText: "Email"),
                onChanged: (value) {
                  email = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: "Password"),
                onChanged: (value) {
                  password = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Register()),
                      );
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: const Text('Login'),
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    UserMdl? loggedInUser = await authController
                        .signInWithEmailAndPassword(email!, password!);

                    if (loggedInUser != null) {
                      // Login successful
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Login Successful'),
                            content: const Text(
                                'You have been successfully logged in.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Contact()),
                                  );
                                  print(loggedInUser.name);
                                  // Navigate to the next screen or perform any desired action
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      // Login failed
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Login Failed'),
                            content: const Text('Invalid email or password.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()),
                                  );
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
