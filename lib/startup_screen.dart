import 'package:flutter/material.dart';
import 'package:mad/login_screen.dart';
import 'package:mad/widgets/app_logo.dart';

class StartupScreen extends StatelessWidget {
  const StartupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final slogan = Text("The Future of Global Leaders");

    final getStartButton = Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: SizedBox(
        height: 40,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF0997A4)),
          onPressed: () {
            final route = MaterialPageRoute(
              builder: (BuildContext context) => LoginScreen(),
            );
            Navigator.pushReplacement(context, route);
          },
          child: Text("ចាប់ផ្តើម", style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [logo,SizedBox(height: 30,), slogan],
                ),
              ),
              getStartButton,
            ],
          ),
        ),
      ),
    );
  }
}
