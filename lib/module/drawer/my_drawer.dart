import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:login_register_methods/module/onboarding_screen/onboarding_screen.dart';
import 'package:login_register_methods/module/profile_screen/profile_screen.dart';
import 'package:login_register_methods/shared/components/components.dart';
import 'package:login_register_methods/shared/components/constants.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.9,
      backgroundColor: scaffoldLightColor,
      child: Column(
        children: [
          Container(
            color: primaryColor,
            height: MediaQuery.of(context).size.height * 0.2,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 45, 15, 45),
              child: InkWell(
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(tempImage),
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
                            "Hi, Rodina",
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // LOCATION ICON AND LOCATION TEXT
                          Text(
                            "Location, Should be, Here!",
                            maxLines: 2,
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
                  navigateAndPush(context, widget: const ProfileScreen());
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
                        child: Text("Dark Theme",
                        style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      CupertinoSwitch(
                        value: true,
                        activeColor: secondaryColor,
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        children: const [
                          Icon(
                            TablerIcons.message_dots,
                            color: secondaryColor,
                          ),
                          SizedBox(width: 15,),
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        children: const [
                          Icon(
                            TablerIcons.map_2,
                            color: secondaryColor,
                          ),
                          SizedBox(width: 15,),
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        children: const [
                          Icon(
                            TablerIcons.credit_card,
                            color: secondaryColor,
                          ),
                          SizedBox(width: 15,),
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        children: const [
                          Icon(
                            TablerIcons.notes,
                            color: secondaryColor,
                          ),
                          SizedBox(width: 15,),
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        children: const [
                          Icon(
                            TablerIcons.info_circle,
                            color: secondaryColor,
                          ),
                          SizedBox(width: 15,),
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        children: const [
                          Icon(
                            TablerIcons.phone,
                            color: secondaryColor,
                          ),
                          SizedBox(width: 15,),
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        children: const [
                          Icon(
                            TablerIcons.language,
                            color: secondaryColor,
                          ),
                          SizedBox(width: 15,),
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        children: const [
                          Icon(
                            TablerIcons.logout,
                            color: errorColor,
                          ),
                          SizedBox(width: 15,),
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
                      navigatePushDelete(context, widget: OnBoardingScreen());
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
