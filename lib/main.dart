import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_register_methods/module/onboarding_screen/onboarding_screen.dart';
import 'package:login_register_methods/shared/bloc_observer.dart';
import 'package:login_register_methods/shared/components/constants.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
      // TO BE EDITED!!
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: scaffoldLightColor,
          elevation: 0,
          foregroundColor: Colors.black,
        ),
        scaffoldBackgroundColor: scaffoldLightColor,
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