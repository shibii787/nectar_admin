import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nectar_admin/core/common/colors.dart';

import '../../main.dart';

class fruitsAndVegetables extends StatefulWidget {
  const fruitsAndVegetables({super.key});

  @override
  State<fruitsAndVegetables> createState() => _fruitsAndVegetablesState();
}

class _fruitsAndVegetablesState extends State<fruitsAndVegetables> {

  TextEditingController itemnameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController qtyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theColors.primaryColor,
      appBar: AppBar(
        backgroundColor: theColors.third,
        title: Text("Store",style: TextStyle(
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
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
              SizedBox(height: w*0.03),
              TextFormField(
                controller: priceController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(w*0.05),
                  ),
                  label: Text("Add Item Price"),
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
              SizedBox(height: w*0.03),
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
              SizedBox(height: w*0.03),
              ElevatedButton(
                  onPressed: () {

                  }, child: Text("Add"))
            ],
          ),
        ),
      ),
    );
  }
}
