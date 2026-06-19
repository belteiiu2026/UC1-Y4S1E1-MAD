import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:mad/data/shared_pref_manager.dart';
import 'package:mad/screens/login_screen.dart';
import 'package:mad/screens/main_screen.dart';
import 'package:mad/services/auth_service.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {

  String fullName = "Guest";
  bool isCurrentUserLogin = false;
  String imageUrl = "assets/images/default-avatar-profile.avif";

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async{
    final u = await FacebookAuth.instance.getUserData(
        fields: "email,name,picture.width(200)",
    );
    print('Email: ${u['email']}');
    print('Picture:${u['picture']['data']['url']}');
    setState(() {
       imageUrl = "${u['picture']['data']['url']}";
    });
  }

  Future<void> _loadCurrentUser() async{
    User? user = await AuthService.instance.getCurrentUser();
    setState(() {
      fullName = (user?.displayName ?? user?.phoneNumber ?? user?.email)!;
      isCurrentUserLogin = true;
    });
  }

  Future<void> _onCheckCurrentLogin() async{
      User? user = await AuthService.instance.getCurrentUser();
      if(user == null){
         Get.to(LoginScreen());
      }
  }

  Future<void> _logoutHandler() async {
    User? user = await AuthService.instance.getCurrentUser();
    if(user != null){
       await AuthService.instance.logout();
       await FacebookAuth.instance.logOut();
       Get.offAll(MainScreen());
    }
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
                        image: isCurrentUserLogin ? NetworkImage(imageUrl) : AssetImage(imageUrl,) ,
                      ),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),

                  Divider(),
                  ListTile(
                    leading: Icon(Icons.account_circle),
                    title: Text("$fullName"),
                    subtitle: Text("Full Name"),
                    trailing: Icon(Icons.navigate_next),
                    onTap: _onCheckCurrentLogin,
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
            isCurrentUserLogin ? logoutButton : Container(),
          ],
        ),
      ),
    );
  }
}
