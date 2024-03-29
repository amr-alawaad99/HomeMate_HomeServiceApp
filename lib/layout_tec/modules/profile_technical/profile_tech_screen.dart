
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import 'package:login_register_methods/shared/components/components.dart';
import 'package:login_register_methods/shared/components/constants.dart';

import '../../../layout/cubit/cubit.dart';
import '../../../module/google_maps_widget/google_maps_widget.dart';

import 'edit_profile_tech_screen.dart';


class ProfileTechnicalScreen extends StatelessWidget {
  const ProfileTechnicalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = LayoutCubit.get(context);


    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
        ),
        backgroundColor: primaryColor,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //TOP BACKGROUND COLOR/AVATAR/AVATAR FRAME/EDIT BUTTON
            Stack(
              children: [
                // BACKGROUND
                Container(
                  height: size.height * 0.17,
                  decoration: const BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
                  ),
                ),
                // AVATAR AND WHITE BORDER
                Align(
                  alignment: Alignment.bottomCenter,
                  heightFactor: 1.6,
                  child: SizedBox(
                    width: 150,
                    height: 130,
                    child: Stack(
                      alignment: Alignment.center,
                      children:  [
                        // AVATAR WHITE BORDER
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.white,
                        ),
                        // AVATAR
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: tempImage,
                          radius: 55,
                        ),
                      ],
                    ),
                  ),
                ),
                // EDIT BUTTON
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    heightFactor: 3.5,
                    child: ElevatedButton(
                      onPressed: () {
                        navigateAndPush(context, widget: EditProfileTechnicalScreen());
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(10),
                        backgroundColor: secondaryColor, // <-- Button color
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // THE CONTENT OF THE PAGE
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name and Username
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "${cubit.originalUser!.profileName}",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 30,),
                    // Email
                    // Text(
                    //   "Email",
                    //   style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 15),
                    // ),
                    // const SizedBox(height: 10,),
                    Row(
                      children: [
                        //Icon
                        const Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Icon(TablerIcons.user, color: secondaryColor,),
                        ),
                        const SizedBox(width: 10,),
                        //Text
                        Text(
                          "@${cubit.originalUser!.username}",
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 15),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                      //Icon
                      const Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Icon(TablerIcons.mail, color: secondaryColor,),
                      ),
                      const SizedBox(width: 16),
                      //Text
                      Expanded(
                        child: Text(
                          cubit.originalUser!.email!,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 15),
                        ),
                      ),

                      // Verification check Icon
                      if(FirebaseAuth.instance.currentUser!.emailVerified)
                        Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: IconButton(
                            onPressed: () {
                              navigateAndPush(context,
                                widget: Dialog(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Your email is verified"),
                                  ),
                                ),
                              );
                            },
                            icon: Icon(TablerIcons.circle_check, color: successColor,),
                          ),
                        ),
                      if(!FirebaseAuth.instance.currentUser!.emailVerified)
                        Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: IconButton(
                            onPressed: () {
                              navigateAndPush(context, widget: Dialog(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Icon(TablerIcons.alert_circle, color: errorColor,),
                                        SizedBox(width: 10,),
                                        Text("Your email is not verified!"),
                                      ],
                                    ),
                                    TextButton(onPressed: () async {
                                      try {
                                        await FirebaseAuth.instance.currentUser!.sendEmailVerification();
                                        showToast(message: "Verification link sent\nCheck your email", toastColor: successColor);
                                      } on FirebaseAuthException catch (e) {
                                        showToast(message: e.message.toString(), toastColor: errorColor);
                                      }
                                    }, child: Text("resend verification link"),),
                                  ],
                                ),
                              ));
                            },
                            icon: Icon(TablerIcons.alert_circle, color: errorColor,),
                          ),
                        ),

                      ],
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      children: [
                        //Icon
                        const Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Icon(TablerIcons.home_cog, color: secondaryColor,),
                        ),
                        const SizedBox(width: 16),
                        //Text
                        Expanded(
                          child: Text(
                            cubit.originalUser!.serviceName!,

                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 15),
                          ),
                        ),



                      ],
                    ),
                    const SizedBox(height: 20,),
                    // Phone Number
                    // Text(
                    //   "Phone Number",
                    //   style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 15),
                    // ),
                    // const SizedBox(height: 10,),
                    Row(
                      children: [
                        //Icon
                        const Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Icon(TablerIcons.device_mobile, color: secondaryColor,),
                        ),
                        const SizedBox(width: 10,),
                        //Text
                        Expanded(
                          child: Text(
                            "+2 0${cubit.originalUser!.phoneNumber}",
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 15),
                          ),
                        ),
                        // Verification check Icon
                        if(FirebaseAuth.instance.currentUser!.emailVerified)
                          Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: IconButton(
                              onPressed: () {
                                navigateAndPush(context,
                                  widget: Dialog(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Your email is verified"),
                                    ),
                                  ),
                                );
                              },
                              icon: Icon(TablerIcons.circle_check, color: successColor,),
                            ),
                          ),
                        if(!FirebaseAuth.instance.currentUser!.emailVerified)
                          Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: IconButton(
                              onPressed: () {
                                navigateAndPush(context, widget: Dialog(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(height: 10,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: const [
                                          Icon(TablerIcons.alert_circle, color: errorColor,),
                                          SizedBox(width: 10,),
                                          Text("Your email is not verified!"),
                                        ],
                                      ),
                                      TextButton(onPressed: () async {
                                        try {
                                          await FirebaseAuth.instance.currentUser!.sendEmailVerification();
                                          showToast(message: "Verification link sent\nCheck your email", toastColor: successColor);
                                        } on FirebaseAuthException catch (e) {
                                          showToast(message: e.message.toString(), toastColor: errorColor);
                                        }
                                      }, child: Text("resend verification link"),),
                                    ],
                                  ),
                                ));
                              },
                              icon: Icon(TablerIcons.alert_circle, color: errorColor,),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    // Address
                    // Text(
                    //   "Address",
                    //   style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 15),
                    // ),
                    // const SizedBox(height: 10,),
                    Row(
                      children: [
                        //Icon
                        const Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Icon(TablerIcons.map_pin, color: secondaryColor,),
                        ),
                        const SizedBox(width: 10,),
                        //Text
                        Expanded(
                          child: Text(
                            cubit.originalUser!.address!,

                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    // Map
                    Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.red)),
                      child: GoogleMapsWidget(isEdit: false,),
                    ),
                    SizedBox(
                      height: 50,
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
