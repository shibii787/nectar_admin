import 'package:flutter/material.dart';
import 'package:nectar_admin/appView.dart';
import 'package:nectar_admin/core/common/colors.dart';

import 'feature/screen/best_selling/add_bestSelling.dart';
import 'feature/screen/categories/add_category.dart';
import 'feature/screen/exclusive/add_view_exclusive.dart';
import 'feature/screen/groceries/add_groceries.dart';
import 'feature/screen/pulses/pulsess.dart';
import 'main.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.width > 1080 ? Scaffold(
      backgroundColor: theColors.beige,
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AddCategory(),));                  },
                  child: Container(
                    height: h*0.2,
                    width: w*0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(w*0.01),
                      color: theColors.third,
                      boxShadow: [
                        BoxShadow(
                          color: theColors.secondary,
                          blurRadius: w*0.01,
                          spreadRadius: w*0.0001,
                          offset: const Offset(0, 4)
                        )
                      ]
                    ),
                    child: const Center(
                      child: Text("Categories",style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: theColors.primaryColor
                      ),),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AddViewExclusivePage(),));
                  },
                  child: Container(
                    height: h*0.2,
                    width: w*0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(w*0.01),
                        color: theColors.third,
                        boxShadow: [
                          BoxShadow(
                              color: theColors.secondary,
                              blurRadius: w*0.01,
                              spreadRadius: w*0.0001,
                              offset: const Offset(0, 4)
                          )
                        ]
                    ),
                    child: const Center(
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const BestSelling(),));
                  },
                  child: Container(
                    height: h*0.2,
                    width: w*0.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(w*0.01),
                        color: theColors.third,
                        boxShadow: [
                          BoxShadow(
                              color: theColors.secondary,
                              blurRadius: w*0.01,
                              spreadRadius: w*0.0001,
                              offset: const Offset(0, 4)
                          )
                        ]
                    ),
                    child: const Center(
                      child: Text("Best Selling Items",style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: theColors.primaryColor
                      ),),
                    ),
                  ),
                ),
                // InkWell(
                //   onTap: () {
                //     Navigator.push(context, MaterialPageRoute(builder: (context) => const Appview(),));
                //   },
                //   child: Container(
                //     height: h*0.2,
                //     width: w*0.3,
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(w*0.01),
                //         color: theColors.third,
                //         boxShadow: [
                //           BoxShadow(
                //               color: theColors.secondary,
                //               blurRadius: w*0.01,
                //               spreadRadius: w*0.0001,
                //               offset: const Offset(0, 4)
                //           )
                //         ]
                //     ),
                //     child: const Center(
                //       child: Text("Items view",style: TextStyle(
                //           fontWeight: FontWeight.w500,
                //           color: theColors.primaryColor
                //       ),),
                //     ),
                //   ),
                // ),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const Pulses(),));
                  },
                  child: Container(
                    height: h*0.2,
                    width: w*0.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(w*0.01),
                        color: theColors.third,
                        boxShadow: [
                          BoxShadow(
                              color: theColors.secondary,
                              blurRadius: w*0.01,
                              spreadRadius: w*0.0001,
                              offset: const Offset(0, 4)
                          )
                        ]
                    ),
                    child: const Center(
                      child: Text("Pulses",style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: theColors.primaryColor
                      ),),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AddGroceries(),));
                  },
                  child: Container(
                    height: h*0.2,
                    width: w*0.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(w*0.01),
                        color: theColors.third,
                        boxShadow: [
                          BoxShadow(
                              color: theColors.secondary,
                              blurRadius: w*0.01,
                              spreadRadius: w*0.0001,
                              offset: const Offset(0, 4)
                          )
                        ]
                    ),
                    child: const Center(
                      child: Text("Groceries",style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: theColors.primaryColor
                      ),),
                    ),
                  ),
                ),
              ],
            )
          ],

        ),
      ),
    ): Container(color: theColors.third);

  }
}
