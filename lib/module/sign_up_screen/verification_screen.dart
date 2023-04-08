import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_register_methods/module/sign_up_screen/cubit/cubit.dart';
import 'package:login_register_methods/module/sign_up_screen/cubit/states.dart';
import 'package:login_register_methods/module/sign_up_screen/username_screen.dart';
import 'package:provider/provider.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';

class VerificationScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  var verificationController = TextEditingController();
  Map<String, String> userInfo;
  VerificationScreen(this.userInfo, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 22.0),
                      children: [
                        const TextSpan(
                          text: "We sent you a ",
                        ),
                        TextSpan(
                          text: "code",
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 22.0,
                              color: secondaryColor,
                              fontStyle: FontStyle.italic),
                        ),
                      ]),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Enter it below to verify +20${userInfo['phone']}",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 18.0),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  child: defaultTextFromField(
                    hintText: "Enter Verification Code",
                    controller: verificationController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if(value!.isEmpty){
                        return "Please enter the correct verification code";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Didn't receive code? click her to resend code",
                  ),
                ),
                const Spacer(),
                Container(
                  child: defaultButton(
                    text: "Next",
                    onPress: () {
                      if (formKey.currentState!.validate()) {
                        navigateAndPush(context, widget: Provider(
                          create: (context) => SignupCubit(),
                          builder: (context, child) => UsernameScreen(userInfo),
                        ),);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
