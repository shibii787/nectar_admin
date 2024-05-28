import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nectar_admin/core/common/colors.dart';

import 'app_administration/users/app_users.dart';
import 'main.dart';

class userpageOnly extends StatefulWidget {
  const userpageOnly({super.key});

  @override
  State<userpageOnly> createState() => _userpageOnlyState();
}

class _userpageOnlyState extends State<userpageOnly> {
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
      body: Padding(
        padding:  EdgeInsets.all(w*0.04),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => appUsers(),));
              },
              child: Container(
                height: h*0.2,
                width: w*0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(w*0.04),
                  color: theColors.third,
                    boxShadow: [
                      BoxShadow(
                          color: theColors.secondary,
                          blurRadius: w*0.01,
                          spreadRadius: w*0.0001,
                          offset: Offset(0, 4)
                      )
                    ]
                ),
                child: Center(
                  child: Text("Users",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: theColors.primaryColor
                  ),),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
