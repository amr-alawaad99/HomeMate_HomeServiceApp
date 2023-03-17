import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import 'package:flutter/material.dart';

import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';

class NewOrderScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var dateController = TextEditingController();

  NewOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit(),
      child: BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
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
                        style: TextStyle(
                            color: Colors.white, fontFamily: "Roboto"),
                      ),
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(15))),
                      automaticallyImplyLeading: true,
                      leadingWidth: 50,
                      iconTheme: IconThemeData(color: Colors.white),
                      bottom: PreferredSize(
                          preferredSize: Size.fromHeight(20),
                          child: SizedBox())),
                ],
                body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Select Service'),
                      SizedBox(
                        height: 125,
                        width: double.infinity,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: defaultCategoriesBox(
                                      text: 'Cleaning',
                                      img: 'assets/images/cleaning.png',
                                      width: 120,
                                      height: 120),
                                ),
                            separatorBuilder: (context, index) => SizedBox(
                                  width: 10,
                                ),
                            itemCount: 6),
                      ),
                      defaultTextFromField(
                          hintText: 'Choose Working Day',
                          controller: dateController,
                          keyboardType: TextInputType.datetime,
                          onTapFunction: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2123),
                            ).then((value) {
                              dateController.text = value.toString();
                            });
                          })
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
