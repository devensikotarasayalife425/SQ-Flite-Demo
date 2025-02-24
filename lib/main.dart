import 'package:flutter/material.dart';
<<<<<<< HEAD

import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home()
=======
import 'package:flutter_sqflite/shared_preference/shared_preference.dart';
import 'package:flutter_sqflite/to_do_list_services/Home.dart';

import 'Login_Services/login_screen.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});


  bool? isLogin = false;
  String email = "";
  checkLoginData()async{
    SharedPreferenceClass pref = SharedPreferenceClass();
    isLogin =await pref.getIsLogin() ?? false;
    email = await pref.getEmail() ?? "";
print("isLogin:$isLogin");
print("email:$email");
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("isLogin:$isLogin");
print("email:$email");
    checkLoginData();
    return MaterialApp(
      title: 'SqFlite Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:isLogin! == true ?  HomeView(email: email,) : const LoginView(),
>>>>>>> 2af1697 (Initial Commit)
    );
  }
}
