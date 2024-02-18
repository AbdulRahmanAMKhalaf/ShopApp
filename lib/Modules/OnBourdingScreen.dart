
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Share/Componantes.dart';
import '../Share/SharedPreferences.dart';
import 'LoginScreen.dart';

class OnBourdingScreen extends StatefulWidget {
  OnBourdingScreen({super.key});

  @override
  State<OnBourdingScreen> createState() => _OnBourdingScreenState();
}

class _OnBourdingScreenState extends State<OnBourdingScreen> {
  bool isLast = false;
  var formKey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
             CacheHelper.setData(key: 'Boarding', value: true).then((value){
               Navigator.pushAndRemoveUntil(
                   context,
                   MaterialPageRoute(
                     builder:(context) => LoginScreen(),
                   ),
                       (route) => false
               );
             });
            },
            child: Text(
              "SKIP",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w800,
                fontSize: 17,
              ),
            ),
          ),
        ],
        titleSpacing: 20,
        title: Text(
          "Shop App",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.italic,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: PageView.builder(
        onPageChanged: (value) {
          setState(() {
            if (value == bourding.length - 1) {
              // print(value);
              isLast = true;
            } else {
              // print(value);
              isLast = false;
            }
          });
        },
        itemBuilder: (context, index) =>
            buildingBoundingScreen(bourding[index], context, isLast),
        controller: pageController,
        itemCount: bourding.length,
      ),
    );
  }
}
