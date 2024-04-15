import 'package:flutter/material.dart';
import 'package:nectar_admin/app_administration/home_page.dart';

class splashPage extends StatefulWidget {
  const splashPage({super.key});

  @override
  State<splashPage> createState() => _splashPageState();
}

class _splashPageState extends State<splashPage> {

  @override
  void initState() {
    Future.delayed(const Duration(
      seconds: 3
    )).then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => const homePage(),)));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Center(
            child: Text("NECTAR",style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 30,
            ),),
          )),
    );
  }
}
