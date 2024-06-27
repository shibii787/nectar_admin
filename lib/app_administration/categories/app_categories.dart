import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nectar_admin/app_administration/categories/itemAddPage.dart';
import 'package:nectar_admin/core/common/colors.dart';
import 'package:nectar_admin/feature/controller/addingController.dart';

import '../../main.dart';

class categories extends ConsumerStatefulWidget {
  const categories({super.key});

  @override
  ConsumerState<categories> createState() => _categoriesState();
}

class _categoriesState extends ConsumerState<categories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theColors.sixth,
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

              ref.watch(addCategoryStreamProvider).when(
                  data: (data) {
                    return ListView.builder(
                      itemCount: data.length,
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ItemAddPage(categoryName:data[index].name,categoryID: data[index].id,),));
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
                                data[index].name,
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
                  error: (error, stackTrace) {
                    return Text(error.toString());
                  },
                  loading: () {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
              )

              // StreamBuilder<QuerySnapshot>(
              //   stream:
              //       FirebaseFirestore.instance.collection("categories").orderBy('time', descending: false).snapshots(),
              //   builder: (context, snapshot) {
              //     if (!snapshot.hasData) {
              //       return Center(
              //         child: Text("No Items"),
              //       );
              //     }
              //     var data = snapshot.data!.docs;
              //     return data.length == 0
              //         ? Text("No Items")
              //         : ListView.builder(
              //             itemCount: data.length,
              //             physics: BouncingScrollPhysics(),
              //             shrinkWrap: true,
              //             scrollDirection: Axis.vertical,
              //             itemBuilder: (context, index) {
              //               return InkWell(
              //                 onTap: () {
              //                   Navigator.push(context, MaterialPageRoute(builder: (context) => ItemAddPage(categoryName:data[index]["item"],categoryID: data[index]["id"],),));
              //                 },
              //                 child: Container(
              //                   height: h * 0.2,
              //                   width: w * 0.4,
              //                   margin: EdgeInsets.all(w*0.03),
              //                   decoration: BoxDecoration(
              //                       borderRadius: BorderRadius.circular(w * 0.04),
              //                       color: theColors.third,
              //                       boxShadow: [
              //                         BoxShadow(
              //                             color: theColors.secondary,
              //                             blurRadius: w * 0.01,
              //                             spreadRadius: w * 0.0001,
              //                             offset: Offset(0, 4))
              //                       ]),
              //                   child: Center(
              //                     child: Text(
              //                       data[index]["item"],
              //                       style: TextStyle(
              //                           fontWeight: FontWeight.w500,
              //                           color: theColors.primaryColor),
              //                     ),
              //                   ),
              //                 ),
              //               );
              //
              //             },
              //           );
              //
              //   },
              // ),


            ],
          ),
        ),
      ),
    );
  }
}
