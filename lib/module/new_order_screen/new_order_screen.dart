import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:intl/intl.dart';

import '../../layout/cubit/cubit.dart';
import 'package:flutter/material.dart';

import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';

class NewOrderScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var dateController = TextEditingController();

  NewOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      color: primaryColor,
      child: Scaffold(
        key: scaffoldKey,
        extendBody: true,
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => <Widget>[
            const SliverAppBar(
                title: Text(
                  'New Order',
                  style: TextStyle(color: Colors.white, fontFamily: "Roboto"),
                ),
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(15))),
                automaticallyImplyLeading: true,
                leadingWidth: 50,
                iconTheme: IconThemeData(color: Colors.white),
                bottom: PreferredSize(
                    preferredSize: Size.fromHeight(20), child: SizedBox())),
          ],
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text('Select Service'),
                  const SizedBox(height: 15,),

                  defaultTextFromField(
                    validator: (String? value) {
                      if(value!.isEmpty){
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
                          dateController.text = DateFormat.yMMMEd().format(value!);

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
