import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:nectar_admin/app_administration/users/app_users.dart';
import 'package:nectar_admin/app_administration/home_page.dart';
import 'package:nectar_admin/app_administration/banner_page.dart';
import 'package:nectar_admin/app_administration/settings_page.dart';

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
    bannerPage(),
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
              icon: Icon(Icons.person), label: 'Person'),
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.feed), label: 'Banner'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings) , label:  'Settings'),
          BottomNavigationBarItem(
            icon: Padding(
              padding:  EdgeInsets.only(bottom: w*0.03),
              child: Icon(Icons.logout),
            ), label: 'Logout')

        ],
      ): null,
      body: Row(
        children: [
          if (MediaQuery.of(context).size.width >=640)
          NavigationRail(
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
              selectedIndex: _selectedIndex,
              destinations: [
                NavigationRailDestination(
                    icon: Icon(Icons.person), label: Text("Person")),
                NavigationRailDestination(
                    icon: Icon(Icons.home), label: Text("Home")),
                NavigationRailDestination(
                    icon: Icon(Icons.feed), label: Text("Banner")),
                NavigationRailDestination(
                    icon: Icon(Icons.settings), label: Text("Settings")),
              ],
            labelType: NavigationRailLabelType.all,
            selectedLabelTextStyle: TextStyle(
              color: Colors.teal
            ),
            unselectedLabelTextStyle:TextStyle() ,
            trailing: Column(
              children: [
                SizedBox(height: w*0.23,),
                Icon(Icons.logout,
                size: w*0.030,)
              ],
            ),
          ),
          Expanded(
              child: _screens[_selectedIndex])
        ],
      ),
    );
  }
}
