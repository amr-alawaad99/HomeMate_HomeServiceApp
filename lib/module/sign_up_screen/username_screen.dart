import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_register_methods/layout/main_layout_screen.dart';
import 'package:login_register_methods/module/sign_up_screen/cubit/cubit.dart';
import 'package:login_register_methods/module/sign_up_screen/cubit/states.dart';
import 'package:username_generator/username_generator.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/local/cache_helper.dart';

class UsernameScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  var usernameController = TextEditingController();
  Map<String, String> userinfo;

  UsernameScreen(this.userinfo, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupStates>(
      listener: (context, state) {
        if (state is CreateUserErrorState) {
          showToast(message: "Error! Can't Register!", toastColor: errorColor);
        }
        if (state is CreateUserSuccessState) {
          CacheHelper.saveData(key: 'uid', value: state.uid)
              .then((value) {
            navigatePushDelete(context, widget: MainLayoutScreen());
            //ChatAppCubit.get(context).getUserData();    //TO GET THE NEW LOGGED IN ACCOUNT IMMEDIATELY RATHER THAN THE PREVIOUS ACCOUNT!!
          });
        }
      },
      builder: (context, state) {

        var cubit = SignupCubit.get(context);

        usernameController.text = UsernameGenerator().generateForName(
          userinfo['firstName']!,
          lastName: userinfo['lastName']!,
          numberSeed: 999,
        );

        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //TITLE
                  RichText(
                    text: TextSpan(
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 22.0),
                        children: [
                          const TextSpan(
                            text: "What should we call ",
                          ),
                          TextSpan(
                            text: "you?",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontSize: 22.0,
                                    color: secondaryColor,
                                    fontStyle: FontStyle.italic),
                          ),
                        ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //CAPTION
                  Text(
                    "Your @username is unique. You can always change it later.",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(fontSize: 18.0),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  //USERNAME INPUT
                  Container(
                    child: defaultTextFromField(
                      hintText: "@username",
                      controller: usernameController,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "username can't be empty";
                        } else if(!RegExp(r'^[a-zA-Z0-9_-]{3,30}$').hasMatch(value)){
                          return "username must only contain letters, numbers, _, or -";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // Container(
                  //   height: 40,
                  //   child: ListView.separated(
                  //     shrinkWrap: true,
                  //     scrollDirection: Axis.horizontal,
                  //     physics: const NeverScrollableScrollPhysics(),
                  //     itemBuilder: (context, index) => buildValidUsernames(
                  //       context,
                  //       fName: userinfo['firstName']!,
                  //       lNAme: userinfo['lastName']!,
                  //       index: index,
                  //     ),
                  //     //Build what I want
                  //     separatorBuilder: (context, index) => const SizedBox(
                  //       width: 15,
                  //     ),
                  //     itemCount: 3,
                  //   ),
                  // ),
                  const Spacer(),
                  //CREATE ACCOUNT BUTTON
                  Container(
                    child: defaultButton(
                      text: "Create Account",
                      onPress: () async {
                        if (formKey.currentState!.validate()) {
                          await cubit.checkUsername(usernameController.text);
                          if(cubit.usernameExists == false){
                            SignupCubit.get(context).registerUserAccount(
                              email: userinfo['email']!,
                              password: userinfo['password']!,
                              fName: userinfo['firstName']!,
                              lName: userinfo['lastName']!,
                              userName: usernameController.text,
                              phoneNumber: userinfo['phone']!,
                            );
                          } else {
                            showToast(message: "username already exists", toastColor: errorColor);
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }


}
