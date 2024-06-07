import 'package:flutter/material.dart';
import 'package:nectar_admin/app_administration/best_selling/add_bestSelling.dart';
import 'package:nectar_admin/app_administration/categories/add_category.dart';
import 'package:nectar_admin/app_administration/categories/appView.dart';
import 'package:nectar_admin/app_administration/exclusive/add_view_exclusive.dart';
import 'package:nectar_admin/app_administration/pulses/pulsess.dart';
import 'package:nectar_admin/app_administration/users/app_users.dart';
import 'package:nectar_admin/core/common/colors.dart';


import '../main.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}
class _homePageState extends State<homePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theColors.primaryColor,
      appBar: AppBar(
        backgroundColor: theColors.third,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Admin Section",style: TextStyle(
          fontWeight: FontWeight.w600,
          color: theColors.primaryColor,
        ),),
      ),
      body: Padding(
        padding: EdgeInsets.all(w*0.04),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => addCategory(),));                  },
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
                      child: Text("Categories",style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: theColors.primaryColor
                      ),),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => addViewExclusivePage(),));
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
                      child: Text("Exclusive Items",style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: theColors.primaryColor
                      ),),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => BestSelling(),));
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
                      child: Text("Best Selling Items",style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: theColors.primaryColor
                      ),),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Appview(),));

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
                      child: Text("Items view",style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: theColors.primaryColor
                      ),),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Pulses(),));
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
                      child: Text("Pulses",style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: theColors.primaryColor
                      ),),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

  }
}
