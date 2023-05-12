import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_register_methods/module/sign_up_screen/cubit/cubit.dart';
import 'package:login_register_methods/module/sign_up_screen/cubit/states.dart';
import 'package:login_register_methods/module/sign_up_screen/verification_screen.dart';
import 'package:login_register_methods/shared/components/components.dart';
import 'package:login_register_methods/shared/components/constants.dart';
import 'package:provider/provider.dart';

class UserSignUpScreen extends StatelessWidget {


  final formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
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
                      //TITLE
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
                      //CAPTION
                      Text(
                        "Create your account now to enjoy all the services of the application",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontSize: 18.0),
                      ),
                      SizedBox(
                        height: screenHeight * 0.05,
                      ),
                      //NAME INPUT
                      Container(
                        child: defaultTextFormField(
                          hintText: "Profile Name",
                          keyboardType: TextInputType.name,
                          controller: nameController,
                          maxLength: 50,
                          validator: (value) {
                            if(value!.isEmpty){
                              return "Profile Name must not be empty";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.02,
                      ),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      //EMAIL INPUT
                      Container(
                        child: defaultTextFormField(
                          hintText: "Email",
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          validator: (value) {
                            if(value!.isEmpty){
                              return "Email must not be empty";
                            } else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)){
                              return "not a valid email address";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.01,
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
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      //PASSWORD INPUT
                      Container(
                        child: defaultTextFormField(
                          hintText: "Create Password",
                          isSuffix: true,
                          suffixIcon: cubit.passSuffix,
                          isObscure: cubit.isInvisible,
                          suffixPressFunction: () {
                            cubit.changePasswordVisibility();
                          },
                          keyboardType: TextInputType.visiblePassword,
                          controller: passwordController,
                          maxLength: 30,
                          validator: (value) {
                            if(value!.isEmpty){
                              return "Password must not be empty";
                            } else if(value.length < 8){
                              return "Password must be at least 8 characters";
                            } else if(!RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,30}$').hasMatch(value)){
                              return "Password must have at least one uppercase letter,\none lowercase letter,\none digit,\none special character,"
                                  "\nminimum length of 8 characters,\nmaximum length of 30 characters";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      //RE-PASSWORD INPUT
                      Container(
                        child: defaultTextFormField(
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
                            } else if(rPasswordController.text != passwordController.text){
                              return "The passwords you entered do not match.";
                            } else if(value.length < 8){
                              return "Password must be at least 8 characters";
                            } else if(!RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,30}$').hasMatch(value)){
                              return "Password must have at least one uppercase letter,\none lowercase letter,\none digit,\none special character,"
                                  "\nminimum length of 8 characters,\nmaximum length of 30 characters";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      //CHECKBOX
                      Container(
                        decoration: BoxDecoration(
                          border: !cubit.isChecked & cubit.isClicked? Border.all(color: errorColor) : null,
                        ),
                        child: Row(
                          children: [
                            Checkbox(
                              value: cubit.isChecked,
                              onChanged: (value) {
                                cubit.toggleCheckbox();
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
                      ),
                      SizedBox(
                        height: screenHeight * 0.03,
                      ),
                      //NEXT BUTTON
                      Container(
                        child: defaultButton(
                          text: "Next",
                          onPress: () {
                            if(formKey.currentState!.validate() && cubit.isChecked){
                              Map<String, String> userInfo = {
                                'Name' : nameController.text,
                                'email' : emailController.text,
                                'phone' : phoneController.text,
                                'password' : passwordController.text,
                              };
                              navigateAndPush(context, widget: Provider(
                                create: (context) => SignupCubit(),
                                builder: (context, child) => VerificationScreen(userInfo),
                              ),);
                            } else if(!cubit.isClicked){
                              cubit.errorCheckBox();
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
