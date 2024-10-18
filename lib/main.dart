import 'package:flutter/material.dart';
import 'package:pariwisata/helpers/user_info.dart';
import 'package:pariwisata/ui/login_page.dart';
import 'package:pariwisata/ui/hargatiket_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = const CircularProgressIndicator();
  @override
  void initState() {
    super.initState();
    isLogin();
  }

  void isLogin() async {
    var token = await UserInfo().getToken();
    if (token != null) {
      setState(() {
        page = const HargaTiketPage();
      });
    } else {
      setState(() {
        page = const LoginPage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pariwisata',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey, // Use this to define your primary color
        scaffoldBackgroundColor: Colors.grey[900], // Set the background color
      ),
      home: page,
    );
  }
}
