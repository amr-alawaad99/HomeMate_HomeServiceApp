import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:login_register_methods/layout/main_layout_screen.dart';
import 'package:login_register_methods/module/pre_sign_up_screen/sign_up_screen.dart';
import 'package:login_register_methods/module/sign_in_screen/sign_in_screen.dart';
import 'package:login_register_methods/module/sign_up_screen/cubit/cubit.dart';
import 'package:login_register_methods/module/sign_up_screen/cubit/states.dart';
import 'package:login_register_methods/module/sign_up_screen/google_facebook_signup_info.dart';
import 'package:login_register_methods/shared/components/components.dart';
import 'package:login_register_methods/shared/components/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../layout/cubit/cubit.dart';
import '../../model/user_model.dart';
import '../../shared/local/cache_helper.dart';

class BoardingModel {
  final String highlightedText;
  final String text;
  final String image;

  BoardingModel({
    required this.highlightedText,
    required this.text,
    required this.image,
  });
}

class OnBoardingScreen extends StatelessWidget {
  final List<BoardingModel> boarding = [
    BoardingModel(
      highlightedText: "You have a breakdown ",
      text: "in electricity, plumbing, carpentry...etc.",
      image: "assets/images/onboarding1.jpg",
    ),
    BoardingModel(
      highlightedText: "Choose ",
      text: "the maintenance service you want and send the request",
      image: "assets/images/onboarding2.jpg",
    ),
    BoardingModel(
      highlightedText: "A maintenance technical ",
      text: "will come to you as soon as possible",
      image: "assets/images/onboarding3.jpg",
    ),
  ];
  final PageController boardingController = PageController();

  OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: BlocConsumer<SignupCubit, SignupStates>(
        listener: (context, state) {
          if(state is UserDoesNotExistsState){
            navigateAndPush(context, widget: GoogleFacebookSignUpInfo(SignupCubit.get(context).googleUser!.displayName!));
          } else if(state is UserAlreadyExistsState){
            navigateAndPush(context, widget: MainLayoutScreen());
            CacheHelper.saveData(key: "uid", value: state.uid).then((value) {
              navigatePushDelete(context, widget: MainLayoutScreen());
              //TO GET THE NEW LOGGED IN ACCOUNT IMMEDIATELY RATHER THAN THE PREVIOUS ACCOUNT!!
              LayoutCubit.get(context).originalUser = UserModel();
              LayoutCubit.get(context).getUserData();
            });
          }
        },
        builder: (context, state) {
          return ColorfulSafeArea(
            color: Colors.grey.shade100,
            child: Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),

                  /// PageView Builder for OnBoarding
                  Expanded(
                    child: PageView.builder(
                      itemBuilder: (context, index) =>
                          onBoardingItem(boarding[index], context),
                      controller: boardingController,
                      itemCount: boarding.length,
                    ),
                  ),

                  /// Page Indicator
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SmoothPageIndicator(
                      controller: boardingController,
                      count: boarding.length,
                      effect: const ExpandingDotsEffect(
                          dotColor: Colors.grey,
                          dotHeight: 8.0,
                          expansionFactor: 2.5,
                          dotWidth: 8.0,
                          spacing: 5.0,
                          activeDotColor: secondaryColor),
                    ),
                  ),

                  /// Signup, Google, Facebook, Text and Text buttons
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        // Sign up with Email and Password
                        Container(
                          child: defaultButton(
                            onPress: () {
                              navigateAndPush(context, widget: PreSignUpScreen());
                            },
                            text: "Sign Up",
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        // Sign in with Google and Facebook
                        Row(
                          children: [
                            // Google sign in
                            Expanded(
                              child: defaultButton(
                                onPress: () async {
                                  await SignupCubit.get(context).checkGoogleAccountExistence();
                                },
                                child: Icon(TablerIcons.brand_google, color: Colors.red, size: 30),
                                buttonColor: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 15.0,
                            ),
                            // Facebook sign in
                            Expanded(
                              child: defaultButton(
                                onPress: () {
                                  navigateAndPush(context, widget: comingSoonDialog());
                                },
                                child: Icon(TablerIcons.brand_facebook, color: Colors.blue.shade900, size: 30,),
                                buttonColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        // Already have an account? Sign In
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account?",
                            ),
                            TextButton(
                              onPressed: () {
                                navigateAndPush(context, widget: SignInScreen());
                              },
                              child: const Text(
                                "Sign In",
                                style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 18.0,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Login as a Guest
                        TextButton(
                          onPressed: () {
                            navigatePushDelete(context, widget: MainLayoutScreen());
                          },
                          child: const Text(
                            "Login as a Guest",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 18.0,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget onBoardingItem(BoardingModel model, context) =>
      Column(
        children: [
          //OnBoarding Text
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: model.highlightedText,
                      style: const TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 22.0,
                        color: secondaryColor,
                      ),
                      children: [
                        TextSpan(
                          text: model.text,
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 22.0,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          //OnBoarding Image
          Expanded(
            child: Image(
              image: AssetImage(model.image),
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
        ],
      );
}
