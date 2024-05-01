import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nectar_admin/app_administration/categories/app_categories.dart';
import 'package:nectar_admin/core/common/colors.dart';

import '../../main.dart';

class addCategory extends StatefulWidget {
  const addCategory({super.key});

  @override
  State<addCategory> createState() => _addCategoryState();
}

class _addCategoryState extends State<addCategory> {

  TextEditingController category = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: theColors.third,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
            child: Icon(Icons.arrow_back,color: theColors.primaryColor,)),
        title: Text("Add Category",style: TextStyle(
          color: theColors.primaryColor,fontWeight: FontWeight.w600
        ),),
      ),
      body: Padding(
        padding: EdgeInsets.all(w*0.03),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: TextFormField(
                controller: category,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(w*0.05)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(w*0.05),
                    borderSide: BorderSide(
                      color: theColors.third
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(w*0.05),
                    borderSide: BorderSide(
                      color: theColors.third
                    )
                  )
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {

                  FirebaseFirestore.instance.collection("categories").add({
                    "item" : category.text,
                    "id":"",
                    "time":Timestamp.now()
                  }).then((value) => value.update({
                    "id" : value.id
                  }));
                  category.clear();
                }, child: Text("Add")),

            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => categories(),));
            }, child: Text("Go To Page"))

          ],
        ),
      )
    );
  }
}
