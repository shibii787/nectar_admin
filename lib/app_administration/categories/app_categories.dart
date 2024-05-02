import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nectar_admin/app_administration/categories/itemAddPage.dart';
import 'package:nectar_admin/core/common/colors.dart';
import 'package:nectar_admin/model/category_model.dart';

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
      appBar: AppBar(
        backgroundColor: theColors.third,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: theColors.primaryColor,
          ),
        ),
        title: Text("Categories",style: TextStyle(
          color: theColors.primaryColor,fontWeight: FontWeight.w600
        ),),
      ),
      body: Padding(
        padding: EdgeInsets.all(w*0.03),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection("categories").orderBy('time', descending: false).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text("No Items"),
                    );
                  }
                  var data = snapshot.data!.docs;
                  return data.length == 0
                      ? Text("No Items")
                      : ListView.builder(
                          itemCount: data.length,
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ItemAddPage(categoryName:data[index]["item"],categoryID: data[index]["id"],),));
                              },
                              child: Container(
                                height: h * 0.2,
                                width: w * 0.4,
                                margin: EdgeInsets.all(w*0.03),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(w * 0.04),
                                    color: theColors.third,
                                    boxShadow: [
                                      BoxShadow(
                                          color: theColors.secondary,
                                          blurRadius: w * 0.01,
                                          spreadRadius: w * 0.0001,
                                          offset: Offset(0, 4))
                                    ]),
                                child: Center(
                                  child: Text(
                                    data[index]["item"],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: theColors.primaryColor),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                },
              )
            ],
          ),
        ),
      ),
    );

    //   Scaffold(
    //   backgroundColor: theColors.primaryColor,
    //   appBar: AppBar(
    //     backgroundColor: theColors.third,
    //     automaticallyImplyLeading: false,
    //     leading: InkWell(
    //       onTap: () {
    //         Navigator.pop(context);
    //       },
    //         child: const Icon(Icons.arrow_back,color: theColors.primaryColor)),
    //     centerTitle: true,
    //     title: const Text("Categories",style: TextStyle(
    //       fontWeight: FontWeight.w600,
    //       color: theColors.primaryColor,
    //     ),),
    //   ),
    //     body: Padding(
    //       padding: EdgeInsets.all(w*0.04),
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //         children: [
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               InkWell(
    //                 onTap: () {
    //                   Navigator.push(context, MaterialPageRoute(builder: (context) => fruitsAndVegetables(),));
    //                 },
    //                 child: Container(
    //                   height: h*0.2,
    //                   width: w*0.4,
    //                   decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(w*0.04),
    //                       color: theColors.third,
    //                       boxShadow: [
    //                         BoxShadow(
    //                             color: theColors.secondary,
    //                             blurRadius: w*0.01,
    //                             spreadRadius: w*0.0001,
    //                             offset: Offset(0, 4)
    //                         )
    //                       ]
    //                   ),
    //                   child: Center(
    //                     child: Text("Fresh Fruits & Vegetables",style: TextStyle(
    //                         fontWeight: FontWeight.w500,
    //                         color: theColors.primaryColor
    //                     ),),
    //                   ),
    //                 ),
    //               ),
    //               InkWell(
    //                 onTap: () {
    //                   Navigator.push(context, MaterialPageRoute(builder: (context) => cookingoil(),));
    //                 },
    //                 child: Container(
    //                   height: h*0.2,
    //                   width: w*0.4,
    //                   decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(w*0.04),
    //                       color: theColors.third,
    //                       boxShadow: [
    //                         BoxShadow(
    //                             color: theColors.secondary,
    //                             blurRadius: w*0.01,
    //                             spreadRadius: w*0.0001,
    //                             offset: Offset(0, 4)
    //                         )
    //                       ]
    //                   ),
    //                   child: Center(
    //                     child: Text("Cooking Oil & Ghee",style: TextStyle(
    //                         fontWeight: FontWeight.w500,
    //                         color: theColors.primaryColor
    //                     ),),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               InkWell(
    //                 onTap: () {
    //                   Navigator.push(context, MaterialPageRoute(builder: (context) => meatandfish(),));
    //
    //                 },
    //                 child: Container(
    //                   height: h*0.2,
    //                   width: w*0.4,
    //                   decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(w*0.04),
    //                       color: theColors.third,
    //                       boxShadow: [
    //                         BoxShadow(
    //                             color: theColors.secondary,
    //                             blurRadius: w*0.01,
    //                             spreadRadius: w*0.0001,
    //                             offset: Offset(0, 4)
    //                         )
    //                       ]
    //                   ),
    //                   child: Center(
    //                     child: Text("Meat & Fish",style: TextStyle(
    //                         fontWeight: FontWeight.w500,
    //                         color: theColors.primaryColor
    //                     ),),
    //                   ),
    //                 ),
    //               ),
    //               InkWell(
    //                 onTap: () {
    //                   Navigator.push(context, MaterialPageRoute(builder: (context) => bakeryandsnacks(),));
    //
    //                 },
    //                 child: Container(
    //                   height: h*0.2,
    //                   width: w*0.4,
    //                   decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(w*0.04),
    //                       color: theColors.third,
    //                       boxShadow: [
    //                         BoxShadow(
    //                             color: theColors.secondary,
    //                             blurRadius: w*0.01,
    //                             spreadRadius: w*0.0001,
    //                             offset: Offset(0, 4)
    //                         )
    //                       ]
    //                   ),
    //                   child: Center(
    //                     child: Text("Bakery & Snacks",style: TextStyle(
    //                         fontWeight: FontWeight.w500,
    //                         color: theColors.primaryColor
    //                     ),),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               InkWell(
    //                 onTap: () {
    //
    //                 },
    //                 child: Container(
    //                   height: h*0.2,
    //                   width: w*0.4,
    //                   decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(w*0.04),
    //                       color: theColors.third,
    //                       boxShadow: [
    //                         BoxShadow(
    //                             color: theColors.secondary,
    //                             blurRadius: w*0.01,
    //                             spreadRadius: w*0.0001,
    //                             offset: Offset(0, 4)
    //                         )
    //                       ]
    //                   ),
    //                   child: Center(
    //                     child: Text("Dairy & Eggs",style: TextStyle(
    //                         fontWeight: FontWeight.w500,
    //                         color: theColors.primaryColor
    //                     ),),
    //                   ),
    //                 ),
    //               ),
    //               InkWell(
    //                 onTap: () {
    //                   Navigator.push(context, MaterialPageRoute(builder: (context) => bevarages(),));
    //
    //                 },
    //                 child: Container(
    //                   height: h*0.2,
    //                   width: w*0.4,
    //                   decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(w*0.04),
    //                       color: theColors.third,
    //                       boxShadow: [
    //                         BoxShadow(
    //                             color: theColors.secondary,
    //                             blurRadius: w*0.01,
    //                             spreadRadius: w*0.0001,
    //                             offset: Offset(0, 4)
    //                         )
    //                       ]
    //                   ),
    //                   child: Center(
    //                     child: Text("Beverages",style: TextStyle(
    //                         fontWeight: FontWeight.w500,
    //                         color: theColors.primaryColor
    //                     ),),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ],
    //       ),
    //     )
    // );
  }
}
