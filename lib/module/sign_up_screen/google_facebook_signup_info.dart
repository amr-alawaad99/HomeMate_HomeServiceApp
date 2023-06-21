import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_register_methods/layout/main_layout_screen.dart';
import 'package:login_register_methods/module/sign_up_screen/cubit/cubit.dart';
import 'package:login_register_methods/module/sign_up_screen/cubit/states.dart';
import 'package:username_generator/username_generator.dart';

import '../../layout/cubit/cubit.dart';
import '../../model/user_model.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/local/cache_helper.dart';

class GoogleFacebookSignUpInfo extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  var usernameController = TextEditingController();
  var phoneController = TextEditingController();
  String? userName;

  GoogleFacebookSignUpInfo(this.userName ,{super.key});


  @override
  Widget build(BuildContext context) {

    ///Generate a random username
    usernameController.text = UsernameGenerator().generateForName(
      userName!,
      numberSeed: 999,
    );

    return BlocProvider(
      create: (context) => SignupCubit(),
      child: BlocConsumer<SignupCubit, SignupStates>(
        listener: (context, state) {
          if (state is CreateUserErrorState) {
            showToast(message: "Error! Can't Register!", toastColor: errorColor);
          }
          if (state is CreateUserSuccessState) {
            CacheHelper.saveData(key: "uid", value: state.uid).then((value) {
              navigatePushDelete(context, widget: MainLayoutScreen());
              //TO GET THE NEW LOGGED IN ACCOUNT IMMEDIATELY RATHER THAN THE PREVIOUS ACCOUNT!!
              LayoutCubit.get(context).originalUser = UserModel();
              LayoutCubit.get(context).getUserData();
            });
          }
        },
        builder: (context, state) {

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
                      child: defaultTextFormField(
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
                    //PHONE NUMBER INPUT
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 20.0,
                              offset: Offset(0.0, 0.75)),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            const Text("+20"),
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                              child: Container(
                                height: 40,
                                color: Colors.grey,
                                width: 1,
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                maxLength: 10,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(10), // Apply a formatter to limit the length
                                ],
                                style: const TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 18.0,
                                ),
                                decoration: const InputDecoration(
                                  counterText: '', //To Hide MaxLength
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  hintText: "Phone Number",
                                  border: InputBorder.none,
                                ),
                                controller: phoneController,
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if(value!.isEmpty){
                                    return "Phone Number must not be empty";
                                  } else if(!RegExp(r'^1[0-9]{9}$').hasMatch(value)){
                                    return "invalid phone number";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    //CREATE ACCOUNT BUTTON
                    Container(
                      child: defaultButton(
                        text: "Create Account",
                        onPress: () async {
                          if (formKey.currentState!.validate()) {
                            await SignupCubit.get(context).checkUsername(usernameController.text);
                            if(SignupCubit.get(context).usernameExists == false) {
                              SignupCubit.get(context).googleSignUp(userName: usernameController.text, phoneNumber: phoneController.text);
                            } else if(state is UsernameCheckingErrorState) {
                              showToast(message: "Error!", toastColor: errorColor);
                            } else {
                              showToast(message: "username already exists", toastColor: errorColor);
                            }
                          }
                        },
                      ),
                    ),
                    if(state is CreateUserLoadingState)
                      const SizedBox(height: 5,),
                    if(state is CreateUserLoadingState)
                      const LinearProgressIndicator(color: primaryColor,),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }


}
