import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_register_methods/module/sign_up_screen/cubit/cubit.dart';
import 'package:login_register_methods/module/sign_up_screen/cubit/states.dart';
import 'package:login_register_methods/shared/components/components.dart';
import 'package:login_register_methods/shared/components/constants.dart';

class UserSignUpScreen extends StatelessWidget {


  bool value = false;
  final formKey = GlobalKey<FormState>();
  var fNameController = TextEditingController();
  var lNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var rPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupStates>(
      listener: (context, state) {},
      builder: (context, state) {

        double screenHeight = MediaQuery.of(context).size.height;
        double screenWidth = MediaQuery.of(context).size.width;
        var cubit = SignupCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            foregroundColor: Colors.black,
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
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
                                text: "Creating ",
                              ),
                              TextSpan(
                                text: "User ",
                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 22.0,
                                    color: secondaryColor,
                                    fontStyle: FontStyle.italic),
                              ),
                              const TextSpan(
                                text: "account.",
                              ),
                            ]),
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),
                      Text(
                        "Create your account now to enjoy all the services of the application",
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontSize: 18.0),
                      ),
                      SizedBox(
                        height: screenHeight * 0.05,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: defaultTextFromField(
                              hintText: "First Name",
                              keyboardType: TextInputType.name,
                              controller: fNameController,
                              validator: (value) {
                                if(value!.isEmpty){
                                  return "First Name must not be empty";
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.02,
                          ),
                          Expanded(
                            child: defaultTextFromField(
                              hintText: "Lase Name",
                              keyboardType: TextInputType.name,
                              controller: lNameController,
                              validator: (value) {
                                if(value!.isEmpty){
                                  return "Last Name must not be empty";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      Container(
                        child: defaultTextFromField(
                          hintText: "Email",
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          validator: (value) {
                            if(value!.isEmpty){
                              return "Email must not be empty";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
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
                                  style: const TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 18.0,
                                  ),
                                  decoration: const InputDecoration(
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
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      Container(
                        child: defaultTextFromField(
                          hintText: "Create Password",
                          isSuffix: true,
                          suffixIcon: cubit.passSuffix,
                          isObscure: cubit.isInvisible,
                          suffixPressFunction: () {
                            cubit.changePasswordVisibility();
                          },
                          keyboardType: TextInputType.visiblePassword,
                          controller: passwordController,
                          validator: (value) {
                            if(value!.isEmpty){
                              return "Password must not be empty";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      Container(
                        child: defaultTextFromField(
                          hintText: "Repeat Password",
                          isSuffix: true,
                          suffixIcon: cubit.passSuffix,
                          isObscure: cubit.isInvisible,
                          suffixPressFunction: () {
                            cubit.changePasswordVisibility();
                          },
                          keyboardType: TextInputType.visiblePassword,
                          controller: rPasswordController,
                          validator: (value) {
                            if(value!.isEmpty){
                              return "Password must not be empty";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: value,
                            onChanged: (bool? value) {
                              ///////////////////////////////////////////////////////////
                                this.value = value!;

                            },
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                  text: "Do you agree to our ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(fontSize: 15.0),
                                  children: [
                                    TextSpan(
                                      text: "Privacy Policy and Terms.",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                          color: Colors.blue,
                                          fontSize: 15.0,
                                          decoration: TextDecoration.underline),
                                    ),
                                  ]),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * 0.03,
                      ),
                      Container(
                        child: defaultButton(
                          text: "Create account",
                          onPress: () {
                            if(formKey.currentState!.validate()){

                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
