import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nectar_admin/core/common/colors.dart';
import 'package:nectar_admin/feature/controller/addingController.dart';

import '../../../main.dart';


class AppUsers extends ConsumerStatefulWidget {
  const AppUsers({super.key});

  @override
  ConsumerState<AppUsers> createState() => _AppUsersState();
}

class _AppUsersState extends ConsumerState<AppUsers> {

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.width > 840 ? Scaffold(
      backgroundColor: theColors.beige,
      appBar: AppBar(
        backgroundColor: theColors.third,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("USERS",style: TextStyle(
          color: theColors.primaryColor,
            fontWeight: FontWeight.w600,
          letterSpacing: 1
        ),),
      ),
      body: Padding(
        padding: EdgeInsets.all(w*0.03),
        child: Column(
          children: [
            ref.watch(streamdataProvider).when(
                data: (data) {
                  return Expanded(
                    child: GridView.builder(
                      itemCount: data.length,
                        physics: const BouncingScrollPhysics(),
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
                              borderRadius: BorderRadius.circular(w*0.03),
                              color: theColors.third
                            ),
                            margin: EdgeInsets.all(w*0.02),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(data[index].name,
                                style: TextStyle(
                                  color: theColors.primaryColor,
                                  fontSize: w*0.012
                                ),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Center(
                                                  child: Text("User Details",style: TextStyle(
                                                    fontWeight: FontWeight.w600
                                                  ),)),
                                              actions: [
                                                Column(
                                                  children: [
                                                    Text("Name: ${data[index].name}"),
                                                    Text("Email: ${data[index].email}"),
                                                    Text("Password: ${data[index].password}"),
                                                    Text("Location: ${data[index].location}"),
                                                    Text("PhoneNumber: ${data[index].phoneNumber}"),
                                                    Text("ID: ${data[index].id}"),
                                                  ],
                                                )
                                              ],
                                            );
                                          },);
                                    }, child: const Text("View")),
                                    ElevatedButton(onPressed: () {
                                      FirebaseFirestore.instance.collection("account").doc(data[index].id).delete();
                                    }, child: const Icon(Icons.delete_outline)),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {

                                        }, child: const Text("Block"))
                                  ],
                                )
                              ],
                            ),
                          );
                        },),
                  );
                },
                error: (error, stackTrace) {
                  return Text(error.toString());
                },
                loading: () {
                  return const Center(
                      child: CircularProgressIndicator(),
                    );
                },)
          ],
        ),
      ),
    ) : const CircularProgressIndicator();
  }
}