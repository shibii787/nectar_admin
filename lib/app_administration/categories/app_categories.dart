import 'package:flutter/material.dart';
import 'package:nectar_admin/colors.dart';

import '../../main.dart';

class categories extends StatefulWidget {
  const categories({super.key});

  @override
  State<categories> createState() => _categoriesState();
}

class _categoriesState extends State<categories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theColors.primaryColor,
      appBar: AppBar(
        backgroundColor: theColors.third,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Categories",style: TextStyle(
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
                        child: Text("Fresh Fruits & Vegetables",style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: theColors.primaryColor
                        ),),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {

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
                        child: Text("Cooking Oil & Ghee",style: TextStyle(
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
                        child: Text("Meat & Fish",style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: theColors.primaryColor
                        ),),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {

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
                        child: Text("Bakery & Snacks",style: TextStyle(
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
                        child: Text("Dairy & Eggs",style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: theColors.primaryColor
                        ),),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {

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
                        child: Text("Beverages",style: TextStyle(
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
        )
    );
  }
}
