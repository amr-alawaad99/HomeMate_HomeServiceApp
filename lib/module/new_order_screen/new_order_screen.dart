import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

import '../../models/category_model.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';

class NewOrderScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var dateController = TextEditingController();
  var timeController = TextEditingController();
  var locationController = TextEditingController();

  List<Categories> categories = [
    Categories(
      title: 'Cleaning',
      img: AssetImage('assets/images/cleaning.png'),
    ),
    Categories(
      title: 'Kitchen',
      img: AssetImage('assets/images/kitchen.png'),
    ),
    Categories(
      title: 'Plumbing',
      img: AssetImage('assets/images/plumbing.png'),
    ),
    Categories(
      title: 'Paint',
      img: AssetImage('assets/images/paint.png'),
    ),
    Categories(
      title: 'Carpentry',
      img: AssetImage('assets/images/carpentry.png'),
    ),
    Categories(
      title: 'Electricity',
      img: AssetImage('assets/images/electrician.png'),
    )
  ];

  NewOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      color: primaryColor,
      child: Scaffold(
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
                                onTap: (){},
                                  elevation: 3,
                                  width: 50,
                                  height: 50,
                                  img: categories[index].img,
                                  text: categories[index].title),
                            ),
                        separatorBuilder: (context, index) => const SizedBox(
                              width: 8,
                            ),
                        itemCount: categories.length),
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
                          timeController.text = value!.format(context).toString();
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
  }
}
