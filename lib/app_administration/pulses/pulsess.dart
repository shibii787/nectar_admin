import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nectar_admin/core/common/colors.dart';
import 'package:nectar_admin/feature/controller/addingController.dart';
import 'package:nectar_admin/model/bestSelling_model.dart';
import 'package:nectar_admin/model/pulses_model.dart';

import '../../main.dart';

class Pulses extends ConsumerStatefulWidget {
  const Pulses({super.key});

  @override
  ConsumerState<Pulses> createState() => _BestSellingState();
}

class _BestSellingState extends ConsumerState<Pulses> {

  TextEditingController itemsNameController=TextEditingController();
  TextEditingController priceController=TextEditingController();
  TextEditingController qtyController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();

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
        .ref('pulses/${DateTime.now().toString()}-$name')
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
 addPulses(){
    PulsesModel pulsesModel = PulsesModel(
        name: itemsNameController.text,
        price: double.tryParse(priceController.text)!,
        qty: int.tryParse(qtyController.text)!,
        description: descriptionController.text,
        image: urlDownlod ?? "",
        id: "");
    ref.watch(addController).controllPulsesFunction(pulsesModel: pulsesModel);
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
                                            radius: w*0.06,
                                            backgroundColor: theColors.secondary,
                                            backgroundImage: pickFile != null ? MemoryImage(Uint8List.fromList(pickFile!.bytes as List<int>)) : null,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: h*0.4,
                                      width: w*1,
                                      child: ListView(
                                        shrinkWrap: true,
                                        physics: BouncingScrollPhysics(),
                                        children: [
                                          SizedBox(height: w*0.01,),
                                          TextFormField(
                                            controller: itemsNameController,
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(w*0.05)
                                                ),
                                                labelText: "Name",
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
                                          SizedBox(
                                            height: w*0.01
                                          ),
                                          TextFormField(
                                            controller: priceController,
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(w*0.05)
                                                ),
                                                labelText: "Price",
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
                                          SizedBox(height: w*0.01,),
                                          TextFormField(
                                            controller: qtyController,
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(w*0.05)
                                                ),
                                                labelText: "Quantity",
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
                                          SizedBox(height: w*0.01,),
                                          TextFormField(
                                            controller: descriptionController,
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(w*0.05)
                                                ),
                                                labelText: "Description",
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
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          addPulses();
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
                              ref.watch(pulsesStreamProvider).when(data: (data) {
                                data.sort((a, b) => a.name.compareTo(b.name));
                                return  GridView.builder(
                                  itemCount: data.length,
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: w * 0.03,
                                    mainAxisSpacing: w * 0.03,
                                    childAspectRatio: 1,
                                  ),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      height: w*0.55,
                                      width: w*0.35,
                                      padding: EdgeInsets.all(w*0.03),
                                      margin: EdgeInsets.all(w*0.03),
                                      decoration: BoxDecoration(
                                        color: theColors.third.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(w * 0.05),
                                        border: Border.all(width: w * 0.002, color: theColors.third),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Name : ${data[index].name}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            "₹${data[index].price}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            "Quantity : ${data[index].qty}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            "Description : ${data[index].description}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          ElevatedButton(onPressed: () {
                                            FirebaseFirestore.instance.collection("pulses").doc(data[index].id).delete();
                                          }, child: Icon(CupertinoIcons.delete))
                                        ],
                                      ),
                                    );
                                  },);
                              }, error:  (error, stackTrace) {
                                return Text(error.toString());
                              },
                                loading:  () {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                },),

                            ]
                        )
                      ]),
                )
              ],
            ),
          ),
        ));
  }
}
