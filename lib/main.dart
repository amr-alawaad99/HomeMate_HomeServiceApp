import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_register_methods/module/onboarding_screen/onboarding_screen.dart';
import 'package:login_register_methods/shared/bloc_observer.dart';
import 'package:login_register_methods/shared/components/constants.dart';

import 'layout/main_layout_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontSize: 18.0,
            fontFamily: "Roboto",
          ),
        ),
      ),
      home: OnBoardingScreen(),
    );
  }
}