import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:login_register_methods/layou_tec/layout_tec.dart';
import 'package:login_register_methods/layout/cubit/cubit.dart';
import 'package:login_register_methods/layout/cubit/states.dart';
import 'package:login_register_methods/layout/main_layout_screen.dart';
import 'package:login_register_methods/module/sign_in_screen/cubit/cubit.dart';
import 'package:login_register_methods/module/sign_in_screen/cubit/states.dart';
import 'package:login_register_methods/module/sign_in_screen/reset_password_screen.dart';
import 'package:login_register_methods/shared/components/components.dart';
import 'package:login_register_methods/shared/components/constants.dart';
import 'package:login_register_methods/shared/local/cache_helper.dart';

import '../../model/user_model.dart';
import '../sign_up_screen/google_facebook_signup_info.dart';

class SignInScreen extends StatelessWidget {
  bool value = false;
  final formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LayoutCubit,LayoutStates>(
      listener: (context, state) {
        if(state is GetUserDataSuccessState){
          if(state.isUser ){
            navigatePushDelete(context, widget: MainLayoutScreen());
          }else{
            navigatePushDelete(context, widget: LayoutTecScreen());
          }
        }
      },
      child: BlocConsumer<SignInCubit, SignInStates>(
        listener: (context, state) {

          if (state is LoginSuccessState) {
            CacheHelper.saveData(key: "uid", value: state.uid).then((value) {

                // navigatePushDelete(context, widget: MainLayoutScreen());


              //TO GET THE NEW LOGGED IN ACCOUNT IMMEDIATELY RATHER THAN THE PREVIOUS ACCOUNT!!
              LayoutCubit.get(context).originalUser = UserModel();
              LayoutCubit.get(context).getUserData();
            });
          } else if (state is UserAlreadyExistsState) {
            // navigateAndPush(context, widget: MainLayoutScreen());
            CacheHelper.saveData(key: "uid", value: state.uid).then((value) {
              // navigatePushDelete(context, widget: MainLayoutScreen());
              //TO GET THE NEW LOGGED IN ACCOUNT IMMEDIATELY RATHER THAN THE PREVIOUS ACCOUNT!!
              LayoutCubit.get(context).originalUser = UserModel();
              LayoutCubit.get(context).getUserData();
            });
          } else if (state is UserDoesNotExistsState) {
            navigateAndPush(context,
                widget: GoogleFacebookSignUpInfo(
                    SignInCubit.get(context).googleUser!.displayName!));
          } else if (state is LoginErrorState) {
            showToast(message: "Invalid Login info!", toastColor: errorColor);
          }
        },
        builder: (context, state) {
          double screenHeight = MediaQuery.of(context).size.height;
          var cubit = SignInCubit.get(context);

          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title Text
                        RichText(
                          text: TextSpan(
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontSize: 22.0),
                              children: [
                                const TextSpan(
                                  text: "To get started enter your ",
                                ),
                                TextSpan(
                                  text: "Email.",
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
                        SizedBox(
                          height: screenHeight * 0.02,
                        ),
                        // Caption Text
                        Text(
                          "Sign in and enjoy all the services of the application",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontSize: 18.0),
                        ),
                        SizedBox(
                          height: screenHeight * 0.05,
                        ),
                        // Email input
                        Container(
                          child: defaultTextFormField(
                            hintText: "Email",
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Email must not be empty";
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // Password input
                        Container(
                          child: defaultTextFormField(
                            hintText: "Password",
                            isSuffix: true,
                            suffixIcon: cubit.passSuffix,
                            isObscure: cubit.isInvisible,
                            suffixPressFunction: () {
                              cubit.changePasswordVisibility();
                            },
                            keyboardType: TextInputType.visiblePassword,
                            controller: passwordController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Password must not be empty";
                              }
                              return null;
                            },
                          ),
                        ),
                        // Forgot Password
                        TextButton(
                          onPressed: () {
                            navigateAndPush(context, widget: ResetPasswordScreen());
                          },
                          child: Text("Forgot your password?"),
                        ),
                        // Sign in button
                        Container(
                          child: defaultButton(
                            text: "Sign In",
                            onPress: () {
                              if (formKey.currentState!.validate()) {
                                CacheHelper.saveData(key: 'isUser', value: true);
                                cubit.userSignIn(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                          ),
                        ),
                        if (state is LoginLoadingState)
                          const SizedBox(
                            height: 5,
                          ),
                        if (state is LoginLoadingState)
                          const LinearProgressIndicator(
                            color: primaryColor,
                          ),
                        const SizedBox(
                          height: 20,
                        ),
                        //Google Facebook Sign in
                        Row(
                          children: [
                            Expanded(
                              child: defaultButton(
                                onPress: () async {
                                  await SignInCubit.get(context)
                                      .checkGoogleAccountExistence();
                                },
                                child: Icon(TablerIcons.brand_google, color: Colors.red, size: 30),
                                buttonColor: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 15.0,
                            ),
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
