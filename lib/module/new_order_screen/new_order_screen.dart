import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:intl/intl.dart';
import 'package:date_time_picker_widget/date_time_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:login_register_methods/layout/cubit/cubit.dart';
import 'package:login_register_methods/layout/cubit/states.dart';
import 'package:login_register_methods/module/order_confirm_Screen/order_confirm_screen.dart';
import 'package:login_register_methods/module/sign_in_screen/cubit/cubit.dart';
import 'package:login_register_methods/module/sign_in_screen/cubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';

class NewOrderScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var dateController = TextEditingController();
  var timeController = TextEditingController();
  var notesController = TextEditingController();
  var locationController = TextEditingController();
  int serviceIndex = 0;

  NewOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    locationController.text = LayoutCubit.get(context).originalUser!.address!;
    return BlocProvider(
        create: (BuildContext context) => LayoutCubit(),
        child: BlocConsumer<LayoutCubit, LayoutStates>(
          listener: (context, state) {},
          builder: (context, state) {

            var cubit = LayoutCubit.get(context);

            return BlocConsumer<SignInCubit, SignInStates>(
              listener: (context, state) {},
              builder: (context, state) {
                return Scaffold(
                  bottomNavigationBar: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 20.0,
                            offset: Offset(0.0, 0.75)),
                      ],
                      color: SignInCubit.get(context).isDark
                          ? Color(0xff303030)
                          : scaffoldLightColor,
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
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 4,
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: secondaryColor,
                                    shape: BoxShape.circle),
                                width: 13,
                                height: 13,
                              ),
                              Container(
                                color: secondaryColor.withOpacity(0.2),
                                width: 60,
                                height: 2,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: secondaryColor.withOpacity(0.2),
                                    shape: BoxShape.circle),
                                width: 13,
                                height: 13,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        defaultButton(
                          buttonColor: SignInCubit.get(context).isDark
                              ? Color(0xff626262)
                              : primaryColor,
                          text: 'Send Request',
                          width: MediaQuery.of(context).size.width / 2,
                          onPress: () {
                            if (formKey.currentState!.validate()) {
                              navigateAndPush(
                                context,
                                widget: OrderConfirmScreen(
                                  services: serviceIndex,
                                  date: dateController.text,
                                  time: timeController.text,
                                  images: cubit.imageFileList!,
                                  notes: notesController.text,
                                  location: locationController.text,
                                ),
                              );
                            }
                          },
                          fontSize: 20,
                        ),
                      ],
                    ),
                  ),
                  backgroundColor: SignInCubit.get(context).isDark
                      ? Color(0xff212121)
                      : scaffoldLightColor,
                  key: scaffoldKey,
                  extendBody: true,
                  appBar: AppBar(
                    iconTheme: const IconThemeData(color: Colors.white),
                    title: const Text(
                      'New Order',
                      style:
                          TextStyle(color: Colors.white, fontFamily: "Roboto"),
                    ),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(15),
                      ),
                    ),
                    backgroundColor: SignInCubit.get(context).isDark
                        ? Color(0xff303030)
                        : primaryColor,
                  ),
                  body: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0, bottom: 90, right: 20, left: 20),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Select Service',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              height: 100,
                              child: ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) => Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        padding: const EdgeInsets.all(2),
                                        width: 100,
                                        height: 100,
                                        child: defaultCategoriesBox(
                                            onTap: () {
                                              cubit.changeIndex(index);
                                              serviceIndex = index;
                                            },
                                            color: cubit.selectedIndex == index
                                                ? SignInCubit.get(context)
                                                        .isDark
                                                    ? Colors.grey[500]
                                                    : secondaryColor
                                                : SignInCubit.get(context)
                                                        .isDark
                                                    ? dark2
                                                    : Colors.white,
                                            textColor:
                                                cubit.selectedIndex == index
                                                    ? Colors.white
                                                    : SignInCubit.get(context)
                                                            .isDark
                                                        ? Colors.white
                                                        : Colors.black,
                                            elevation:
                                                cubit.selectedIndex == index
                                                    ? 0
                                                    : 3,
                                            width: 50,
                                            height: 50,
                                            img: cubit.categories[index].img,
                                            text:
                                                cubit.categories[index].title),
                                      ),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                        width: 8,
                                      ),
                                  itemCount: cubit.categories.length),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: SignInCubit.get(context).isDark
                                    ? Color(0xff303030)
                                    : Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                boxShadow: const <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 20.0,
                                    offset: Offset(0.0, 0.75),
                                  ),
                                ],
                              ),
                              child: DateTimePicker(
                                customStringWeekdays: const [
                                  'Su',
                                  'Mo',
                                  'Tu',
                                  'We',
                                  'Th',
                                  'Fr',
                                  'Sa',
                                ],
                                datePickerTitle: 'Working Day',
                                startDate: DateTime.now(),
                                endDate: DateTime.tryParse('2030'),
                                initialSelectedDate: DateTime.now(),
                                type: DateTimePickerType.Date,
                                onDateChanged: (date) {
                                  dateController.text =
                                      DateFormat('dd MMM, yyyy').format(date);

                                  print(dateController.text);
                                },
                              ),
                            ),
                            // defaultTextFromField(
                            //     validator: (String? value) {
                            //       if (value!.isEmpty) {
                            //         return 'you must choose the day';
                            //       }
                            //       return null;
                            //     },
                            //     hintText: 'Choose Working Day',
                            //     prefixIcon: TablerIcons.calendar_event,
                            //     prefixIconColor: secondaryColor,
                            //     controller: dateController,
                            //     keyboardType: TextInputType.datetime,
                            //     onTapFunction: () {
                            //       showDatePicker(
                            //         context: context,
                            //         initialDate: DateTime.now(),
                            //         firstDate: DateTime.now(),
                            //         lastDate: DateTime(2123),
                            //       ).then((value) {
                            //         dateController.text =
                            //             DateFormat.yMMMEd().format(value!);
                            //       });
                            //     }),
                            const SizedBox(
                              height: 15,
                            ),
                            defaultTextFormField(
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'you must choose Time';
                                  }
                                  return null;
                                },
                                hintText: 'Choose Time',
                                prefixIconColor: secondaryColor,
                                prefixIcon: TablerIcons.clock,
                                controller: timeController,
                                keyboardType: TextInputType.datetime,
                                onTapFunction: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value) {
                                    timeController.text =
                                        value!.format(context).toString();
                                  });
                                }),

                            const SizedBox(
                              height: 15,
                            ),
                            defaultTextFormField(
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'you must enter location';
                                }
                                return null;
                              },
                              hintText: 'Location',
                              prefixIcon: TablerIcons.map_pin,
                              prefixIconColor: secondaryColor,
                              controller: locationController,
                              keyboardType: TextInputType.text,
                            ),
                            const SizedBox(
                              height: 15,
                            ),

                            Container(
                                decoration: BoxDecoration(
                                  color: SignInCubit.get(context).isDark
                                      ? Color(0xff303030)
                                      : Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 20.0,
                                      offset: Offset(
                                        0.0,
                                        0.75,
                                      ),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    defaultTextFormField(
                                      suffixIcon: TablerIcons.camera,
                                      suffixIconColor: secondaryColor,
                                      suffixPressFunction: () {
                                        cubit.selectImages();
                                      },
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'enter notes';
                                        }
                                        return null;
                                      },
                                      //     () {
                                      //
                                      //
                                      //   // showDialog(
                                      //   //   context: context,
                                      //   //   builder: (context) => ImagePickerScreen(),
                                      //   // );
                                      // },
                                      hintText: 'Notes',
                                      controller: notesController,
                                      keyboardType: TextInputType.text,
                                    ),
                                    cubit.imageFileList!.isNotEmpty
                                        ? Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 100,
                                              child: GridView.builder(
                                                itemCount:
                                                    cubit.imageFileList!.length,
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 4),
                                                itemBuilder: (context, index) =>
                                                    Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Stack(
                                                    fit: StackFit.expand,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child: Image.file(
                                                          File(cubit
                                                              .imageFileList![
                                                                  index]
                                                              .path),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      Positioned(
                                                        right: 0,
                                                        child: IconButton(
                                                          onPressed: () {
                                                            cubit.clearImage(
                                                                index);
                                                          },
                                                          icon: Container(
                                                            child: Icon(
                                                              TablerIcons.x,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : SizedBox(
                                            height: 120,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: FittedBox(
                                              alignment: Alignment.topCenter,
                                              child: Column(
                                                children: const [
                                                  Icon(
                                                    TablerIcons.photo,
                                                    color: Colors.grey,
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                  ],
                                )),

                            // Container(
                            //   decoration: const BoxDecoration(
                            //     color: Colors.white,
                            //     borderRadius:
                            //         BorderRadius.all(Radius.circular(10.0)),
                            //     boxShadow: <BoxShadow>[
                            //       BoxShadow(
                            //           color: Colors.black12,
                            //           blurRadius: 20.0,
                            //           offset: Offset(0.0, 0.75)),
                            //     ],
                            //   ),
                            //   width: double.infinity,
                            //   height: 120,
                            //   padding: const EdgeInsets.all(10),
                            //   child:
                            //   GridView.builder(
                            //     physics: const BouncingScrollPhysics(),
                            //     shrinkWrap: true,
                            //     itemCount: cubit.imageFileList!.length,
                            //     gridDelegate:
                            //         const SliverGridDelegateWithFixedCrossAxisCount(
                            //       crossAxisCount: 4,
                            //       crossAxisSpacing: 10,
                            //       mainAxisSpacing: 10,
                            //     ),
                            //     itemBuilder: (context, index) =>
                            //         ClipRRect(
                            //       borderRadius: BorderRadius.circular(10),
                            //       child: Image.file(
                            //         File(
                            //           cubit.imageFileList![index].path,
                            //         ),
                            //         fit: BoxFit.cover,
                            //       ),
                            //     ),
                            //
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}
