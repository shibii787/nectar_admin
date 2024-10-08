import 'package:flutter/material.dart';
import 'package:nectar_admin/banner.dart';
import 'package:nectar_admin/home_page.dart';
import 'package:nectar_admin/settings_page.dart';
import 'package:nectar_admin/side_menu.dart';

import 'feature/screen/users/screen/admin_user_page.dart';
import 'feature/screen/users/screen/app_users.dart';

late TabController tabController;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    tabController  = TabController(length: 5, vsync: this);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SideMenu(tabController: tabController),
          Expanded(
            child: TabBarView(
              controller: tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  HomePage(),
                  AppUsers(),
                  AdminUsers(),
                  banner(),
                  SettingsPage()
                ]
            ),
          )
        ],
      ),
    );
  }
}
