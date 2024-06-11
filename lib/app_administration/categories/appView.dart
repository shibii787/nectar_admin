import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nectar_admin/app_administration/categories/app_categories.dart';
import 'package:nectar_admin/core/common/colors.dart';
import 'package:rxdart/rxdart.dart';

import '../../main.dart';

class Appview extends StatefulWidget {

  const Appview({super.key,});

  @override
  State<Appview> createState() => _AppviewState();
}

class _AppviewState extends State<Appview> {

  Stream<List<DocumentSnapshot>> streamSubcollectionData(String mainCollection, String subCollection) {
    return FirebaseFirestore.instance.collection(mainCollection).snapshots().asyncExpand((QuerySnapshot snapshot) {
      List<Stream<List<DocumentSnapshot>>> subcollectionStreams = snapshot.docs.map((DocumentSnapshot doc) {
        return doc.reference.collection(subCollection).snapshots().map((subSnapshot) => subSnapshot.docs);
      }).toList();

      return Rx.combineLatestList(subcollectionStreams).map((List<List<DocumentSnapshot>> snapshots) {
        List<DocumentSnapshot> documents = [];
        for (List<DocumentSnapshot> snapshot in snapshots) {
          documents.addAll(snapshot);
        }
        return documents;
      });
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        title: Text("App View",style: TextStyle(
            color: theColors.primaryColor,fontWeight: FontWeight.w600
        ),),
      ),
      body: Column(
        children: [
          StreamBuilder(
             // stream: FirebaseFirestore.instance.collection("categories").doc().collection("subItems").snapshots(),
            stream: streamSubcollectionData('categories','subItems'),

              builder: (context, snapshot) {
                if(!snapshot.hasData){
                  return Text("No data");
                }
                var newDetails = snapshot.data!;
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
                      crossAxisCount: 3,
                      crossAxisSpacing: w * 0.03,
                      mainAxisSpacing: w * 0.03,
                      childAspectRatio:3,
                    ),
                    itemBuilder: (context, index) {
                      return Center(
                        child: Container(
                          height: w*0.4,
                          width: w*0.4,
                          // padding: EdgeInsets.only(left: w*0.03,right: w*0.03),
                          // margin: EdgeInsets.all(w*0.01),
                          decoration: BoxDecoration(
                            color: theColors.third.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(w * 0.01),
                            border: Border.all(width: w * 0.002, color: theColors.third),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: w*0.033,
                                width: w*0.2,
                                child: Text(newDetails[index]["name"],style: TextStyle(
                                  fontWeight: FontWeight.w600,

                                ),),
                              ),
                              Container(
                                height: w*0.033,
                                width: w*0.2,

                                child: Text("Quantity : ${newDetails[index]["qty"]}".toString(),style: TextStyle(
                                    fontWeight: FontWeight.w600
                                ),),
                              ),
                              Container(
                                height: w*0.033,
                                width: w*0.2,
                                child: Text("₹${newDetails[index]["price"]}".toString(),style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                ),),
                              ),
                            ],
                          ),
                        ),
                      );
                    },),
                );
              }
          )
        ],
      ),
    );
  }
}
