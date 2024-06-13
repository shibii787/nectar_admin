import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nectar_admin/app_administration/categories/appView.dart';
import 'package:nectar_admin/app_administration/categories/app_categories.dart';
import 'package:nectar_admin/app_administration/pulses/pulsess.dart';
import 'package:nectar_admin/app_intro/login_page.dart';
import 'package:nectar_admin/app_administration/home_page.dart';
import 'package:nectar_admin/app_administration/users/app_users.dart';
import 'package:nectar_admin/app_intro/splash.dart';
import 'package:nectar_admin/home_withSidebar.dart';
import 'package:sidebarx/sidebarx.dart';


import 'firebase_options.dart';

var h;
var w;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(ProviderScope
    (child: nectar()));
}

class nectar extends StatefulWidget {
  const nectar({super.key});

  @override
  State<nectar> createState() => _nectarState();
}

class _nectarState extends State<nectar> {

  @override
  Widget build(BuildContext context) {

    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: MaterialApp(
        theme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        debugShowCheckedModeBanner: false,
        home: Appview(),
      ),
    );
  }
}
