// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:login_register_methods/layou_tec/layout_tech.dart';
// import 'package:login_register_methods/layou_tec/layout_tech.dart';
// import 'package:login_register_methods/layou_tec/layout_tech.dart';
// import 'package:login_register_methods/layout/cubit/cubit.dart';
// import 'package:login_register_methods/layout/main_layout_screen.dart';
// import 'package:login_register_methods/module/new_order_screen/new_order_screen.dart';
// import 'package:login_register_methods/module/sign_in_screen/cubit/cubit.dart';
// import 'package:login_register_methods/module/sign_in_screen/cubit/states.dart';
// import 'package:login_register_methods/shared/components/components.dart';
// import 'package:login_register_methods/shared/components/constants_manager.dart';
// import 'package:login_register_methods/shared/local/cache_helper.dart';
//
// import '../../model/user_model.dart';
// import '../sign_up_screen/google_facebook_signup_info.dart';
//
// class SignInForTechnicalScreen extends StatelessWidget {
//   bool value = false;
//   final formKey = GlobalKey<FormState>();
//   var emailController = TextEditingController();
//   var passwordController = TextEditingController();
//
//   SignInForTechnicalScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => SignInCubit(),
//       child: BlocConsumer<SignInCubit, SignInStates>(
//         listener: (context, state) {
//           if (state is LoginSuccessState) {
//             CacheHelper.saveData(key: "uid", value: state.uid).then((value) {
//
//               navigatePushDelete(context, widget: LayoutTecScreen());
//
//
//               //TO GET THE NEW LOGGED IN ACCOUNT IMMEDIATELY RATHER THAN THE PREVIOUS ACCOUNT!!
//               LayoutCubit.get(context).originalUser = UserModel();
//               LayoutCubit.get(context).getUserData();
//             });
//           } else if (state is UserAlreadyExistsState) {
//             navigateAndPush(context, widget: LayoutTecScreen());
//             CacheHelper.saveData(key: "uid", value: state.uid).then((value) {
//               navigatePushDelete(context, widget: LayoutTecScreen());
//               //TO GET THE NEW LOGGED IN ACCOUNT IMMEDIATELY RATHER THAN THE PREVIOUS ACCOUNT!!
//               LayoutCubit.get(context).originalUser = UserModel();
//               LayoutCubit.get(context).getUserData();
//             });
//           } else if (state is UserDoesNotExistsState) {
//             navigateAndPush(context,
//                 widget: GoogleFacebookSignUpInfo(
//                     SignInCubit.get(context).googleUser!.displayName!));
//           } else if (state is LoginErrorState) {
//             showToast(message: "Invalid Login info!", toastColor: errorColor);
//           }
//         },
//         builder: (context, state) {
//           double screenHeight = MediaQuery.of(context).size.height;
//           var cubit = SignInCubit.get(context);
//
//           return Scaffold(
//             appBar: AppBar(),
//             body: Center(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.all(15.0),
//                   child: Form(
//                     key: formKey,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         RichText(
//                           text: TextSpan(
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .bodyMedium!
//                                   .copyWith(fontSize: 22.0),
//                               children: [
//                                 const TextSpan(
//                                   text: "To get started enter your ",
//                                 ),
//                                 TextSpan(
//                                   text: "Email.",
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .bodyMedium!
//                                       .copyWith(
//                                       fontSize: 22.0,
//                                       color: secondaryColor,
//                                       fontStyle: FontStyle.italic),
//                                 ),
//                               ]),
//                         ),
//                         SizedBox(
//                           height: screenHeight * 0.02,
//                         ),
//                         Text(
//                           "Sign in and enjoy all the services of the application",
//                           style: Theme.of(context)
//                               .textTheme
//                               .bodySmall!
//                               .copyWith(fontSize: 18.0),
//                         ),
//                         SizedBox(
//                           height: screenHeight * 0.05,
//                         ),
//                         Container(
//                           child: defaultTextFormField(
//                             hintText: "Email",
//                             keyboardType: TextInputType.emailAddress,
//                             controller: emailController,
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return "Email must not be empty";
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         Container(
//                           child: defaultTextFormField(
//                             hintText: "Password",
//                             isSuffix: true,
//                             suffixIcon: cubit.passSuffix,
//                             isObscure: cubit.isInvisible,
//                             suffixPressFunction: () {
//                               cubit.changePasswordVisibility();
//                             },
//                             keyboardType: TextInputType.visiblePassword,
//                             controller: passwordController,
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return "Password must not be empty";
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         Container(
//                           child: defaultButton(
//                             text: "Sign In",
//                             onPress: () {
//                               if (formKey.currentState!.validate()) {
//                                 CacheHelper.saveData(key: 'isUser', value: false);
//                                 cubit.technicalSignIn(
//                                     email: emailController.text,
//                                     password: passwordController.text
//                                 );
//                               }
//
//                             },
//                           ),
//                         ),
//                         if (state is LoginLoadingState)
//                           const SizedBox(
//                             height: 5,
//                           ),
//                         if (state is LoginLoadingState)
//                           const LinearProgressIndicator(
//                             color: primaryColor,
//                           ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         //Google Facebook Sign in
//                         // Row(
//                         //   children: [
//                         //     Expanded(
//                         //       child: defaultButton(
//                         //         onPress: () async {
//                         //           await SignInCubit.get(context)
//                         //               .checkGoogleAccountExistence();
//                         //         },
//                         //         text: "G",
//                         //         buttonColor: Colors.white,
//                         //         textColor: Colors.red.shade400,
//                         //         fontSize: 30.0,
//                         //       ),
//                         //     ),
//                         //     const SizedBox(
//                         //       width: 15.0,
//                         //     ),
//                         //     Expanded(
//                         //       child: defaultButton(
//                         //         onPress: () {},
//                         //         text: "f",
//                         //         buttonColor: Colors.white,
//                         //         textColor: Colors.blue.shade900,
//                         //         isBold: true,
//                         //         fontSize: 30.0,
//                         //       ),
//                         //     ),
//                         //   ],
//                         // ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
