import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nectar_admin/app_administration/categories/appView.dart';

import 'package:nectar_admin/core/common/colors.dart';
import 'package:nectar_admin/feature/controller/addingController.dart';
import 'package:nectar_admin/model/category_model.dart';

import '../../main.dart';

class ItemAddPage extends ConsumerStatefulWidget {
  final String categoryID;
  final String categoryName;
  const ItemAddPage({super.key,
    required this.categoryID,
    required this.categoryName
  });

  @override
  ConsumerState<ItemAddPage> createState() => _itemAddPageState();
}

class _itemAddPageState extends ConsumerState<ItemAddPage> {

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
        .ref('items/${DateTime.now().toString()}-$name')
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


  TextEditingController itemnameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  addItemFunc(){
    CategoryModel categoryModel = CategoryModel(
        name: itemnameController.text,
        price: double.tryParse(priceController.text)!,
        qty: int.tryParse(qtyController.text)!,
        description: descriptionController.text,
        image: urlDownlod ?? '');

    itemnameController.clear();
    priceController.clear();
    qtyController.clear();
    descriptionController.clear();

    ref.watch(addController).controlCollectionFunc(categoryModel: categoryModel,docIdss: widget.categoryID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theColors.primaryColor,
      appBar: AppBar(
        backgroundColor: theColors.third,
        title: Text("${widget.categoryName}",style: TextStyle(
            fontWeight: FontWeight.w600,color: theColors.primaryColor
        ),),
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back,color: theColors.primaryColor,)),
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
                    radius: w*0.08,
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
            TextFormField(
              controller: itemnameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(w*0.05),
                  ),
                  label: Text("Add New Item"),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(w*0.05),
                      borderSide: BorderSide(
                          color: theColors.third
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(w*0.05),
                      borderSide: BorderSide(
                          color: theColors.third
                      )
                  )
              ),
            ),
            TextFormField(
              controller: priceController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(w*0.05),
                  ),
                  label: Text("Add Price"),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(w*0.05),
                      borderSide: BorderSide(
                          color: theColors.third
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(w*0.05),
                      borderSide: BorderSide(
                          color: theColors.third
                      )
                  )
              ),
            ),
            TextFormField(
              controller: qtyController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(w*0.05),
                  ),
                  label: Text("Add Quantity"),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(w*0.05),
                      borderSide: BorderSide(
                          color: theColors.third
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(w*0.05),
                      borderSide: BorderSide(
                          color: theColors.third
                      )
                  )
              ),
            ),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(w*0.05),
                  ),
                  label: Text("Description"),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(w*0.05),
                      borderSide: BorderSide(
                          color: theColors.third
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(w*0.05),
                      borderSide: BorderSide(
                          color: theColors.third
                      )
                  )
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      addItemFunc();
                    }, child: Text("SUBMIT",)),
                ElevatedButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Appview(),));
                },
                    child: Text("Items")
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
