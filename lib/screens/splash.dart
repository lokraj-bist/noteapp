import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:noteaapp/screens/notes.dart';

class splash extends StatefulWidget {
  state createState() => state();

}

class state extends State<splash> {

  void autoNavigate() {
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => notess()   )
      );
    });
  }

  @override
  void initState() {
    super.initState();
    autoNavigate();  // Automatically navigate after 5 seconds every time
  }
  build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 200,
              width: 200,
              child: Center(
                child: SvgPicture.network(
                    'https://cdn.prod.website-files.com/5ee12d8d7f840543bde883de/5ef3a1148ac97166a06253c1_flutter-logo-white-inset.svg'),
              ),
            ),
          )
        ],
      ),
    );
  }
}