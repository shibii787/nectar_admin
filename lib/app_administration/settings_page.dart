import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nectar_admin/core/common/colors.dart';

class settingsPage extends StatefulWidget {
  const settingsPage({super.key});

  @override
  State<settingsPage> createState() => _settingsPageState();
}

class _settingsPageState extends State<settingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theColors.primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Admin Section",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: theColors.secondary
          ),),
      ),
    );;
  }
}
