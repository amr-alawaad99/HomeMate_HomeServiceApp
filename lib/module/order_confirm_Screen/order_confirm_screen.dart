import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_register_methods/layout/cubit/states.dart';
import 'package:login_register_methods/module/new_order_screen/new_order_screen.dart';
import 'package:login_register_methods/module/success_screen/success_screen.dart';

import '../../layout/cubit/cubit.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import 'dart:io';


class OrderConfirmScreen extends StatelessWidget {
  final String date;
  final String notes;
  final String time;
  final int services;
  final String location;
  final List<XFile> images;

  const OrderConfirmScreen(
      {super.key,
      required this.time,
      required this.date,
      required this.images,
      required this.notes,
      required this.location,
      required this.services});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => LayoutCubit(),
        child: BlocConsumer<LayoutCubit, LayoutStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = LayoutCubit.get(context);

            return Scaffold(
              backgroundColor: scaffoldLightColor,
              appBar: AppBar(
                iconTheme: const IconThemeData(color: Colors.white),
                title: const Text(
                  'Confirm Order Data',
                  style: TextStyle(color: Colors.white, fontFamily: "Roboto"),
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(15),
                  ),
                ),
                backgroundColor: primaryColor,
              ),
              bottomNavigationBar: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 20.0,
                        offset: Offset(0.0, 0.75)),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      10,
                    ),
                    topRight: Radius.circular(
                      10,
                    ),
                  ),
                ),
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: secondaryColor, shape: BoxShape.circle),
                          width: 13,
                          height: 13,
                        ),
                        Container(
                          color: secondaryColor,
                          width: 70,
                          height: 2,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: secondaryColor, shape: BoxShape.circle),
                          width: 13,
                          height: 13,
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    defaultButton(
                      width: MediaQuery.of(context).size.width / 2,
                      text: 'Confirm',
                      onPress: () {
                        LayoutCubit.get(context).uploadImage(images);
                        navigateAndPush(context, widget: SuccessScreen());

                      },
                      fontSize: 20,
                    ),
                  ],
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 150,
                        decoration: const BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              10.0,
                            ),
                          ),
                        ),
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Color(0xffd4f0f6),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        10.0,
                                      ),
                                    ),
                                  ),
                                  width: 110,
                                  height: 110,
                                ),
                                Image(
                                  image: cubit.categories[services].img,
                                  height: 80,
                                  width: 80,
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cubit.categories[services].title,
                                  style: TextStyle(
                                    color: scaffoldLightColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'If you need of homes,office,\napartment ...etc',
                                  style: TextStyle(
                                    color: scaffoldLightColor,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: double.infinity,
                        height: 100,
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Date And Time'.toUpperCase(),
                                  style: TextStyle(color: Colors.grey, fontSize: 15),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(date),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(time),
                              ],
                            ),
                            IconButton(
                              icon: Icon(
                                TablerIcons.edit,
                                color: primaryColor,
                              ),
                              onPressed: () {
                                navigatePushDelete(context, widget: NewOrderScreen());
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        height: 150,
                        width: double.infinity,
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Address'.toUpperCase(),
                                  style: TextStyle(color: Colors.grey, fontSize: 15),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text('Home Location'),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Icon(
                                      TablerIcons.map_pin,
                                      color: primaryColor,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width / 1.7,
                                      child: Text(
                                        location,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            IconButton(
                              icon: Icon(
                                TablerIcons.edit,
                                color: primaryColor,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        height: 150,
                        width: double.infinity,
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Notes'.toUpperCase(),
                                  style: TextStyle(color: Colors.grey, fontSize: 15),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(notes),
                                SizedBox(
                                  height: 10,
                                ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                //   mainAxisSize: MainAxisSize.max,
                                //   children: [
                                //     SizedBox(
                                //       width: MediaQuery.of(context).size.width / 1.7,
                                //       child: Text(
                                //         notes,
                                //         maxLines: 2,
                                //         overflow: TextOverflow.ellipsis,
                                //       ),
                                //     ),
                                //     SizedBox(
                                //       width: 10,
                                //     ),
                                //
                                //   ],
                                // ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width/2,
                                  height: 70,
                                  child: GridView.builder(
                                    itemCount: images.length,
                                    gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3),
                                    itemBuilder: (context, index) => Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.file(
                                          File(images[index].path),
                                          fit: BoxFit.cover,
                                          height: 50,
                                          width: 50,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              icon: Icon(
                                TablerIcons.edit,
                                color: primaryColor,
                              ),
                              onPressed: () {

                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));


  }
}
