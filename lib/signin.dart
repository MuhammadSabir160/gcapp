import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home.dart';

// ignore: camel_case_types
class signUp extends StatefulWidget {
  _signUpState createState() => _signUpState();
}

// ignore: camel_case_types
class _signUpState extends State<signUp> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  void signin() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore db = FirebaseFirestore.instance;

    final String email = emailController.text;
    final String password = passwordController.text;
    try {
      final UserCredential user = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      final DocumentSnapshot snapshot =
          await db.collection("users").doc(user.user.uid).get();
      // ignore: unused_local_variable
      final data = snapshot.data();
      Navigator.of(context).pushNamed("/cv");
    } catch (e) {
      print("error");
      print(e.message);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: Center(
              child: Image.asset('images/shop.png'),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Gmail",
                    hintText: "Example@gmail.com"),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password",
                    hintText: "Enter Password",
                    suffixIcon: Icon(Icons.visibility)),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(right: 25),
              child: RichText(
                  text: TextSpan(
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                      ),
                      children: <TextSpan>[
                    TextSpan(text: "donot have an account"),
                    TextSpan(
                        text: "Create One",
                        style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, "/login");
                          }),
                  ])),
            ),
          ),
          Center(
              child: ElevatedButton(onPressed: signin, child: Text("Sign in")))
        ],
      ),
    ));
  }
}
