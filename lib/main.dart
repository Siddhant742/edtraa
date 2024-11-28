import 'package:flutter/material.dart';
import 'package:interview_task/pages/sign_in.dart';
import 'package:interview_task/pages/sign_up.dart';
import 'package:interview_task/utilities/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Edtraa',
      theme: ThemeData.dark().copyWith(
        // primaryColor: Color(0xFF5B1AB7),
        scaffoldBackgroundColor: Colors.black,
        elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),)
      ),
      home: const SignInPage(),
    );
  }
}
