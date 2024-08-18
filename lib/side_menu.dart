import 'package:flutter/material.dart';
import 'package:nectar_admin/core/common/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_intro/splash.dart';
import 'main.dart';

class SideMenu extends StatefulWidget {
  final TabController tabController;
  const SideMenu({super.key,
    required this.tabController
  });

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {


  ScrollController tabScroll = ScrollController();
  int selectTab = 0;

  getLoggedOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("loggedIn");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: w*0.2,
      color: theColors.dark,
      child: ListView(
        controller: tabScroll,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        children: [
          Container(
            height: h*0.2,
            width: w*0.2,
            decoration: BoxDecoration(
              color: theColors.dark,
              border: Border(
                bottom: BorderSide(
                  color: theColors.secondary.withOpacity(0.2)
                )
              )
            ),
            padding: EdgeInsets.all(w*0.01),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("NECTAR",style: TextStyle(
                  letterSpacing: 1,
                  color: theColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 30
                ),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("version: 1.0.0+1",
                    style: TextStyle(
                      color: theColors.primaryColor,
                      fontSize: 10
                    ),),
                    Text("Admin Panel",
                        style: TextStyle(
                        color: theColors.primaryColor,
                            fontSize: 10
                        ))
                  ],
                )
              ],
            ),
          ),
          // Users
          Container(
            width: w*0.2,
            padding: EdgeInsets.all(w*0.01),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: theColors.secondary
                )
              )
            ),
            child: InkWell(
              onTap: () {
                setState(() {
                  widget.tabController.animateTo(0);
                  selectTab = 0;
                });
              },
              child: Row(
                children: [
                  const Icon(Icons.person,
                    color: Colors.white,),
                  SizedBox(width: w*0.01),
                  const Text(
                    'Home',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          // Home
          Container(
            width: w*0.2,
            padding: EdgeInsets.all(w*0.01),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: theColors.secondary
                )
              )
            ),
            child: InkWell(
              onTap: () {
                setState(() {
                  widget.tabController.animateTo(1);
                  selectTab = 1;
                });
              },
              child: Row(
                children: [
                  const Icon(Icons.home,
                    color: Colors.white,),
                  SizedBox(width: w*0.01),
                  const Text(
                    'Users',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          // Admins
          Container(
            width: w*0.2,
            padding: EdgeInsets.all(w*0.01),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: theColors.secondary
                )
              )
            ),
            child: InkWell(
              onTap: () {
                setState(() {
                  widget.tabController.animateTo(2);
                  selectTab = 2;
                });
              },
              child: Row(
                children: [
                  const Icon(Icons.people,
                    color: Colors.white,),
                  SizedBox(width: w*0.01),
                  const Text(
                    'Admins',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          // Banner
          Container(
            width: w*0.2,
            padding: EdgeInsets.all(w*0.01),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: theColors.secondary
                )
              )
            ),
            child: InkWell(
              onTap: () {
                setState(() {
                  widget.tabController.animateTo(3);
                  selectTab = 3;
                });
              },
              child: Row(
                children: [
                  const Icon(Icons.file_open,
                    color: Colors.white,),
                  SizedBox(width: w*0.01),
                  const Text(
                    'Banner',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          // Settings
          Container(
            width: w*0.2,
            padding: EdgeInsets.all(w*0.01),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: theColors.secondary
                )
              )
            ),
            child: InkWell(
              onTap: () {
                setState(() {
                  widget.tabController.animateTo(4);
                  selectTab = 4;
                });
              },
              child: Row(
                children: [
                  const Icon(Icons.settings,
                    color: Colors.white,),
                  SizedBox(width: w*0.01),
                  const Text(
                    'Settings',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          // LogOut
          InkWell(
              onTap: () {
               getLoggedOut();
               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SplashPage(),));
              },
              child: Container(
                width: w*0.2,
                padding: EdgeInsets.all(w*0.01),
                child: Row(
                  children: [
                    const Icon(Icons.logout,
                      color: Colors.white,),
                    SizedBox(width: w*0.01),
                    const Text(
                      'Log Out',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
                ),
              )
        ],
      ),
    );
  }
}
