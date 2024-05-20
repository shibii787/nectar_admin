import 'package:flutter/material.dart';
import 'package:nectar_admin/app_administration/categories/add_category.dart';
import 'package:nectar_admin/app_administration/users/app_users.dart';
import 'package:nectar_admin/core/common/colors.dart';
import 'package:sidebarx/sidebarx.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {

  bool isSmallScreen = false;
  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // Determine if the screen is small or large
    isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      key: _key,
      backgroundColor: theColors.primaryColor,
      appBar: isSmallScreen ? AppBar(
        leading: IconButton(
            onPressed: () {
              _key.currentState?.openDrawer();
            },
            icon: Icon(Icons.menu)),
        backgroundColor: theColors.third,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Admin Section",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: theColors.primaryColor,
          ),
        ),
      ) : null,
      drawer: isSmallScreen ? Sidebar(controller: _controller) : null,
      body: Row(
        children: [
          if (!isSmallScreen) Sidebar(controller: _controller),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildNavigationCard(
                        context,
                        title: "Users",
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => appUsers()),
                        ),
                      ),
                      _buildNavigationCard(
                        context,
                        title: "Categories",
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => addCategory()),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationCard(BuildContext context, {required String title, required VoidCallback onTap}) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: size.height * 0.2,
        width: size.width * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size.width * 0.04),
          color: theColors.secondary,
          boxShadow: [
            BoxShadow(
              color: theColors.secondary,
              blurRadius: size.width * 0.01,
              spreadRadius: size.width * 0.0001,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: theColors.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}

class Sidebar extends StatelessWidget {
  const Sidebar({super.key, required SidebarXController controller}) : _controller = controller;
  final SidebarXController _controller;

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: _controller,
      theme: SidebarXTheme(
        decoration: BoxDecoration(
          color: Colors.cyan,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(MediaQuery.of(context).size.width * 0.03),
            bottomRight: Radius.circular(MediaQuery.of(context).size.width * 0.03),
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      items: [
        SidebarXItem(icon: Icons.account_box, label: "Users"),
        SidebarXItem(icon: Icons.search, label: "Categories"),
        SidebarXItem(icon: Icons.upload, label: "Banner"),
      ],
    );
  }
}
