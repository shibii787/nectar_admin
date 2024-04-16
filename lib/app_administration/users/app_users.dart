import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nectar_admin/colors.dart';

class appUsers extends StatefulWidget {
  const appUsers({super.key});

  @override
  State<appUsers> createState() => _appUsersState();
}

class _appUsersState extends State<appUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theColors.primaryColor,
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
        title: Text("Users",style: TextStyle(
          color: theColors.primaryColor,fontWeight: FontWeight.w600
        ),),
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("accounts").snapshots(),
              builder: (context, snapshot) {
                if(!snapshot.hasData){
                  return Center(
                    child: Text("No Data Found"),
                  );
                }
                var data=snapshot.data!.docs;
                return data.length==0?
                    Text("No User Found")
                : ListView.builder(
                  itemCount: data.length,
                  physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(data[index]["name"]),
                    );
                    },);
              },)
        ],
      ),
    );
  }
}
