import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nectar_admin/core/common/colors.dart';
import 'package:nectar_admin/feature/controller/addingController.dart';
import 'package:nectar_admin/model/addCategory_model.dart';

import '../../main.dart';
import 'app_categories.dart';

class AddCategory extends ConsumerStatefulWidget {
  const AddCategory({super.key});

  @override
  ConsumerState<AddCategory> createState() => _addCategoryState();
}

class _addCategoryState extends ConsumerState<AddCategory> {

  TextEditingController categoryController = TextEditingController();

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
        .ref('categories/${DateTime.now().toString()}-$name')
        .putData(fileBytes,SettableMetadata(
        contentType: 'image/jpeg'
    ));
    final snapshot = await uploadTask?.whenComplete(() {});
    urlDownlod = (await snapshot?.ref?.getDownloadURL())!;

    // ignore: use_build_context_synchronously
    // showUploadMessage(context, '$name Uploaded Successfully...');
    await Future.delayed(const Duration(seconds: 2));
    // ignore: use_build_context_synchronously
    // ScaffoldMessenger.of(context).clearSnackBars();
    setState(() {});
  }

  addCategoryFunc(){
    AddCategoryModel addCategoryModel = AddCategoryModel(
        name: categoryController.text,
        image: urlDownlod ?? "",
        time: Timestamp.now(),
        id: ""
    );
    ref.watch(addController).addCategoryControlFunction(addCategoryModel: addCategoryModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theColors.sixth,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: theColors.third,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
            child: const Icon(Icons.arrow_back,color: theColors.primaryColor,)),
        title: const Text("Add Category",style: TextStyle(
          color: theColors.primaryColor,fontWeight: FontWeight.w600
        ),),
      ),
      body: Padding(
        padding: EdgeInsets.all(w*0.03),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              children: [
                InkWell(
                  onTap: () {
                    selectFileToMessage("");
                  },
                  child: CircleAvatar(
                    radius: w*0.1,
                    backgroundColor: theColors.secondary,
                    backgroundImage: pickFile != null ? MemoryImage(Uint8List.fromList(pickFile!.bytes as List<int>)) : null,
                  ),
                ),
                // Positioned(
                //   left: w*0.15,
                //   bottom: w*0.02,
                //   child: InkWell(
                //     onTap: () {
                //     },
                //     child: CircleAvatar(
                //       radius: w*0.015,
                //       backgroundColor: theColors.third,
                //       child: Center(
                //         child: Icon(Icons.add,color: theColors.secondary,),
                //       ),
                //     ),
                //   ),
                // )
              ],
            ),
            Center(
              child: TextFormField(
                controller: categoryController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(w*0.05)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(w*0.05),
                    borderSide: const BorderSide(
                      color: theColors.third
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(w*0.05),
                    borderSide: const BorderSide(
                      color: theColors.third
                    )
                  )
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {

                  // FirebaseFirestore.instance.collection("categories").add({
                  //   "item" : categoryController.text,
                  //   "id":"",
                  //   "time":Timestamp.now(),
                  //   "image": urlDownlod
                  // }).then((value) => value.update({
                  //   "id" : value.id
                  // }));

                  addCategoryFunc();

                  categoryController.clear();

                }, child: const Text("Add")),

            ElevatedButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Categories(),));
            }, child: const Text("Go To Page")),

          ],
        ),
      )
    );
  }
}
