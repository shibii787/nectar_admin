import 'package:flutter/material.dart';
import 'package:nectar_admin/home.dart';
import 'package:nectar_admin/core/common/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
import 'login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  bool loggedIn = false;
  getLoggedIn() async {
    SharedPreferences login =  await SharedPreferences.getInstance();
    loggedIn = login.getBool("loggedIn") ?? false;

    await Future.delayed(const Duration(
        seconds: 3
    )).then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => loggedIn==true? const Home() : const LoginPage(),)));

  }

  @override
  void initState() {
    getLoggedIn();
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
