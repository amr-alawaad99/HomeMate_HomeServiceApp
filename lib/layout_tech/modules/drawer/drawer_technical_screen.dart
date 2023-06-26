import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:login_register_methods/layout_tech/cubit/cubit.dart';
import 'package:login_register_methods/layout_tech/cubit/states.dart';
import 'package:login_register_methods/layout_tech/modules/messages_technical/chats_tech_screen.dart';
import 'package:login_register_methods/model_tech/chat_tech.dart';
import 'package:login_register_methods/module/sign_in_screen/cubit/states.dart';
import 'package:login_register_methods/shared/components/components.dart';
import 'package:login_register_methods/shared/components/constants.dart';
import '../../../module/onboarding_screen/onboarding_screen.dart';
import '../../../module/sign_in_screen/cubit/cubit.dart';
import '../profile_technical/profile_tech_screen.dart';



class DrawerTechnicalScreen extends StatefulWidget {


  const DrawerTechnicalScreen({Key? key}) : super(key: key);

  @override
  State<DrawerTechnicalScreen> createState() => _DrawerTechnicalScreenState();
}

class _DrawerTechnicalScreenState extends State<DrawerTechnicalScreen> {

  bool light = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutTechCubit, LayoutTechStates>(
      listener: (context, state) {
        if (state is SignOutSuccessState) {
          navigatePushDelete(context, widget: OnBoardingScreen());
        }
      },
      builder: (context, state) {
        var cubit = LayoutTechCubit.get(context);
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
                      padding: const EdgeInsets.fromLTRB(16, 35, 16, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage:
                                NetworkImage('https://img.freepik.com/free-vector/self-care-concept_23-2148523717.jpg?w=740&t=st=1678538562~exp=1678539162~hmac=a7d5a1db32b0d9a70e2ebbf68ab260a7ff455a23edb61284689ea8c3559233dd'),
                                //cubit.originalUser!.profilePic!
                                radius: 35,
                              ),
                              InkWell(
                                child: Icon(
                                  TablerIcons.chevron_left,
                                  color: Colors.white,
                                ),
                                onTap: (){
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Technical Name",
                                //${cubit.originalUser!.profileName}
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.white),
                              ),
                              const SizedBox(
                                height: 8,
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
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            child: Padding(
                              padding: EdgeInsets.only(top: 16),
                              child: Row(
                                children: [
                                  Icon(
                                    TablerIcons.moon_stars,
                                    color: secondaryColor,
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: Text("Dark Theme"),
                                  ),
                                  Switch(
                                    value: light,
                                    activeColor: primaryColor,
                                    thumbColor: const MaterialStatePropertyAll<Color>(Colors.white),
                                    activeTrackColor: primaryColor,
                                    inactiveTrackColor: Colors.grey,
                                    onChanged: (bool value){
                                      setState(() {
                                        light = value;
                                      });
                                    },

                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              //TODO :toggle between dark and light mode
                              print("toggled");
                            },
                          ),
                          Divider(),
                          InkWell(
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: Row(
                                children: [
                                  Icon(
                                    TablerIcons.user,
                                    color: secondaryColor,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Text("profile"),
                                  ),
                                  Icon(
                                    TablerIcons.chevron_right,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              print("profile");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context)=>  ProfileTechnicalScreen(),
                                  ),
                              );
                            },
                          ),
                          InkWell(
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
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
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (BuildContext context)=>  ChatsTechnicalScreen(
                              //         chat: chatData[0],
                              //         press: () {  },
                              //       ),
                              //     ),
                              // );
                            },
                          ),
                          InkWell(
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
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
                              padding: EdgeInsets.symmetric(vertical: 12),
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
                              padding: EdgeInsets.symmetric(vertical: 12),
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
                              padding: EdgeInsets.symmetric(vertical: 12),
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
                              padding: EdgeInsets.symmetric(vertical: 12),
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
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
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
                                  Spacer(),
                                  TextButton(
                                    child: Text(
                                      'العربية', //switch Arabic/ English
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.cyan[600]
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        //change name of language
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              showDialog(context: context, builder: (context){
                                return AlertDialog(
                                  title: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text(
                                        'Choose Language',
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  content: RadioListTileLanguage(),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, 'Cancel'),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, 'OK'),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              });
                            },
                          ),
                          const Spacer(),
                          Divider(),
                          InkWell(
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 16),
                              child: Row(
                                children: const [
                                  RotatedBox(
                                    quarterTurns: 2,
                                    child: Icon(
                                      TablerIcons.logout,
                                      color: errorColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "Log Out",
                                      style: TextStyle(
                                        color: errorColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              LayoutTechCubit.get(context).singOut();
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


enum SingingLanguage { ar, en }

class RadioListTileLanguage extends StatefulWidget {
  const RadioListTileLanguage({super.key});

  @override
  State<RadioListTileLanguage> createState() => _RadioListTileLanguageState();
}

class _RadioListTileLanguageState extends State<RadioListTileLanguage> {
  SingingLanguage? _character = SingingLanguage.ar;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          RadioListTile<SingingLanguage>(
            title: const Text('العربية'),
            value: SingingLanguage.ar,
            groupValue: _character,
            contentPadding: EdgeInsets.zero,
            onChanged: (SingingLanguage? value) {
              setState(() {
                _character = value;
              });
            },
          ),
          RadioListTile<SingingLanguage>(
            title: const Text('English'),
            value: SingingLanguage.en,
            groupValue: _character,
            contentPadding: EdgeInsets.zero,
            onChanged: (SingingLanguage? value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
