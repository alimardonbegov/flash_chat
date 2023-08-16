import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/rounded_button.dart';
import 'chat.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = "registration_screen";

  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool isShowSpiner = false;
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) => email = value,
              decoration: InputDecoration(hintText: 'Enter your email'),
            ),
            const SizedBox(height: 8.0),
            TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) => password = value,
              decoration: InputDecoration(hintText: 'Enter your password'),
            ),
            const SizedBox(height: 24.0),
            RoundedButton(
                color: Colors.blueAccent,
                title: 'Register',
                onPressed: () async {
                  setState(() {
                    isShowSpiner = true;
                  });
                  try {
                    await _auth.createUserWithEmailAndPassword(email: email, password: password);
                    Navigator.pushNamed(context, ChatScreen.id);
                    setState(() {
                      isShowSpiner = false;
                    });
                  } catch (e) {
                    print(e);
                    setState(() {
                      isShowSpiner = false;
                    });
                  }
                })
          ],
        ),
      ),
    );
  }
}
