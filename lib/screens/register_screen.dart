
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mad/data/shared_pref_manager.dart';
import 'package:mad/screens/login_screen.dart';
import 'package:mad/screens/main_screen.dart';
import 'package:mad/services/auth_service.dart';
import 'package:mad/widgets/app_logo.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final fullNameCtrl = TextEditingController();
  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  void _navigateToLogin() {
    final route = MaterialPageRoute(builder: (BuildContext context) => LoginScreen());
    Navigator.pushReplacement(context, route);
  }

  Future<void> _onRegisterHandler() async {
    String fullName = fullNameCtrl.text.trim();
    String username = usernameCtrl.text.trim();
    String password = passwordCtrl.text.trim();
    print("fullName : $fullName , Username : $username, Password : $password");

    UserCredential userCredential = await AuthService.instance.registerWithEmailAndPassword(username, password);
    if(userCredential.user != null){
      userCredential.user!.updateDisplayName(fullName);
      final snackBar = SnackBar(content: Text("Register success."));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }else{
      final snackBar = SnackBar(content: Text("Register failure."));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {

    final fullName = Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: TextFormField(
        controller: fullNameCtrl,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
          hintText: 'Full Name',
          prefixIcon: Icon(Icons.account_circle)
        ),
      ),
    );


    final username = Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: TextFormField(
        controller: usernameCtrl,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
          hintText: 'Email',
          prefixIcon: Icon(Icons.mail),
          suffixIcon: Icon(Icons.check_circle),
        ),
      ),
    );

    final password = Padding(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: TextFormField(
        controller: passwordCtrl,
        obscureText: false,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
          hintText: 'Password',
          prefixIcon: Icon(Icons.lock),
          suffixIcon: Icon(Icons.visibility),
        ),
      ),
    );

    final registerButton = Padding(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
      child: SizedBox(
        height: 40,
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF0997A4)),
          onPressed: _onRegisterHandler,
          child: Text("ចូលប្រើប្រាស់", style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    final forgetPasswordButton = Padding(
      padding: EdgeInsets.only(right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(onPressed: () {}, child: Text("ភ្លេចលេខសង្ងាត់")),
        ],
      ),
    );

    final skipButton = Padding(
      padding: EdgeInsets.only(top: 16, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              Get.offAll(MainScreen());
            },
            child: Text("រំលង"),
          ),
        ],
      ),
    );


    final noAccountButton = Padding(
      padding: EdgeInsets.only(top: 16, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("មានគណនីរួចហើយ?"),
          TextButton(onPressed: () {
            _navigateToLogin();
          }, child: Text("ចូលប្រើប្រាស់")),
        ],
      ),
    );

    final _orSocialWidget = Padding(
      padding: EdgeInsets.only(right: 16, left: 16),
      child: Row(
        children: [
          Expanded(child: Divider()),
          Text("ឬក៏"),
          Expanded(child: Divider()),
        ],
      ),
    );

    final _facebookAndGoogle = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.facebook, color: Colors.blue,),
        Icon(Icons.g_mobiledata_outlined, color: Colors.red, size: 40,)
      ],
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            logo,
            SizedBox(height: 30),
            fullName,
            SizedBox(height: 10),
            username,
            SizedBox(height: 10),
            password,
            forgetPasswordButton,
            SizedBox(height: 10),
            registerButton,
            skipButton,
            noAccountButton,
            _orSocialWidget,
            _facebookAndGoogle
          ],
        ),
      ),
    );
  }
}