import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:task_managment_app/provider/auth_provider.dart';
import 'package:task_managment_app/provider/task_list_provider.dart';

import 'provider/bottomnav_provider.dart';
import 'provider/favourite_provider.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider()),
     ChangeNotifierProvider(create: (_)=>BottomNavProvider()),
      ChangeNotifierProvider(create: (_)=>FavoriteProvider()),
       ChangeNotifierProxyProvider<FavoriteProvider, Taskprovider>(
          create: (context) => Taskprovider(Provider.of<FavoriteProvider>(context, listen: false)),
          update: (context, favoriteProvider, todoProvider) => Taskprovider(favoriteProvider),
        ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false, home: SplashScreen());
        });
  }
}
