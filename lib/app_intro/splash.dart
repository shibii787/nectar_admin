import 'package:flutter/material.dart';
import 'package:nectar_admin/app_administration/home_page.dart';
import 'package:nectar_admin/core/common/colors.dart';
import 'package:nectar_admin/core/common/images.dart';

import '../main.dart';

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
    return  Scaffold(
      backgroundColor: theColors.third,
      body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("NECTAR",style: TextStyle(
                  color: theColors.primaryColor,
                  letterSpacing: w*0.01,
                  fontWeight: FontWeight.w600,
                  fontSize: 35,
                ),),
                Text("Admin Panel",
                style: TextStyle(
                  color: theColors.primaryColor,
                  fontSize: 20,
                  letterSpacing: w*0.001
                ),)
              ],
            ),
          )),
    );
  }
}
