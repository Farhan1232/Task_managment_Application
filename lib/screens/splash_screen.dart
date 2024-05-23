import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import 'package:task_managment_app/screens/Authentication/login_screen.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    
    Timer(Duration(seconds: 5), () {
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           
           LottieBuilder.network('https://lottie.host/92a80836-7754-49b2-b236-44c92c2de054/Q7YitDU9DN.json',height: 100.h,width: MediaQuery.of(context).size.width,),
           SizedBox(height: 10.h),
            Text(
              'Task Managment App',
              style: TextStyle(
                fontSize: 27.sp,
                fontWeight: FontWeight.bold,
                color: Colors.amberAccent
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}




