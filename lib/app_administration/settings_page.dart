import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nectar_admin/app_administration/settings/about.dart';
import 'package:nectar_admin/app_administration/settings/help.dart';
import 'package:nectar_admin/core/common/colors.dart';

import '../main.dart';

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
        backgroundColor: theColors.third,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Settings",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: theColors.primaryColor
          ),),
      ),
      body: Padding(
        padding:  EdgeInsets.all(w*0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: w * 0.05),
            Text("Genaral",
                style: TextStyle(
                    fontSize: w* 0.05, fontWeight: FontWeight.w900)),
            SizedBox(height: w * 0.05),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => help(),));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.help),
                  Text("Help"),
                  Row(
                    children: [
                      Icon(Icons.arrow_forward_ios)
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: w * 0.05),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.account_circle),
            Text("Account"),
            Row(
              children: [
                Icon(Icons.arrow_forward_ios)
              ],
            ),
          ],
        ),
            SizedBox(height: w * 0.05),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => about(),));
              },
              child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
              Icon(Icons.error_outline),
              Text("About"),
              Row(
                children: [
                  Icon(Icons.arrow_forward_ios)
                ],
              ),
        ]
    ),
            )
    ]
    ),
      )
    );
  }
}
