import 'package:flutter/material.dart';

import 'core/common/colors.dart';

class banner extends StatefulWidget {
  const banner({super.key});

  @override
  State<banner> createState() => _bannerState();
}

class _bannerState extends State<banner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theColors.beige,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: theColors.third,
        centerTitle: true,
        title: const Text("BANNER",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: theColors.primaryColor
          ),),
      ),
    );
  }
}
