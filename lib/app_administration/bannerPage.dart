import 'package:flutter/material.dart';
import 'package:nectar_admin/core/common/colors.dart';

class bannerPage extends StatefulWidget {
  const bannerPage({super.key});

  @override
  State<bannerPage> createState() => _bannerPageState();
}

class _bannerPageState extends State<bannerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theColors.primaryColor,
      appBar: AppBar(
        backgroundColor: theColors.third,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Banner",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: theColors.primaryColor
          ),),
      ),
    );
  }
}
