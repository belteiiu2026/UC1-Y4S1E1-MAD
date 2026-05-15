import 'package:flutter/material.dart';
import 'package:mad/data/shared_pref_manager.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {


  Future<void> _logoutHandler() async {
    await SharedPrefManager.instance.remove("fullName");
  }


  @override
  Widget build(BuildContext context) {
    final logoutButton = Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: SizedBox(
        height: 40,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF0997A4)),
          onPressed: _logoutHandler,
          child: Text("ចាកចេញ", style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(elevation: 3, title: Text("Account"), centerTitle: true),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  ListTile(title: Text("MAD"), subtitle: Text("Full Name")),
                  Divider(),
                ],
              ),
            ),
            logoutButton,
          ],
        ),
      ),
    );
  }
}
