import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:date_time_picker_widget/date_time_picker_widget.dart';

import 'package:flutter/material.dart';
import 'package:login_register_methods/module/new_order_screen/new_order_cubit/new_order_cubit.dart';
import 'package:login_register_methods/module/new_order_screen/new_order_cubit/new_order_states.dart';
import 'package:login_register_methods/module/order_confirm_Screen/order_confirm_screen.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';

class NewOrderScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var dateController = TextEditingController();
  var timeController = TextEditingController();
  var notesController = TextEditingController();
  var locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => NewOrderCubit(),
        child: BlocConsumer<NewOrderCubit, NewOrderStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = NewOrderCubit.get(context);
            return Scaffold(
              bottomNavigationBar: SizedBox(
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: defaultButton(
                          text: 'Send Request',
                          onPress: () {
                            navigateAndPush(
                              context,
                              widget: OrderConfirmScreen(),
                            );
                          },
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              backgroundColor: scaffoldLightColor,
              key: scaffoldKey,
              extendBody: true,
              appBar: AppBar(
                iconTheme: const IconThemeData(color: Colors.white),
                title: const Text(
                  'New Order',
                  style: TextStyle(color: Colors.white, fontFamily: "Roboto"),
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(15),
                  ),
                ),
                backgroundColor: primaryColor,
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
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
                                        },
                                        color: cubit.selectedIndex == index
                                            ? secondaryColor
                                            : Colors.white,
                                        textColor: cubit.selectedIndex == index
                                            ? Colors.white
                                            : Colors.black,
                                        elevation: cubit.selectedIndex == index
                                            ? 0
                                            : 3,
                                        width: 50,
                                        height: 50,
                                        img: cubit.categories[index].img,
                                        text: cubit.categories[index].title),
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
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 20.0,
                                offset: Offset(0.0, 0.75),
                              ),
                            ],
                          ),
                          child: DateTimePicker(
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
                        defaultTextFromField(
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
                        defaultTextFromField(
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

                        // Column(
                        //   children: [
                        //     defaultTextFromField(
                        //       suffixIcon: TablerIcons.camera,
                        //       suffixPressFunction: cubit.pickImage,
                        //       hintText: 'Notes',
                        //       controller: notesController,
                        //       keyboardType: TextInputType.text,
                        //     ),
                        //     Container(
                        //       padding: const EdgeInsets.all(20),
                        //       child: GridView.builder(
                        //         physics: const NeverScrollableScrollPhysics(),
                        //         scrollDirection: Axis.horizontal,
                        //         shrinkWrap: true,
                        //         itemCount: cubit.imageFileList!.length,
                        //         gridDelegate:
                        //             const SliverGridDelegateWithFixedCrossAxisCount(
                        //           crossAxisCount: 3,
                        //           crossAxisSpacing: 15,
                        //           mainAxisSpacing: 15,
                        //         ),
                        //         itemBuilder: (context, index) => Image.file(
                        //           File(
                        //             cubit.imageFileList![index].path,
                        //           ),
                        //           fit: BoxFit.cover,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
