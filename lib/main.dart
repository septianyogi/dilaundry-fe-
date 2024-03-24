// ignore_for_file: prefer_const_constructors

import 'package:d_view/d_view.dart';
import 'package:dilaundry/config/app_colors.dart';
import 'package:dilaundry/config/app_session.dart';
import 'package:dilaundry/pages/auth/login_page.dart';
import 'package:dilaundry/pages/auth/register_page.dart';
import 'package:dilaundry/pages/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(ProviderScope(
    child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.light(
          primary: AppColors.primary,
          secondary: Colors.greenAccent[400]!,
        ),
        textTheme: GoogleFonts.latoTextTheme(),
        elevatedButtonTheme:  ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll(AppColors.primary),
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            padding: const MaterialStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 16, vertical:14),
            ),
            textStyle: MaterialStatePropertyAll(
              TextStyle(fontSize: 15),
            ),
          ),
        ),
      ),
      home: FutureBuilder(
        future: AppSession.getUser(), 
        builder: (context, snapshot) {
          if (snapshot.data==null) {
            return const LoginPage();
          }
          return const DashboardPage();
        },
      ),
    );
  }
}
