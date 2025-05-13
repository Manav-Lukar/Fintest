import 'package:firebase_core/firebase_core.dart';  // Add Firebase core import
import 'package:fitness/view/login/login_view.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with your web configuration
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDFGmBnxKjXvUv_H_bPrnmDswoq_OJuMPI",  // Your API key
      appId: "1:937473028970:web:c37b929fc75ab081efeb13", // Your app ID
      messagingSenderId: "937473028970",                  // Your sender ID
      projectId: "fitnest-cc902",                          // Your project ID
      authDomain: "fitnest-cc902.firebaseapp.com",         // Your auth domain
      storageBucket: "fitnest-cc902.firebasestorage.app", // Your storage bucket
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitNest',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue, // Customize as needed
        fontFamily: "Poppins",
      ),
      home: const LoginView(),
    );
  }
}
