import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nectar_admin/app_intro/splash.dart';

import 'firebase_options.dart';

var h;
var w;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(nectar());
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
        debugShowCheckedModeBanner: false,
        home: splashPage(),
      ),
    );
  }
}
