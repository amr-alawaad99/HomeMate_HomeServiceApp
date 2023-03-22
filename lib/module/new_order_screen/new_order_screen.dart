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
    return
    ColorfulSafeArea(
      color: primaryColor,
      child: Scaffold(
        key: scaffoldKey,
        extendBody: true,
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => <Widget>[
            const SliverAppBar(
              floating: false,
              expandedHeight: 50,
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
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Select Service'),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                      height: 100,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => SizedBox(
                            width: 150,
                            height: 150,
                            child: defaultCategoriesBox(
                                img: categories[index].img,
                                text: categories[index].title),
                          ),
                          separatorBuilder: (context, index) => const SizedBox(
                                width: 10,
                              ),
                          itemCount: categories.length)),

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
                      prefixIcon: TablerIcons.clock,
                      controller: timeController,
                      keyboardType: TextInputType.datetime,
                      onTapFunction: () {
                        showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        ).then((value) {
                          dateController.text = value.toString();
                        });
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
