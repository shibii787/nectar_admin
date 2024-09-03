import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nectar_admin/core/common/colors.dart';
import 'package:nectar_admin/feature/controller/addingController.dart';

import '../../../main.dart';
import '../../../model/grocery_model.dart';


class AddGroceries extends ConsumerStatefulWidget {
  const AddGroceries({super.key});

  @override
  ConsumerState<AddGroceries> createState() => _addGroceriesState();
}

class _addGroceriesState extends ConsumerState<AddGroceries> {

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
        .showSnackBar(const SnackBar(content: Text("Uploading...")));
    uploadFileToFireBase(name, fileBytes);

    setState(() {});
  }
  addgrocerioes(){
    GroceryModel groceryModel = GroceryModel(
        name: itemsNameController.text,
        price: double.tryParse(priceController.text)!,
        qty: int.tryParse(qtyController.text)!,
        description: descriptionController.text,
        image: urlDownlod ?? "",
        id: ""
    );
    ref.watch(addController).addGroceriesControll(groceryModel:groceryModel);
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: theColors.sixth,
        appBar: AppBar(
          title: const Text("Groceries",style: TextStyle(
              fontWeight: FontWeight.w600
          ),),
          bottom: const TabBar(
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
                                        radius: w*0.065,
                                        backgroundColor: theColors.secondary,
                                        backgroundImage: pickFile != null ? MemoryImage(Uint8List.fromList(pickFile!.bytes as List<int>)) : null,
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
                                      controller: itemsNameController,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(w*0.05)
                                          ),
                                          labelText: "Name",
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
                                    SizedBox(height: w*0.01,),
                                    TextFormField(
                                      controller: priceController,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(w*0.05)
                                          ),
                                          labelText: "Price",
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
                                    SizedBox(height: w*0.01,)
                                  ],
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      addgrocerioes();
                                      // addBestSelling();
                                    }, child: const Text("Add")),
                              ],
                            ),
                          ]
                      ),
                      ListView(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          children: [
                            ref.watch(groceriesstreamProvider).when(data: (data) {
                              data.sort((a, b) => a.name.compareTo(b.name));
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
                                              FirebaseFirestore.instance.collection("groceries").doc(data[index].id).delete();
                                            }, child: const Icon(Icons.delete_outline))
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                },);
                            }, error:  (error, stackTrace) {
                              return Text(error.toString());
                            },
                              loading:  () {
                                return const Center(
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
      ),
    );
  }
}
