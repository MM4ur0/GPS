import 'package:flutter/material.dart';
import 'package:widget_login_geolocalizacion/screens/home.dart';
import 'package:widget_login_geolocalizacion/screens/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _routes = {
    '/': (context) => const Login(),
    '/home': (context) => const Home(title: "Home"),
    //'/show': (context) => const MapScreen(),
  };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Color.fromARGB(255, 255, 251, 24),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: _routes,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (context) => const Login());
      },
    );
  }
}
