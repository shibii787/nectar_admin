import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nectar_admin/core/common/colors.dart';

import '../../feature/controller/addingController.dart';
import '../../main.dart';
import '../../model/adminModel.dart';

class adminUsers extends ConsumerStatefulWidget {
  const adminUsers({super.key});

  @override
  ConsumerState<adminUsers> createState() => _bannerPageState();
}

class _bannerPageState extends ConsumerState<adminUsers> {

  TextEditingController emailController =TextEditingController();
  TextEditingController passwordController =TextEditingController();

  int setId = 10;

  getLoggedIn() async {
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text);

    setId = setId+1;

    AdminModel adminModel = AdminModel(
        name: emailController.text,
        password: passwordController.text,
        id: setId.toString()
    );

    ref.watch(addController).addAdmins(adminModel: adminModel, docId: setId.toString());

    var adminDetails = await FirebaseFirestore.instance.collection("admins").where(
        "name",isEqualTo: emailController.text.trim()
    ).get();

    adminEmail = adminDetails.docs[0]["name"];
    adminId = adminDetails.docs[0]["id"];
    print("_________________${adminEmail}");
}

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: theColors.sixth,
        appBar: AppBar(
          backgroundColor: theColors.third,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text("Edit Admin",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: theColors.primaryColor
            ),),
          bottom: TabBar(
              labelColor: theColors.primaryColor,
              unselectedLabelColor: theColors.secondary,
              indicatorColor: theColors.primaryColor,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: w*0.003,
              tabs: [
                Tab(
                  text: "Add",
                ),
                Tab(
                  text: "View",
                ),
              ]),
        ),
        body: Padding(
          padding: EdgeInsets.all(w*0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: TabBarView(
                    children: [
                      ListView(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        children: [
                          Container(
                            height: h*0.4,
                            width: w*1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextFormField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(w*0.05)
                                      ),
                                      labelText: "Email",
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
                                TextFormField(
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(w*0.05)
                                      ),
                                      labelText: "Password",
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
                                ElevatedButton(onPressed: () {
                                  getLoggedIn();

                                  emailController.clear();
                                  passwordController.clear();

                                }, child: Text("ADD"))
                              ],
                            ),
                          ),
                        ],
                      ),
                      ListView(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        children: [
                          ref.watch(adminStreamProvider).when(
                              data: (data) {
                                return GridView.builder(
                                  itemCount: data.length,
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 1,
                                      crossAxisSpacing: w*0.01,
                                      mainAxisSpacing: w*0.01,
                                      crossAxisCount: 4),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      height: h*0.8,
                                      width: w*0.8,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: theColors.third
                                        ),
                                          borderRadius: BorderRadius.circular(w*0.03),
                                      ),
                                      margin: EdgeInsets.all(w*0.02),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(data[index].name),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              ElevatedButton(onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: Center(
                                                          child: Text("Admin Details",style: TextStyle(
                                                              fontWeight: FontWeight.w600
                                                          ),)),
                                                      actions: [
                                                        Column(
                                                          children: [
                                                            Text("Name: ${data[index].name}"),
                                                            Text("Email: ${data[index].password}"),
                                                            Text("ID: ${data[index].id}"),
                                                          ],
                                                        )
                                                      ],
                                                    );
                                                  },);
                                              }, child: Text("View")),

                                              ElevatedButton(onPressed: () {
                                                FirebaseFirestore.instance.collection("admins").doc(data[index].id).delete();
                                              }, child: Icon(Icons.delete_outline))
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  },);
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
                        ],
                      )

                    ]
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
