
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mad/data/db_manager.dart';
import 'package:mad/firebase_options.dart';
import 'package:mad/screens/startup_screen.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBManager.instance.database;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MAD-E1',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: StartupScreen(),
    );
  }
}
