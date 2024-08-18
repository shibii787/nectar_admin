import 'package:flutter/material.dart';
import 'package:nectar_admin/home_page.dart';
import 'package:nectar_admin/settings_page.dart';
import 'package:nectar_admin/app_intro/splash.dart';
import 'package:nectar_admin/core/common/colors.dart';
import 'package:nectar_admin/users/admin_user_page.dart';
import 'package:nectar_admin/users/app_users.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'banner.dart';

class homewithSidebar extends StatefulWidget {
  const homewithSidebar({super.key});

  @override
  State<homewithSidebar> createState() => _homewithSidebarState();
}

class _homewithSidebarState extends State<homewithSidebar> {

  final List<Widget> _screens =[
    const AppUsers(),
    const HomePage(),
    const AdminUsers(),
    const banner(),
    const SettingsPage()
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
        items: const [
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
            backgroundColor: theColors.third.withOpacity(0.2),
            indicatorColor: Colors.white,
            indicatorShape: const RoundedRectangleBorder(),
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
              selectedIndex: _selectedIndex,
              destinations: const [
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
            selectedLabelTextStyle: const TextStyle(
              color: theColors.secondary
            ),
            unselectedLabelTextStyle:TextStyle() ,
            trailing: InkWell(
                        onTap: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.remove("loggedIn");
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SplashPage(),));
                          },
                child: const Icon(Icons.logout))
            ),
          Expanded(
              child: _screens[_selectedIndex])
        ],
      ),
    );
  }
}
