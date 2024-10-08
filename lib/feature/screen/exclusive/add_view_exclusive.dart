import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nectar_admin/core/common/colors.dart';
import 'package:nectar_admin/feature/controller/addingController.dart';
import 'package:nectar_admin/model/exclusive_model.dart';

import '../../../main.dart';

class AddViewExclusivePage extends ConsumerStatefulWidget {
  const AddViewExclusivePage({super.key});

  @override
  ConsumerState<AddViewExclusivePage> createState() => _addViewExclusivePageState();
}

class _addViewExclusivePageState extends ConsumerState<AddViewExclusivePage> {

  //For controllers in textforfield
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemPriceController = TextEditingController();
  TextEditingController itemQtyController = TextEditingController();
  TextEditingController itemDescriptionController = TextEditingController();

  //To upload image
  PlatformFile? pickFile;
  UploadTask? uploadTask;
  String? urlDownlod;
  Future selectFileToMessage(String name) async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    pickFile = result.files.first;

    // String? ext = pickFile?.name?.split('.')?.last;
    final fileBytes = result.files.first.bytes;

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Uploading...")));
    uploadFileToFireBase(name, fileBytes);

    setState(() {});
  }

  Future uploadFileToFireBase(String name, fileBytes) async {
    uploadTask = FirebaseStorage.instance
        .ref('exclusive/${DateTime.now().toString()}-$name')
        .putData(fileBytes, SettableMetadata(contentType: 'image/jpeg'));
    final snapshot = await uploadTask?.whenComplete(() {});
    urlDownlod = (await snapshot?.ref?.getDownloadURL())!;

    // ignore: use_build_context_synchronously
    // showUploadMessage(context, '$name Uploaded Successfully...');
    await Future.delayed(const Duration(seconds: 2));
    // ignore: use_build_context_synchronously
    // ScaffoldMessenger.of(context).clearSnackBars();
    setState(() {});
  }

  addExclusiveListFunc(){
    ExclusiveModel exclusiveModel = ExclusiveModel(
        name: itemNameController.text,
        price: double.tryParse(itemPriceController.text)!,
        qty: int.tryParse(itemQtyController.text)!,
        description: itemDescriptionController.text,
        image: urlDownlod ?? "",
        id: "");
        ref.watch(addController).controlExclusiveFunc(exclusiveModel: exclusiveModel);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: theColors.sixth,
          appBar: AppBar(
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
                child: const Icon(Icons.arrow_back,color: Colors.white)),
            backgroundColor: theColors.third,
            elevation: 0,
            title: const Text("Exclusive List",style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),),
            bottom: const TabBar(
              indicatorColor: Colors.white,
              indicatorWeight: 4.0,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              labelStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              tabs: [
                Tab(
                  text: "Add",
                ),
                Tab(
                  text: "View",
                ),
              ],
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(w * 0.03),
            child: Column(
              children: [
                Expanded(
                  child: TabBarView(
                      children: [
                    ListView(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Stack(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      selectFileToMessage("");
                                    },
                                    child: CircleAvatar(
                                      radius: w * 0.065,
                                      backgroundColor: theColors.secondary,
                                      backgroundImage: pickFile != null
                                          ? MemoryImage(Uint8List.fromList(
                                              pickFile!.bytes as List<int>))
                                          : null,
                                    ),
                                  ),
                                ],
                              ),
                              ListView(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                children: [
                                  SizedBox(height: w*0.01,),
                                  TextFormField(
                                    controller: itemNameController,
                                    decoration: InputDecoration(
                                      labelText: "Name",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(
                                                    w * 0.05)),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(w * 0.05),
                                          borderSide: const BorderSide(
                                              color: theColors.third),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(
                                                    w * 0.05),
                                            borderSide: const BorderSide(
                                                color: theColors.third))),
                                  ),
                                  SizedBox(height: w*0.01,),
                                  TextFormField(
                                    controller: itemPriceController,
                                    decoration: InputDecoration(
                                        labelText: "Price",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(
                                                    w * 0.05)),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(w * 0.05),
                                          borderSide: const BorderSide(
                                              color: theColors.third),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(
                                                    w * 0.05),
                                            borderSide: const BorderSide(
                                                color: theColors.third))),
                                  ),
                                  SizedBox(height: w*0.01,),
                                  TextFormField(
                                    controller: itemQtyController,
                                    decoration: InputDecoration(
                                        labelText: "Quantity",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(
                                                    w * 0.05)),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(w * 0.05),
                                          borderSide: const BorderSide(
                                              color: theColors.third),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(
                                                    w * 0.05),
                                            borderSide: const BorderSide(
                                                color: theColors.third))),
                                  ),
                                  SizedBox(height: w*0.01,),
                                  TextFormField(
                                    controller: itemDescriptionController,
                                    decoration: InputDecoration(
                                        labelText: "Description",
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(
                                                    w * 0.05)),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(w * 0.05),
                                          borderSide: const BorderSide(
                                              color: theColors.third),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(
                                                    w * 0.05),
                                            borderSide: const BorderSide(
                                                color: theColors.third))),
                                  ),
                                  SizedBox(height: w*0.01,)
                                ],
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    addExclusiveListFunc();
                                    itemNameController.clear();
                                    itemPriceController.clear();
                                    itemQtyController.clear();
                                    itemDescriptionController.clear();
                                  },
                                  child: const Text("Add")),
                            ],
                          ),
                        ]),
                    ListView(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          Column(
                            children: [
                              ref.watch(exclusiveStreamProvider).when(
                                  data: (data) {
                                    return GridView.builder(
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
                                              color: Colors.red
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
                                                          title: const Center(
                                                              child: Text("Item Details",style: TextStyle(
                                                                  fontWeight: FontWeight.w600
                                                              ),)),
                                                          actions: [
                                                            Column(
                                                              children: [
                                                                Text("Name: ${data[index].name}"),
                                                                Text("Email: ${data[index].price}"),
                                                                Text("Password: ${data[index].qty}"),
                                                                Text("Location: ${data[index].description}"),
                                                                Text("ID: ${data[index].id}"),
                                                              ],
                                                            )
                                                          ],
                                                        );
                                                      },);
                                                  }, child: const Text("View")),

                                                  ElevatedButton(onPressed: () {
                                                    FirebaseFirestore.instance.collection("exclusive").doc(data[index].id).delete();
                                                  }, child: const Icon(Icons.delete_outline))
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
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },)
                            ],
                          ),
                        ])
                  ]),
                )
              ],
            ),
          ),
        ));
  }
}
