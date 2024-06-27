import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nectar_admin/core/common/colors.dart';
import 'package:nectar_admin/feature/controller/addingController.dart';

import '../../main.dart';

class itemViewPage extends ConsumerStatefulWidget {
  final String title;
  final String id;
  const itemViewPage({super.key,
  required this.title,
    required this.id
  });

  @override
  ConsumerState<itemViewPage> createState() => _itemViewPageState();
}

class _itemViewPageState extends ConsumerState<itemViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theColors.sixth,
      appBar: AppBar(
        backgroundColor: theColors.third,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back,
              color: theColors.primaryColor),
        ),
        centerTitle: true,
        title: Text(widget.title,style: TextStyle(
          color: theColors.primaryColor
        ),),
      ),
      body: Column(
        children: [

          StreamBuilder(
              stream: FirebaseFirestore.instance.collection("categories").doc(widget.id).collection("subItems").snapshots(),
              builder: (context, snapshot) {
                if(!snapshot.hasData){
                  return Text("No data");
                }
                var newDetails = snapshot.data!.docs;
                return newDetails.length==0?
                Center(
                    child: CircularProgressIndicator()) :
                Expanded(
                  child: GridView.builder(
                    itemCount: newDetails.length,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: w * 0.03,
                      mainAxisSpacing: w * 0.06,
                      childAspectRatio: 0.6,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        height: w*0.35,
                        width: w*0.35,
                        padding: EdgeInsets.all(w*0.03),
                        margin: EdgeInsets.all(w*0.03),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(w * 0.05),
                          border: Border.all(width: w * 0.002, color: theColors.third),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                                height: w*0.1,
                                width: w*0.1,
                                child: Image(image: NetworkImage((newDetails[index]["image"])),
                                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                  return Container(
                                    height: w*0.2,
                                    width: w*0.4,
                                    decoration: BoxDecoration(
                                        color: theColors.primaryColor,
                                        borderRadius: BorderRadius.circular(w*0.03)
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Image not found',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: theColors.secondary,
                                              fontWeight: FontWeight.bold,

                                            ),
                                          ),
                                          Text(
                                            '!Check your internet connection',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 8,
                                              color: theColors.secondary,
                                              fontWeight: FontWeight.bold,

                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );}
                        ),
                            ),
                            Text(newDetails[index]["name"],style: TextStyle(
                              fontWeight: FontWeight.w600,

                            ),),
                            Text("Quantity : ${newDetails[index]["qty"]}".toString(),style: TextStyle(
                                fontWeight: FontWeight.w600
                            ),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("₹${newDetails[index]["price"]} ".toString(),style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),),
                                Container(
                                  height: w*0.04,
                                  width: w*0.04,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(w * 0.04),
                                      color: theColors.third,
                                      border: Border.all(
                                          color: theColors.secondary,
                                          width: w * 0.003)),
                                  child:  Icon(
                                    Icons.add,
                                    color: theColors.primaryColor,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    },),
                );
              }
          )

          // ref.watch(subItemProvider).when(
          //     data: (data) {
          //       return ListView.builder(
          //         itemCount: data.length,
          //         scrollDirection: Axis.vertical,
          //         shrinkWrap: true,
          //         physics: BouncingScrollPhysics(),
          //         itemBuilder: (context, index) {
          //         return Text(data[index].name);
          //       },);
          //     },
          //     error: (error, stackTrace) {
          //       return Text(error.toString());
          //     },
          //     loading: () {
          //       return Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     },
          // )

        ],
      ),
    );
  }
}
