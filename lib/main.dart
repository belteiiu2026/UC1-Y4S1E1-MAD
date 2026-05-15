import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mad/data/file_storage_manager.dart';
import 'package:mad/data/shared_pref_manager.dart';
import 'package:mad/screens/home_screen.dart';
import 'package:mad/screens/startup_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FileStorageManager.instance.initFileStorage();
  await FileStorageManager.instance.saveToFileStorage("bookId=1,price=10000,qty=1");
  List<String> items = await FileStorageManager.instance.readFromFileStorage();
  for(String i in items){
    print("Items $i");
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

   MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: StartupScreen(),
    );
  }
}
