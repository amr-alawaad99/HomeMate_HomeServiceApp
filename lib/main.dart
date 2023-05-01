import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_register_methods/layout/cubit/cubit.dart';
import 'package:login_register_methods/layout/main_layout_screen.dart';
import 'package:login_register_methods/module/onboarding_screen/onboarding_screen.dart';
import 'package:login_register_methods/module/sign_in_screen/cubit/cubit.dart';
import 'package:login_register_methods/module/sign_in_screen/cubit/states.dart';
import 'package:login_register_methods/shared/bloc_observer.dart';
import 'package:login_register_methods/shared/components/constants.dart';
import 'package:login_register_methods/shared/local/cache_helper.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();

  Bloc.observer = MyBlocObserver();

  uid = CacheHelper.getData(key: 'uid')?? '';
  print('uid is $uid');

  Widget widget;

  if (uid == '') {
    widget = OnBoardingScreen();
  } else {
    widget = MainLayoutScreen();
  }
  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  const MyApp(this.startWidget, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SignInCubit(),),
        BlocProvider(create: (context) => LayoutCubit()..getUserData(),),
      ],
      child: BlocConsumer<SignInCubit, SignInStates>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
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
          home: startWidget,
        ),
      ),
    );
  }
}