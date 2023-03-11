import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:login_register_methods/module/sign_up_screen/cubit/cubit.dart';
import 'package:login_register_methods/module/sign_up_screen/cubit/states.dart';
import 'package:login_register_methods/module/sign_up_screen/tec_sign_up_screen/tec_sign_up_screen.dart';
import 'package:login_register_methods/module/sign_up_screen/user_sign_up_screen/user_sign_up_screen.dart';
import 'package:login_register_methods/shared/components/components.dart';
import 'package:login_register_methods/shared/components/constants.dart';
import 'package:provider/provider.dart';

class AccountTypeModel {
  final IconData icon;
  final String text;

  AccountTypeModel({
    required this.icon,
    required this.text,
  });
}

class PreSignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: BlocConsumer<SignupCubit, SignupStates>(
        listener: (context, state) {},
        builder: (context, state) {

          List<AccountTypeModel> accountTypeList = [
            AccountTypeModel(icon: TablerIcons.user, text: "User"),
            AccountTypeModel(icon: TablerIcons.tool, text: "Technical"),
          ];
          var cubit = SignupCubit.get(context);

          return Scaffold(
            appBar: AppBar(),
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
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(fontSize: 15.0),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),

                  /// Choose User or Technical
                  Container(
                    height: MediaQuery.of(context).size.width * 0.43,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => buildAccountTypeCard(
                          accountTypeList[index], index, context),
                      separatorBuilder: (context, index) => SizedBox(
                        width: MediaQuery.of(context).size.width * 0.065,
                      ),
                      itemCount: SignupCubit.get(context).isSelected.length,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                  ),

                  /// Next Button
                  Container(
                    child: defaultButton(
                      text: "Next",
                      buttonColor: cubit.isSelected[0] == false &&
                              cubit.isSelected[1] == false
                          ? Colors.deepPurple.shade100
                          : primaryColor,
                      textColor: cubit.isSelected[0] == false &&
                              cubit.isSelected[1] == false
                          ? primaryColor
                          : Colors.white,
                      onPress: () {
                        if (cubit.isSelected[0] == true) {
                          navigateAndPush(
                            context,
                            widget: Provider(
                              create: (context) => SignupCubit(),
                              builder: (context, child) => UserSignUpScreen(),
                            ),
                          );
                        } else if (cubit.isSelected[1] == true) {
                          navigateAndPush(
                            context,
                            widget: Provider(
                              create: (context) => SignupCubit(),
                              builder: (context, child) => TecSignUpScreen(),
                            ),
                          );
                        } else {
                          print("Toast");
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),

                  /// Text and TextButton
                  Center(
                    child: Column(
                      children: [
                        const Text(
                          "Already have an account?",
                        ),
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
        },
      ),
    );
  }

  Widget buildAccountTypeCard(AccountTypeModel model, int index, context) =>
      InkWell(
        onTap: () {
          SignupCubit.get(context).changeSelected(index);
        },
        borderRadius: BorderRadius.circular(10.0),
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            if (SignupCubit.get(context).isSelected[index] == true)
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
                  color: SignupCubit.get(context).isSelected[index] == true
                      ? successColor
                      : Colors.grey.shade300,
                ),
                color: SignupCubit.get(context).isSelected[index] == true
                    ? Colors.greenAccent.withOpacity(0.2)
                    : Colors.grey.withOpacity(0.1),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    model.icon,
                    size: 50,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    model.text,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
