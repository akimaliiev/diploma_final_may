import 'package:diploma_16_10/google_sheets_api.dart';
import 'package:diploma_16_10/pages/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';



void main() async{
   WidgetsFlutterBinding.ensureInitialized();
   GoogleSheetsApi().init();
   await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}



class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthPage(),
      );
  }
  
}
