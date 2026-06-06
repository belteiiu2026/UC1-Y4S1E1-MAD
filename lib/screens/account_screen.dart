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
      appBar: AppBar(title: Text("Profile"), centerTitle: true),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'assets/images/default-avatar-profile.avif',
                        ),
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),

                  Divider(),
                  ListTile(
                    leading: Icon(Icons.account_circle),
                    title: Text("Chhai Chivon"),
                    subtitle: Text("Full Name"),
                    trailing: Icon(Icons.navigate_next),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.mail),
                    title: Text("mad@gmail.com"),
                    subtitle: Text("Email"),
                    trailing: Icon(Icons.navigate_next),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.shopping_cart),
                    title: Text("Order"),
                    subtitle: Text("Cart"),
                    trailing: Icon(Icons.navigate_next),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.light_mode),
                    title: Text("Light"),
                    subtitle: Text("Theme"),
                    trailing: Icon(Icons.navigate_next),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.language),
                    title: Text("English"),
                    subtitle: Text("Language"),
                    trailing: Icon(Icons.navigate_next),
                  ),
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
