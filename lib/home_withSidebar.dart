import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
// import 'package:nectar_admin/app_administration/bannerPage.dart';
import 'package:nectar_admin/app_administration/users/app_users.dart';
import 'package:nectar_admin/app_administration/home_page.dart';
import 'package:nectar_admin/app_administration/users/admin_user_page.dart';
import 'package:nectar_admin/app_administration/settings_page.dart';
import 'package:nectar_admin/app_intro/splash.dart';
import 'package:nectar_admin/core/common/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Banner/banner.dart';
import 'main.dart';

class homewithSidebar extends StatefulWidget {
  const homewithSidebar({super.key});

  @override
  State<homewithSidebar> createState() => _homewithSidebarState();
}

class _homewithSidebarState extends State<homewithSidebar> {

  final List<Widget> _screens =[
    appUsers(),
    homePage(),
    adminUsers(),
    banner(),
    settingsPage()
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: MediaQuery.of(context).size.width < 640 ? BottomNavigationBar(
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.indigoAccent,
        onTap: (int index){
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'Users'),
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.supervisor_account_rounded), label: 'Admin'),
          BottomNavigationBarItem(
              icon: Icon(Icons.file_copy), label: 'Banner'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings) , label:  'Settings'),
        ],
      ): null,
      body: Row(
        children: [
          if (MediaQuery.of(context).size.width >= 640)
          NavigationRail(
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
              selectedIndex: _selectedIndex,
              destinations: [
                NavigationRailDestination(
                    icon: Icon(Icons.person), label: Text("Users")),
                NavigationRailDestination(
                    icon: Icon(Icons.home), label: Text("Home")),
                NavigationRailDestination(
                    icon: Icon(Icons.supervisor_account_rounded), label: Text("Admin")),
                NavigationRailDestination(
                    icon: Icon(Icons.file_copy), label: Text('Banner')),
                NavigationRailDestination(
                    icon: Icon(Icons.settings), label: Text("Settings")),
              ],
            labelType: NavigationRailLabelType.all,
            selectedLabelTextStyle: TextStyle(
              color: theColors.secondary
            ),
            unselectedLabelTextStyle:TextStyle() ,
            trailing: InkWell(
                        onTap: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.remove("loggedIn");
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => splashPage(),));
                          },
                child: Icon(Icons.logout))
            ),
          Expanded(
              child: _screens[_selectedIndex])
        ],
      ),
    );
  }
}
