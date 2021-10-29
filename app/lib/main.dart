import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) async {

    runApp(
      MaterialApp(
        title: 'PaySmart',
        initialRoute: '/home',
        debugShowCheckedModeBanner: false,
        routes: {
          '/home': (context) => Home(),
        }
      )
    );
  });
}