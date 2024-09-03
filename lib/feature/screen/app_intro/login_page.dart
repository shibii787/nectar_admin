import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nectar_admin/core/common/colors.dart';
import 'package:nectar_admin/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  getLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("loggedIn", true);
    setState(() {

    });
  }

  bool tap = true;

  TextEditingController emailController= TextEditingController();
  TextEditingController passwordController = TextEditingController();


  final emailValidation =
  RegExp(r"^[a-z0-9.a-z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-z0-9]+\.[a-z]+");
  final passwordValidation =
  RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$");

  final formKey = GlobalKey<FormState>();

  toLogIn() async {
    if (emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please enter your email")));
    }
    if (passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please enter your password")));
    }

    if(formKey.currentState!.validate()){

      var userlist = await FirebaseFirestore.instance
          .collection('admins')
          .where('name', isEqualTo: emailController.text)
          .get();
      if (userlist.docs.isNotEmpty) {
        if (passwordController.text == userlist.docs[0]['password']) {
          Navigator.pushReplacement(context,
              CupertinoPageRoute(
                builder: (context) => const Home(),));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("wrong password")));
        }
      }
    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please enter valid details")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
             Row(
               children: [
                 Expanded(
                   flex: 3,
                     child: Container(
                       height: h*1,
                       color: theColors.third,
                       child: Center(
                         child: Text("NECTAR",
                         style: TextStyle(
                           letterSpacing: 20,
                           color: Colors.white,
                           fontSize: w*0.025,
                         ),),
                       ),
                     ),
                 ),
                 Expanded(
                   flex: 1,
                     child: Column(
                       children: [
                         Container(
                           height: h*1,
                           color:theColors.fourth,
                           child: Padding(
                             padding: EdgeInsets.all(w*0.005),
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Container(
                                   decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(w * 0.03)),
                                   child: TextFormField(
                                     style: const TextStyle(
                                       color: theColors.secondary,
                                     ),
                                     controller: emailController,
                                     autovalidateMode: AutovalidateMode.onUserInteraction,
                                     validator: (value) {
                                       if (!emailValidation.hasMatch(value!)) {
                                         return "Email";
                                       } else {
                                         return null;
                                       }
                                     },
                                     decoration: InputDecoration(
                                       filled: true,
                                       fillColor: theColors.third.withOpacity(0.08),
                                       labelText: "Email",
                                       labelStyle: const TextStyle(color: theColors.secondary),
                                       hintText: "Enter the Email",
                                       hintStyle: const TextStyle(color: theColors.secondary),
                                       suffixIcon: const Icon(CupertinoIcons.mail),
                                       enabledBorder: OutlineInputBorder(
                                         borderRadius: BorderRadius.circular(w * 0.01),
                                         borderSide: const BorderSide(color: theColors.third),
                                       ),
                                       focusedBorder: OutlineInputBorder(
                                         borderRadius: BorderRadius.circular(w * 0.01),
                                         borderSide: const BorderSide(color: theColors.third),
                                       ),
                                       border: OutlineInputBorder(
                                         borderRadius: BorderRadius.circular(w * 0.01),
                                         borderSide: const BorderSide(color: theColors.third),
                                       ),
                                     ),
                                   ),
                                 ),
                                 SizedBox(
                                   height: w*0.03,
                                 ),
                                 Container(
                                   decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(w * 0.03)),
                                   child: TextFormField(
                                     style: const TextStyle(
                                       color: theColors.secondary,
                                     ),
                                     controller: passwordController,
                                     autovalidateMode: AutovalidateMode.onUserInteraction,
                                     validator: (value) {
                                       if (!passwordValidation.hasMatch(value!)) {
                                         return "Password";
                                       } else {
                                         return null;
                                       }
                                     },
                                     obscureText: tap ? true : false,
                                     decoration: InputDecoration(
                                       filled: true,
                                       fillColor: theColors.third.withOpacity(0.08),
                                       labelText: "Password",
                                       labelStyle: const TextStyle(color: theColors.secondary),
                                       hintText: "Enter the password",
                                       hintStyle: const TextStyle(color: theColors.secondary),
                                       suffixIcon: InkWell(
                                           onTap: () {
                                             tap = !tap;
                                             setState(() {});
                                           },
                                           child: tap == false
                                               ? const Icon(
                                             Icons.visibility,
                                             color: theColors.secondary,
                                           )
                                               : const Icon(
                                             Icons.visibility_off,
                                             color: theColors.secondary,
                                           )),
                                       enabledBorder: OutlineInputBorder(
                                         borderRadius: BorderRadius.circular(w * 0.01),
                                         borderSide: const BorderSide(color: theColors.third),
                                       ),
                                       focusedBorder: OutlineInputBorder(
                                         borderRadius: BorderRadius.circular(w * 0.01),
                                         borderSide: const BorderSide(color: theColors.third),
                                       ),
                                       border: OutlineInputBorder(
                                         borderRadius: BorderRadius.circular(w * 0.01),
                                         borderSide: const BorderSide(color: theColors.third),
                                       ),
                                     ),
                                   ),
                                 ),
                                 SizedBox(
                                   height: w*0.03,
                                 ),
                                 InkWell(

                                   onTap: () {
                                     getLoggedIn();
                                     toLogIn();
                                   },

                                   child: Container(
                                     height: w*0.025,
                                     width: w*0.09,
                                     decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(w*0.03),
                                       color: theColors.fourth,
                                       border: Border.all(color: theColors.third)
                                     ),
                                     child: Center(
                                       child: Text("Login",
                                       style: TextStyle(
                                         color: theColors.secondary,
                                         fontSize: w*0.01,
                                         fontWeight: FontWeight.bold
                                       ),),
                                     ),
                                   ),
                                 )
                               ],
                             ),
                           ),
                         ),

                       ],
                     ),
                 ),
               ],
             )
            ],
          ),
        ),
      ),
    );
  }
}
