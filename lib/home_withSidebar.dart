import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:nectar_admin/app_administration/users/app_users.dart';

import 'main.dart';

class homewithSidebar extends StatefulWidget {
  const homewithSidebar({super.key});

  @override
  State<homewithSidebar> createState() => _homewithSidebarState();
}

class _homewithSidebarState extends State<homewithSidebar> {

  final List<Widget> _screens =[
    appUsers(),
  ];

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Admin App",
        style: TextStyle(
          color: Colors.black,
          fontSize: w*0.02,
          fontWeight: FontWeight.bold
        ),)),
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
              icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.feed), label: 'Feed'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings) , label:  'Settings')
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
                    icon: Icon(Icons.home), label: Text("Home")),
                NavigationRailDestination(
                    icon: Icon(Icons.feed), label: Text("Feed")),
                NavigationRailDestination(
                    icon: Icon(Icons.favorite), label: Text("Favorite")),
                NavigationRailDestination(
                    icon: Icon(Icons.settings), label: Text("Settings")),
              ],

            labelType: NavigationRailLabelType.all,
            selectedLabelTextStyle: TextStyle(
              color: Colors.teal
            ),

            unselectedLabelTextStyle:TextStyle() ,
            leading: Column(
              children: [
                SizedBox(
                  height: 8,
                ),
                CircleAvatar(
                  radius: 20,
                  child: Icon(Icons.person),
                )
              ],
            ),
          ),
          Expanded(child: _screens[_selectedIndex])
        ],
      ),
    );
  }
}
