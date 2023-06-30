import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:login_register_methods/layout/cubit/cubit.dart';

import '../../model/user_model.dart';
import '../../shared/components/constants.dart';

class TechnicalDetailsScreen extends StatelessWidget {
  final UserModel model;

  const TechnicalDetailsScreen({super.key, required this.model});
  @override
  Widget build(BuildContext context) {
    var cubit = LayoutCubit.get(context);
    return Scaffold(
      backgroundColor: scaffoldLightColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: Icon(TablerIcons.arrow_left),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Technical Details',
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Center(
                child: CircleAvatar(
                  radius: 92,
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage(model.profilePic!),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                model.profileName!,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontFamily: 'Roboto',

                ),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
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
                      model.email!,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 15),
                    ),
                  ),


                ],
              ),
            ),
            SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Icon(TablerIcons.home_cog, color: secondaryColor,),
                  ),
                  const SizedBox(width: 16),
                  //Text
                  Expanded(
                    child: Text(
                      model.serviceName!,

                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 15),
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    'Rating   ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    '??/5',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Icon(
                    Icons.star,
                    size: 20,
                    color: Colors.amber,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    'Reviews',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    'no. reviews',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Some Reviews',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  ListView.builder(
                    itemCount: 8,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, int index){
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 28,
                                backgroundImage: tempImage,
                                backgroundColor: Colors.grey,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'User Name',
                                  ),
                                  Text(
                                    'Review Messages \n more text here',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 16,

                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }
                  ),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
