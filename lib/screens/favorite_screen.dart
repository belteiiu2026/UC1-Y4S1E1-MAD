
import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite"),
        elevation: 2.0,
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        child: Icon(Icons.favorite),
      ),
    );
  }
}
