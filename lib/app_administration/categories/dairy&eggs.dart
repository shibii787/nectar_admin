import 'package:flutter/material.dart';
import 'package:nectar_admin/core/common/colors.dart';

import '../../main.dart';

class dairyandeggs extends StatefulWidget {
  const dairyandeggs({super.key});

  @override
  State<dairyandeggs> createState() => _dairyandeggsState();
}

class _dairyandeggsState extends State<dairyandeggs> {

  TextEditingController itemnameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theColors.primaryColor,
      appBar: AppBar(
        backgroundColor: theColors.third,
        title: Text("Dairy and Eggs",style: TextStyle(
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
            ElevatedButton(
                onPressed: () {

                }, child: Text("SUBMIT",))
          ],
        ),
      ),
    );
  }
}
