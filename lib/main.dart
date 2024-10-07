import 'package:flutter/material.dart';
import 'package:forum_app/views/home.dart';
import 'package:forum_app/views/login_page.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final token = box.read('token');
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Forum App',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: false,
          textTheme: GoogleFonts.poppinsTextTheme(
            // Apply Poppins font to the entire app
            Theme.of(context).textTheme,
          )),
      home: token == null ? const LoginPage() : const HomePage(),
    );
  }
}
