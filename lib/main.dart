import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendors_app/app/home.dart';
import 'package:vendors_app/app/landing_page.dart';
import 'package:vendors_app/services/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      create: (context) => Auth(),
      child: MaterialApp(
        title: 'Vendors App',
        theme: ThemeData(
          fontFamily: 'Roboto',
          primarySwatch: petColor,
        ),
        home: LandingPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

Map<int, Color> colorPet = {
  50: Color(0x1A36A9CC),
  100: Color(0x3336A9CC),
  200: Color(0x4d36A9CC),
  300: Color(0x6636A9CC),
  400: Color(0x8036A9CC),
  500: Color(0xFF36A9CC),
  600: Color(0xFF36A9CC),
  700: Color(0xFF36A9CC),
  800: Color(0xFF36A9CC),
  900: Color(0xFF36A9CC),
};

Map<int, Color> colorMet = {
  50: Color(0x1AFF5352),
  100: Color(0x33FF5352),
  200: Color(0x4dFF5352),
  300: Color(0x66FF5352),
  400: Color(0x80FF5352),
  500: Color(0xFFFF5352),
  600: Color(0xFFFF5352),
  700: Color(0xFFFF5352),
  800: Color(0xFFFF5352),
  900: Color(0xFFFF5352),
};

MaterialColor petColor = MaterialColor(0xFF36A9CC, colorPet);
MaterialColor metColor = MaterialColor(0xFFFF5352, colorMet);
