import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nectar_admin/core/common/colors.dart';
import 'package:nectar_admin/feature/controller/addingController.dart';
import 'package:nectar_admin/model/exclusive_model.dart';

import '../../main.dart';

class addViewExclusivePage extends ConsumerStatefulWidget {
  const addViewExclusivePage({super.key});

  @override
  ConsumerState<addViewExclusivePage> createState() => _addViewExclusivePageState();
}

class _addViewExclusivePageState extends ConsumerState<addViewExclusivePage> {

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
        .showSnackBar(SnackBar(content: Text("Uploading...")));
    uploadFileToFireBase(name, fileBytes);

    setState(() {});
  }

  Future uploadFileToFireBase(String name, fileBytes) async {
    uploadTask = FirebaseStorage.instance
        .ref(']exclusive/${DateTime.now().toString()}-$name')
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
        itemName: itemNameController.text,
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
          appBar: AppBar(
            bottom: TabBar(tabs: [
              Tab(
                text: "Add",
              ),
              Tab(
                text: "View",
              ),
            ]),
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
                        physics: BouncingScrollPhysics(),
                        children: [
                          Container(
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
                                        radius: w * 0.1,
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
                                  physics: BouncingScrollPhysics(),
                                  children: [
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
                                            borderSide: BorderSide(
                                                color: theColors.third),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      w * 0.05),
                                              borderSide: BorderSide(
                                                  color: theColors.third))),
                                    ),
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
                                            borderSide: BorderSide(
                                                color: theColors.third),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      w * 0.05),
                                              borderSide: BorderSide(
                                                  color: theColors.third))),
                                    ),
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
                                            borderSide: BorderSide(
                                                color: theColors.third),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      w * 0.05),
                                              borderSide: BorderSide(
                                                  color: theColors.third))),
                                    ),
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
                                            borderSide: BorderSide(
                                                color: theColors.third),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      w * 0.05),
                                              borderSide: BorderSide(
                                                  color: theColors.third))),
                                    ),
                                  ],
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      addExclusiveListFunc();
                                    },
                                    child: Text("Add")),
                              ],
                            ),
                          ),
                        ]),
                    ListView(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        children: [
                          Container(
                            color: Colors.blueGrey,
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
