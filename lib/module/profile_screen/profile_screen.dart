import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:login_register_methods/shared/components/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
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
      body: Column(
        children: [
          //TOP BACKGROUND COLOR/AVATAR/AVATAR FRAME/EDIT BUTTON
          Stack(
            children: [
              // BACKGROUND
              Container(
                height: screenHeight * 0.2,
                decoration: const BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
                ),
              ),
              // AVATAR WHITE BORDER
              const Align(
                alignment: Alignment.bottomCenter,
                heightFactor: 1.69,
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white,
                ),
              ),
              // AVATAR
              Align(
                alignment: Alignment.bottomCenter,
                heightFactor: 1.8,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(tempImage),
                  radius: 55,
                ),
              ),
              // EDIT BUTTON
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Align(
                  alignment: Alignment.bottomRight,
                  heightFactor: 4.1,
                  child: ElevatedButton(
                    onPressed: () {},
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
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and Username
                  Align(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Rodaina Mohammed",),
                        const SizedBox(height: 10,),
                        Text(
                          "@Rodina",
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30,),
                  // Email
                  Text(
                    "Email",
                    style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 15),
                  ),
                  const SizedBox(height: 10,),
                  Row(children: [
                    //Icon
                    const Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Icon(TablerIcons.mail, color: secondaryColor,),
                    ),
                    const SizedBox(width: 10,),
                    //Text
                    Text(
                      "Rodina44@gmail.com",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 15),
                    ),
                  ],),
                  const SizedBox(height: 20,),
                  // Phone Number
                  Text(
                    "Phone Number",
                    style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 15),
                  ),
                  const SizedBox(height: 10,),
                  Row(children: [
                    //Icon
                    const Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Icon(TablerIcons.device_mobile, color: secondaryColor,),
                    ),
                    const SizedBox(width: 10,),
                    //Text
                    Text(
                      "+201034588124",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 15),
                    ),
                  ],),
                  const SizedBox(height: 20,),
                  // Location
                  Text(
                    "Location",
                    style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 15),
                  ),
                  const SizedBox(height: 10,),
                  Row(children: [
                    //Icon
                    const Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Icon(TablerIcons.map_pin, color: secondaryColor,),
                    ),
                    const SizedBox(width: 10,),
                    //Text
                    Text(
                      "Building 25, Al Tayaran Street, Nasr City",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 15),
                    ),
                  ],),
                  const SizedBox(height: 20,),
                  Container(
                    height: 130,
                    width: double.infinity,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 20,),
                  Align(
                    child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Change Password",
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: secondaryColor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
