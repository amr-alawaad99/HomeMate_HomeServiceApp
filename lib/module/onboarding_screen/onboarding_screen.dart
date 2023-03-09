import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:login_register_methods/module/sign_up_screen/sign_up_screen.dart';
import 'package:login_register_methods/shared/components/components.dart';
import 'package:login_register_methods/shared/components/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
    return ColorfulSafeArea(
      color: Colors.white,
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
                  Container(
                    child: defaultButton(
                      onPress: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpScreen(),
                            ));
                      },
                      text: "Sign Up",
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: defaultButton(
                          onPress: () {},
                          text: "G",
                          buttonColor: Colors.white,
                          textColor: Colors.red.shade400,
                          fontSize: 30.0,
                        ),
                      ),
                      const SizedBox(
                        width: 15.0,
                      ),
                      Expanded(
                        child: defaultButton(
                          onPress: () {},
                          text: "f",
                          buttonColor: Colors.white,
                          textColor: Colors.blue.shade900,
                          isBold: true,
                          fontSize: 30.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                      ),
                      TextButton(
                        onPressed: () {},
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
                  TextButton(
                    onPressed: () {},
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
  }

  Widget onBoardingItem(BoardingModel model, context) => Column(
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
