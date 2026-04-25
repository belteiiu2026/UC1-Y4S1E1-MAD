import 'package:flutter/material.dart';
import 'package:mad/widgets/app_logo.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final username = Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: TextFormField(
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
        obscureText: false,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
          hintText: 'Password',
          prefixIcon: Icon(Icons.lock),
          suffixIcon: Icon(Icons.visibility),
        ),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
      child: SizedBox(
        height: 40,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF0997A4)),
          onPressed: () {},
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

    final noAccountButton = Padding(
      padding: EdgeInsets.only(top: 16, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("មិនមានគណនីទេ?"),
          TextButton(onPressed: () {}, child: Text("ចុះឈ្មោះ")),
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
        Icon(Icons.g_mobiledata_outlined, color: Colors.red,size: 40,)
      ],
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            logo,
            SizedBox(height: 30),
            username,
            SizedBox(height: 10),
            password,
            forgetPasswordButton,
            SizedBox(height: 10),
            loginButton,
            noAccountButton,
            _orSocialWidget,
            _facebookAndGoogle
          ],
        ),
      ),
    );
  }
}
