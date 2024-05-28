import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nectar_admin/core/common/colors.dart';
import 'package:nectar_admin/feature/controller/addingController.dart';
import 'package:nectar_admin/model/bestSelling_model.dart';

import '../../main.dart';

class BestSelling extends ConsumerStatefulWidget {
  const BestSelling({super.key});

  @override
  ConsumerState<BestSelling> createState() => _BestSellingState();
}

class _BestSellingState extends ConsumerState<BestSelling> {
  TextEditingController itemsName=TextEditingController();
  TextEditingController price=TextEditingController();
  TextEditingController qty=TextEditingController();
  TextEditingController description=TextEditingController();
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
        .ref('best selling/${DateTime.now().toString()}-$name')
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
  addBestSelling(){
    BestSellingModel bestSellingModel=BestSellingModel(
        itemName: itemsName.text,
        price: double.tryParse(price.text)!,
        qty: int.tryParse(qty.text)!,
        description: description.text,
        image: urlDownlod??"",
        id: "");
    ref.watch(addController).controllBestsellingFunction(bestsellingModel: bestSellingModel);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
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
            padding: EdgeInsets.all(w*0.03),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                            radius: w*0.1,
                                            backgroundColor: theColors.secondary,
                                            backgroundImage: pickFile != null ? MemoryImage(Uint8List.fromList(pickFile!.bytes as List<int>)) : null,
                                          ),
                                        ),
                                      ],
                                    ),
                                    ListView(
                                      shrinkWrap: true,
                                      physics: BouncingScrollPhysics(),
                                      children: [
                                        TextFormField(
                                          controller: itemsName,
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
                                        TextFormField(
                                          controller: price,
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
                                        TextFormField(
                                          controller: qty,
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
                                        TextFormField(
                                          controller: description,
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
                                      ],
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          addBestSelling();
                                          setState(() {

                                          });
                                        }, child: Text("Add")),

                                  ],
                                ),
                              ),
                            ]
                        ),
                        ListView(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            children: [
                              Container(
                                color: Colors.blueGrey,
                              ),]
                        )
                      ]),
                )
              ],
            ),
          ),
        ));
  }
}
