
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:login_register_methods/layout_tec/cubit/cubit.dart';

import 'package:login_register_methods/layout_tec/cubit/states.dart';

import 'package:login_register_methods/module/profile_screen/profile_screen.dart';
import 'package:login_register_methods/module/sign_in_screen/cubit/states.dart';
import 'package:login_register_methods/shared/components/components.dart';
import 'package:login_register_methods/shared/components/constants.dart';

import '../../../module/onboarding_screen/onboarding_screen.dart';
import '../../../module/sign_in_screen/cubit/cubit.dart';



class DrawerTechnicalScreen extends StatelessWidget {
  const DrawerTechnicalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutTecCubit, LayoutTecStates>(
      listener: (context, state) {
        if (state is SignOutSuccessState) {
          navigatePushDelete(context, widget: OnBoardingScreen());
        }
      },
      builder: (context, state) {
        var cubit = LayoutTecCubit.get(context);
        return BlocConsumer<SignInCubit,SignInStates>(
          listener: (context, state) {

          },
          builder: (context, state) {
            return Drawer(
              width: MediaQuery.of(context).size.width * 0.9,
              backgroundColor:   SignInCubit.get(context).isDark ? Color(0xff303030) : scaffoldLightColor,  ///***********************
              child: Column(
                children: [
                  Container(
                    ///profile
                    color: SignInCubit.get(context).isDark ? Color(0xff212121) : primaryColor, ///********************
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 45, 15, 45),
                      child: InkWell(
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage:
                              NetworkImage('https://img.freepik.com/free-vector/self-care-concept_23-2148523717.jpg?w=740&t=st=1678538562~exp=1678539162~hmac=a7d5a1db32b0d9a70e2ebbf68ab260a7ff455a23edb61284689ea8c3559233dd'),
                              //cubit.originalUser!.profilePic!
                              radius: 35,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            // NAME AND LOCATION
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // PROFILE NAME
                                  Text(
                                    "Hi, ",
                                    //${cubit.originalUser!.profileName}
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: Colors.white),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  // LOCATION ICON AND LOCATION TEXT
                                  Text(
                                    'Not found',
                                    // cubit.originalUser!.address!,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: "Roboto",
                                      color: Colors.grey.shade400,
                                      fontSize: 13,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // NOTIFICATION ICON
                            const Icon(
                              TablerIcons.chevron_right,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        onTap: () {
                          navigateAndPush(context, widget: ProfileScreen());
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Dark Theme",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  SignInCubit.get(context).changeAppMode();
                                },
                                icon: Icon(Icons.brightness_4_outlined),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: Row(
                                children: [
                                  Icon(
                                    TablerIcons.message_dots,
                                    color: secondaryColor,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Text("Messages"),
                                  ),
                                  Icon(
                                    TablerIcons.chevron_right,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              print("message");
                            },
                          ),
                          InkWell(
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: Row(
                                children: [
                                  Icon(
                                    TablerIcons.map_2,
                                    color: secondaryColor,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Text("Address"),
                                  ),
                                  Icon(
                                    TablerIcons.chevron_right,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {},
                          ),
                          InkWell(
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: Row(
                                children: [
                                  Icon(
                                    TablerIcons.credit_card,
                                    color: secondaryColor,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Text("Payment"),
                                  ),
                                  Icon(
                                    TablerIcons.chevron_right,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {},
                          ),
                          InkWell(
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: Row(
                                children: [
                                  Icon(
                                    TablerIcons.notes,
                                    color: secondaryColor,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Text("Privacy and Terms"),
                                  ),
                                  Icon(
                                    TablerIcons.chevron_right,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {},
                          ),
                          InkWell(
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: Row(
                                children: [
                                  Icon(
                                    TablerIcons.info_circle,
                                    color: secondaryColor,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Text("About us"),
                                  ),
                                  Icon(
                                    TablerIcons.chevron_right,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {},
                          ),
                          InkWell(
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: Row(
                                children: [
                                  Icon(
                                    TablerIcons.phone,
                                    color: secondaryColor,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Text("Call Us"),
                                  ),
                                  Icon(
                                    TablerIcons.chevron_right,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {},
                          ),
                          InkWell(
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: Row(
                                children: [
                                  Icon(
                                    TablerIcons.language,
                                    color: secondaryColor,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Text("Languages"),
                                  ),
                                  Icon(
                                    TablerIcons.chevron_right,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {},
                          ),
                          const Spacer(),
                          InkWell(
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: Row(
                                children: [
                                  Icon(
                                    TablerIcons.logout,
                                    color: errorColor,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Text("Log Out"),
                                  ),
                                  Icon(
                                    TablerIcons.chevron_right,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              LayoutTecCubit.get(context).singOut();
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );

          },
        );
      },
    );
  }
}
