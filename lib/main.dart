// ignore_for_file: prefer_const_constructors

import 'package:firebase1/screens/chat_screen.dart';
import 'package:firebase1/screens/login_screen.dart';
import 'package:firebase1/screens/registration_screen.dart';
import 'package:firebase1/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); 
  await Firebase.initializeApp(); 
  runApp(
    FlashChat(),
  );
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
            // body: TextStyle(color: Colors.black54),
            ),
      ),
      initialRoute: 'welcomeScreen',
      routes: {
        'welcomeScreen': (context) => WelcomeScreen(),
        'ChatScreen': (context) => ChatScreen(),
        'LoginScreen': (context) => LoginScreen(),
        'RegistrationScreen': (context) => RegistrationScreen(),
      },
    );
  }
}
