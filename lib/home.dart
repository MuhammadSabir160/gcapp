import 'signin.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cnicController = TextEditingController();

  void register() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore db = FirebaseFirestore.instance;

    final String username = usernameController.text;
    final String email = emailController.text;
    final String cnic = cnicController.text;
    final String password = passwordController.text;
    try {
      final UserCredential user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      print("registered");

      await db
          .collection("users")
          .doc(user.user.uid)
          .set({"email": email, "username": username, "cnic": cnic});
      Navigator.of(context).pushNamed("/signup");
    } catch (e) {
      print("error");
      print(e.toString());
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
                controller: usernameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "username",
                    hintText: "fullname"),
              ),
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
                    hintText: "example@gmail.com"),
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
          Center(
              child:
                  ElevatedButton(onPressed: register, child: Text("Sign Up")))
        ],
      ),
    ));
  }
}
