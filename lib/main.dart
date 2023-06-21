import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_register_methods/layout/cubit/cubit.dart';
import 'package:login_register_methods/layout/main_layout_screen.dart';
import 'package:login_register_methods/module/google_maps_widget/app_data.dart';
import 'package:login_register_methods/module/onboarding_screen/onboarding_screen.dart';
import 'package:login_register_methods/module/sign_in_screen/cubit/cubit.dart';
import 'package:login_register_methods/module/sign_in_screen/cubit/states.dart';
import 'package:login_register_methods/shared/bloc_observer.dart';
import 'package:login_register_methods/shared/components/constants.dart';
import 'package:login_register_methods/shared/local/cache_helper.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();

  bool isDark = CacheHelper.getData(key: 'isDark') ?? false;

  Bloc.observer = MyBlocObserver();


  uId = CacheHelper.getData(key: 'uid') ?? '';
  print('uid is $uId');

  Widget widget;

  if (uId == '') {
    widget = OnBoardingScreen();
  } else {
    widget = MainLayoutScreen();
  }
  runApp(MyApp(widget, isDark,));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  final bool isDark;

  const MyApp(this.startWidget, this.isDark, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
          SignInCubit()
            ..changeAppMode(
              fromShared: isDark,
            )

        ),
        BlocProvider(
          create: (context) =>
          LayoutCubit()
            ..getUserData(),
        ),
        ChangeNotifierProvider(
          create: (context) => AppData(),
        ),
      ],
      child: BlocConsumer<SignInCubit, SignInStates>(
          listener: (context, state) {

          },
          builder: (context, state) {
            print('isDark is $isDark');
            SystemChrome.setSystemUIOverlayStyle(
              SystemUiOverlayStyle(
                statusBarColor: SignInCubit
                    .get(context)
                    .isDark ? Colors.black : primaryColor,
                //color set to purple or set your own color
              ),
            );
            return MaterialApp(
              debugShowCheckedModeBanner: false,
            
              // TO BE EDITED!!
              theme: ThemeData(
                colorScheme: ColorScheme.light(),
                appBarTheme: AppBarTheme(
                  backgroundColor: scaffoldLightColor,
                  elevation: 0,
                  foregroundColor: Colors.black,
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: primaryColor,
                  ),
                ),
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: secondaryColor,
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  backgroundColor: Colors.white,
                ),
                scaffoldBackgroundColor: scaffoldLightColor,
                textTheme: const TextTheme(
                  bodyMedium: TextStyle(
                    fontSize: 18.0,
                    fontFamily: "Roboto",
                  ),
                ),
              ),


              darkTheme: ThemeData(
                colorScheme: ColorScheme.dark(),
                scaffoldBackgroundColor: dark1,
                appBarTheme: AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.black,
                  ),
                ),
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: dark2,
                ),
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  backgroundColor: dark1,
                  selectedItemColor: Colors.white,
                ),
              ),
              themeMode: SignInCubit
                  .get(context)
                  .isDark ? ThemeMode.dark : ThemeMode.light,
              home: startWidget,
            );
          }
      ),
    );
  }
}
