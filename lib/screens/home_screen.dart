import 'package:flutter/material.dart';
import 'package:mad/data/shared_pref_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String fullName = "Guest";

  @override
  void initState() {
    super.initState();
    _loadFullName();
  }

  Future<void> _loadFullName() async {
    String? _fullName = await SharedPrefManager.instance.getPref("fullName");
    setState(() {
      fullName = _fullName;
    });
  }

  @override
  Widget build(BuildContext context) {

    final title = Text("Hello, $fullName", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.red),);
    final description = Text("What do you want to read today?", style: TextStyle(fontSize: 14, color: Colors.black45),);

    List<Widget> productList = List.generate(10, (i){
      return Card(
        child: Image.asset("assets/images/beltei_iu.png", width: 120,),
      );
    }).toList();
    

    return Scaffold(
      appBar: AppBar(
        elevation: 3,
      ),
      body: SafeArea(child: ListView(
        children: [
          title,
          description,
          SizedBox(height: 200,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: productList,
            ),
          ),)
        ],
      )),
    );
  }
}
