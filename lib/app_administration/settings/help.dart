import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nectar_admin/core/common/colors.dart';

import '../../main.dart';

class help extends StatefulWidget {
  const help({super.key});

  @override
  State<help> createState() => _helpState();
}

class _helpState extends State<help> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: theColors.primaryColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: theColors.primaryColor,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(CupertinoIcons.back,color: theColors.secondary,)),
        title: Text("Help",style: TextStyle(
            color: theColors.secondary
        )),
      ),
      body: Padding(
        padding:  EdgeInsets.all(w*0.03),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.help),
                SizedBox(width: w*0.05,),
                Column(
                  children: [
                    Text("HELP CENTRE",style: TextStyle(
                        fontSize: w*0.045,
                        fontWeight: FontWeight.w500
                    ),),
                    SizedBox(width: w*0.05),
                    Text("Get help,us contact us")
                  ],
                ),
              ],
            ),
            SizedBox(height: h*0.05),
            Row(
              children: [
                Icon(Icons.text_snippet_rounded),
                SizedBox(width: w*0.05,),
                Text("Terms and Privacy Policy",style: TextStyle(
                    fontSize: w*0.04
                ),)
              ],
            ),

          ],
        ),
      ),
    );

  }
}
