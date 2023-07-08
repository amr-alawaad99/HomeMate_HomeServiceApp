import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:login_register_methods/shared/components/components.dart';

import '../../shared/resources/constants_manager.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    Future passwordReset() async {
      /// Password reset
      try{
        await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
        if (!context.mounted) return; // for good coding :)
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            content: Text("Password reset link sent! Check your email."),
          );
        },
        );
      } on FirebaseAuthException catch (e){
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            content: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Icon(TablerIcons.alert_triangle),
                ),
                SizedBox(width: 10,),
                Expanded(child: Text(e.message.toString())),
              ],
            ),
          );
        },
        );
      }
    }

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Title
            RichText(
              text: TextSpan(
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 22.0),
                  children: [
                    const TextSpan(
                      text: "Enter your ",
                    ),
                    TextSpan(
                      text: "Email ",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(
                          fontSize: 22.0,
                          color: secondaryColor,
                          fontStyle: FontStyle.italic),
                    ),
                    TextSpan(
                      text: " and we will send you a password reset link.",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 22.0),
                    ),
                  ]),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            // Email input
            Container(
              child: defaultTextFormField(
                hintText: "Email",
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            SizedBox(height: 20,),
            Container(
              child: defaultButton(
                onPress: () {
                  passwordReset();
                },
                text: "Reset Password",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
