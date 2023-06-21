import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:login_register_methods/module/sign_up_screen/cubit/cubit.dart';
import 'package:login_register_methods/module/sign_up_screen/cubit/states.dart';
import 'package:login_register_methods/shared/components/components.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../shared/components/constants.dart';
import '../verification_screen.dart';

class Services {
  final String icon;
  final String job;
  bool? selected = false;

  Services({
    required this.icon,
    required this.job,
    this.selected,
  });
}

class TecSignUpScreen extends StatelessWidget {

  List<Services> serviceList = [
    Services(icon: "assets/images/carpentry.png", job: "Carpentry"),
    Services(icon: "assets/images/cleaning.png", job: "Cleaning"),
    Services(icon: "assets/images/electrician.png", job: "Electrician"),
    Services(icon: "assets/images/kitchen.png", job: "Kitchen"),
    Services(icon: "assets/images/plumbing.png", job: "Plumbing"),
    Services(icon: "assets/images/paint.png", job: "Painting"),
  ];

  bool value = false;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var rPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  TecSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    PageController serviceController = PageController();
    var cubit = SignupCubit.get(context);


    return BlocConsumer<SignupCubit, SignupStates>(
      listener: (context, state) {},
      builder: (context, state) {


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
                      /// Title text
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
                                text: "Technical ",
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

                      /// Caption text
                      Text(
                        "Create your account now and be a service provider",
                        style:
                        Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 18.0),
                      ),
                      SizedBox(
                        height: screenHeight * 0.04,
                      ),

                      /// Page indicator
                      SmoothPageIndicator(
                        controller: serviceController,
                        count: 2,
                        axisDirection: Axis.horizontal,
                        effect: const ExpandingDotsEffect(
                            dotColor: Colors.grey,
                            dotHeight: 8.0,
                            expansionFactor: 2.5,
                            dotWidth: 8.0,
                            spacing: 5.0,
                            activeDotColor: secondaryColor),
                      ),
                      SizedBox(
                        height: screenHeight * 0.04,
                      ),

                      /// Caption text
                      Text(
                        "Choose a service",
                        style:
                        Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 18.0),
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),

                      /// Choose service ListView
                      SizedBox(
                        height: 130,
                        child: ListView.separated(
                          itemCount: serviceList.length,
                          controller: serviceController,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) =>
                              servicesBuilder(serviceList[index], index, context),
                          separatorBuilder: (context, index) => const SizedBox(),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.02,
                      ),

                      /// TFFs
                      Container(
                        child: defaultTextFormField(
                          hintText: "Tech/Company Name",
                          keyboardType: TextInputType.name,
                          controller: nameController,
                          validator: (value) {
                            if(value!.isEmpty){
                              return "First Name must not be empty";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      Container(
                        child: defaultTextFormField(
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
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
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
                      Container(
                        child: defaultButton(
                          text: "Next",
                          onPress: () {
                            if(formKey.currentState!.validate() && cubit.isChecked){
                              Map<String, String> userInfo = {
                                'name' : nameController.text,
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

  Widget servicesBuilder(Services services, int index, context) => Padding(
        padding: const EdgeInsets.all(5.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(10.0),
          onTap: () {
            SignupCubit.get(context).selectedService(serviceList, index);
          },
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              if(serviceList[index].selected == true)
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(
                    TablerIcons.circle_check,
                    color: successColor,
                  ),
                ),
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: serviceList[index].selected == true? Colors.greenAccent.withOpacity(0.2) : null,
                  border: Border.all(
                    color: serviceList[index].selected == true? successColor : Colors.grey.shade300,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage(
                        services.icon,
                      ),
                      height: 60,
                      width: 60,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(services.job),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
