import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:login_register_methods/module/sign_up_screen/tec_sign_up_screen/tec_sign_up_screen.dart';
import 'package:login_register_methods/module/sign_up_screen/user_sign_up_screen/user_sign_up_screen.dart';
import 'package:login_register_methods/shared/components/components.dart';
import 'package:login_register_methods/shared/components/constants.dart';


class SignUpScreen extends StatefulWidget {

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  List<bool> isSelected = List.generate(2, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// "Welcome to *App name* app."
            RichText(
              text: const TextSpan(
                  text: "Welcome to\n",
                  style: TextStyle(
                    fontFamily: "Roboto",
                    color: Colors.black,
                    fontSize: 25.0,
                  ),
                  children: [
                    TextSpan(
                        text: "HomeMate ",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                        children: [
                          TextSpan(
                              text: "app.",
                              style: TextStyle(
                                color: Colors.black,
                              )),
                        ]),
                  ]),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            /// "Start by creating an account."
            const Text(
              "Start by creating an account.",
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            /// Caption Text
            Text(
              "Choose your account type to complete the registration process.",
              style:
                  Theme.of(context).textTheme.caption!.copyWith(fontSize: 15.0),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.15,
            ),
            /// Choose User or Technical            ////////TO BE EDITED///////
            Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      isSelected[0] = true;
                      isSelected[1] = false;
                    });
                  },
                  borderRadius: BorderRadius.circular(10.0),
                  child: Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      if(isSelected[0] == true)
                        const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Icon(
                          TablerIcons.circle_check,
                          color: successColor,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.43,
                        height: MediaQuery.of(context).size.width * 0.43,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(
                            color: isSelected[0] == true? successColor : Colors.grey.shade300,
                          ),
                          color: isSelected[0] == true? Colors.greenAccent.withOpacity(0.2) : Colors.grey.withOpacity(0.1),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              TablerIcons.user,
                              size: 50,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 20.0,),
                            Text(
                              "User",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 15.0,),
                InkWell(
                  onTap: () {
                    setState(() {
                      isSelected[1] = true;
                      isSelected[0] = false;
                    });
                  },
                  borderRadius: BorderRadius.circular(10.0),
                  child: Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      if(isSelected[1] == true)
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(
                            TablerIcons.circle_check,
                            color: successColor,
                          ),
                        ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.43,
                        height: MediaQuery.of(context).size.width * 0.43,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(
                            color: isSelected[1] == true? successColor : Colors.grey.shade300,
                          ),
                          color: isSelected[1] == true? Colors.greenAccent.withOpacity(0.2) : Colors.grey.withOpacity(0.1),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              TablerIcons.tool,
                              size: 50,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 20.0,),
                            Text(
                              "Technical",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08,
            ),
            /// Next Button
            Container(
              child: defaultButton(
                text: "Next",
                buttonColor: isSelected[0] == false && isSelected[1] == false? Colors.deepPurple.shade100 : primaryColor,
                textColor: isSelected[0] == false && isSelected[1] == false? primaryColor : Colors.white,
                onPress: () {
                  if(isSelected[0] == true){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UserSignUpScreen(),));
                  } else if(isSelected[1] == true){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TecSignUpScreen(),));
                  } else {
                    print("Toast");
                  }
                },
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,
            ),
            /// Text and TextButton
            Center(
              child: Column(
                children: [
                  const Text("Already have an account?",),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Sign In",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 18.0,
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

}
