
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:login_register_methods/layout/cubit/cubit.dart';

import '../../model/user_model.dart';
import '../../shared/components/constants.dart';
import '../sign_in_screen/cubit/cubit.dart';

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
            Center(
              child: Text(
                "@${model.username!}",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 15,
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
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Icon(TablerIcons.device_mobile, color: secondaryColor,),
                  ),
                  const SizedBox(width: 16),
                  //Text
                  Expanded(
                    child: Text(
                      "+20${model.phoneNumber!}",

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
                    child: Icon(TablerIcons.map_pin, color: secondaryColor,),
                  ),
                  const SizedBox(width: 16),
                  //Text
                  Expanded(
                    child: Text(
                      model.address!,

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
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Icon(TablerIcons.star, color: secondaryColor,),
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
                    'Ratings and Reviews',
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
                        return Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: SignInCubit.get(context).isDark
                                    ? Color(0xff303030)
                                    : Colors.white,
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: SignInCubit.get(context).isDark
                                        ? Colors.transparent
                                        : Colors.black12,
                                    blurRadius: 20.0,
                                    offset: Offset(0.0, 0.75),
                                  ),
                                ],
                                // color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0)),
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),

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
                                Spacer(),
                                Row(
                                  children: const [Icon(Icons.star,color: Colors.amber,),Text('??/5')],
                                ),
                              ],
                            ),
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
