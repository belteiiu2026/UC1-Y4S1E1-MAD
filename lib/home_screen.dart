import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool isLiked = false;

  void _onLikeClick(){
    setState(() {
      isLiked = !isLiked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Center(
      //   child: isLiked == true ? IconButton(onPressed: _onLikeClick, icon: Icon(Icons.favorite),color: Colors.red,) :
      //   IconButton(onPressed: _onLikeClick, icon: Icon(Icons.favorite)),
      // ),

      body: Center(
        child: IconButton(onPressed: _onLikeClick, icon: Icon(Icons.favorite),color: isLiked ? Colors.red : Colors.black)
      ),
    );
  }
}
