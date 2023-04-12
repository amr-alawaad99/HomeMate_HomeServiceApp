import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:login_register_methods/module/new_order_screen/new_order_cubit/new_order_cubit.dart';
import 'package:login_register_methods/module/new_order_screen/new_order_cubit/new_order_states.dart';

import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';

class NewOrderScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var dateController = TextEditingController();
  var timeController = TextEditingController();
  var locationController = TextEditingController();





  NewOrderScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>NewOrderCubit(),
      child:BlocConsumer<NewOrderCubit,NewOrderStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit = NewOrderCubit.get(context);
          return ColorfulSafeArea(
            color: primaryColor,
            child: Scaffold(
              bottomNavigationBar: SizedBox(
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      const SizedBox(width: 20),
                      Expanded(
                        child: defaultButton(
                          text: 'Send Request',
                          onPress: () {},
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
              body: NestedScrollView(
                floatHeaderSlivers: true,
                headerSliverBuilder: (context, innerBoxIsScrolled) => <Widget>[
                  const SliverAppBar(
                    floating: true,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(
                        'New Order',
                        style: TextStyle(color: Colors.white, fontFamily: "Roboto"),
                      ),
                    ),
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(15))),
                    automaticallyImplyLeading: true,
                    leadingWidth: 50,
                    iconTheme: IconThemeData(color: Colors.white),
                  ),
                ],
                body: Padding(
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

                                    borderRadius: BorderRadius.circular(10)),
                                padding: const EdgeInsets.all(2),
                                width: 100,
                                height: 100,
                                child: defaultCategoriesBox(
                                    onTap: () {
                                      cubit.changeIndex(index);
                                    },
                                    color: cubit.selectedIndex==index?secondaryColor:Colors.white,
                                    textColor: cubit.selectedIndex==index?Colors.white:Colors.black,
                                    elevation: cubit.selectedIndex==index?0:3,
                                    width: 50,
                                    height: 50,
                                    img: cubit.categories[index].img,
                                    text: cubit.categories[index].title),
                              ),
                              separatorBuilder: (context, index) => const SizedBox(
                                width: 8,
                              ),
                              itemCount: cubit.categories.length),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultTextFromField(
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'you must choose the day';
                              }
                              return null;
                            },
                            hintText: 'Choose Working Day',
                            prefixIcon: TablerIcons.calendar_event,
                            prefixIconColor: secondaryColor,
                            controller: dateController,
                            keyboardType: TextInputType.datetime,
                            onTapFunction: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2123),
                              ).then((value) {
                                dateController.text =
                                    DateFormat.yMMMEd().format(value!);
                              });
                            }),
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
                            hintText: 'Choose Working Time',
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
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      )
    );
  }
}
