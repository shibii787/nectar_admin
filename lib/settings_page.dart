import 'package:flutter/material.dart';
import 'package:nectar_admin/core/common/colors.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theColors.beige,
      appBar: AppBar(
        backgroundColor: theColors.third,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("SETTINGS",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: theColors.primaryColor
          ),),
      ),
    );
  }
}
