import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:mad/data/shared_pref_manager.dart';
import 'package:mad/screens/home_screen.dart';
import 'package:mad/screens/main_screen.dart';
import 'package:mad/screens/register_screen.dart';
import 'package:mad/services/auth_service.dart';
import 'package:mad/widgets/app_logo.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<LoginScreen> {
  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  bool _isEmailValid = false;
  bool _secureText = true;
  final _keyForm = GlobalKey<FormState>();

  void _onEmailChangeHandler(String email) {
    if (email.isNotEmpty && email.contains("@")) {
      setState(() {
        _isEmailValid = true;
      });
    } else {
      setState(() {
        _isEmailValid = false;
      });
    }
  }


  Future<void> _facebookLoginHandler() async {
    LoginResult result = await FacebookAuth.instance.login();
    if(result.status == LoginStatus.success){
      // Create Credential
      OAuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.tokenString);
      // SignIn With Credential
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      if(userCredential.user != null){
        final snackBar = SnackBar(content: Text("Login success."));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Get.offAll(MainScreen());
      }
    }else{
      final snackBar = SnackBar(content: Text("${result.message}"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> _onLoginHandler() async {
    String username = usernameCtrl.text.trim();
    String password = passwordCtrl.text.trim();
    print("Username : $username, Password : $password");
    if (_keyForm.currentState!.validate()) {
      UserCredential userCredential = await AuthService.instance.loginWithEmailAndPassword(username, password);
      if (userCredential.user != null) {
        final snackBar = SnackBar(content: Text("Login success."));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Get.offAll(MainScreen());
      } else {
        final snackBar = SnackBar(content: Text("Login failed."));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final username = Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: TextFormField(
        controller: usernameCtrl,
        onChanged: _onEmailChangeHandler,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
          hintText: 'Email',
          prefixIcon: Icon(Icons.mail),
          suffixIcon: Icon(Icons.check_circle),
        ),
        validator: (v) {
          if (v!.isEmpty) {
            return "Email could not be blank.";
          }
          return null;
        },
      ),
    );

    final password = Padding(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: TextFormField(
        controller: passwordCtrl,
        obscureText: _secureText,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
          hintText: 'Password',
          prefixIcon: Icon(Icons.lock),
          suffixIcon: _secureText
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _secureText = !_secureText;
                    });
                  },
                  icon: Icon(Icons.visibility),
                )
              : IconButton(
                  onPressed: () {
                    setState(() {
                      _secureText = !_secureText;
                    });
                  },
                  icon: Icon(Icons.visibility_off),
                ),
        ),
        validator: (v) {
          if (v!.isEmpty) {
            return "Password could not be blank.";
          }
          return null;
        },
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
      child: SizedBox(
        height: 40,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF0997A4)),
          onPressed: _onLoginHandler,
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
          Text("មិនមានគណនីទេ?"),
          TextButton(
            onPressed: () {
              final route = MaterialPageRoute(
                builder: (BuildContext context) => RegisterScreen(),
              );
              Navigator.pushReplacement(context, route);
            },
            child: Text("ចុះឈ្មោះ"),
          ),
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
        IconButton(onPressed: _facebookLoginHandler, icon: Icon(Icons.facebook, color: Colors.blue)),
        Icon(Icons.g_mobiledata_outlined, color: Colors.red, size: 40),
      ],
    );

    final loginForm = Form(
      key: _keyForm,
      child: Column(children: [username, SizedBox(height: 10), password]),
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            logo,
            SizedBox(height: 30),
            loginForm,
            forgetPasswordButton,
            SizedBox(height: 10),
            loginButton,
            skipButton,
            noAccountButton,
            _orSocialWidget,
            _facebookAndGoogle,
          ],
        ),
      ),
    );
  }
}
