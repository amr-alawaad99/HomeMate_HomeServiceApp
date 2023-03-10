import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:login_register_methods/layout/cubit/cubit.dart';
import 'package:login_register_methods/layout/cubit/states.dart';
import 'package:login_register_methods/shared/components/constants.dart';

class MainLayoutScreen extends StatelessWidget {
  const MainLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LayoutCubit(),
      child: BlocConsumer<LayoutCubit, LayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {

          return Scaffold(
            extendBody: true,
            appBar: AppBar(),
            body: LayoutCubit.get(context).screens[LayoutCubit.get(context).currentIndex],
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: Icon(TablerIcons.plus),
              backgroundColor: secondaryColor,
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
            bottomNavigationBar: BubbleBottomBar(
              opacity: 0.2,
              currentIndex: LayoutCubit.get(context).currentIndex,
              backgroundColor: Colors.white,
              hasInk: true,
              hasNotch: true,
              fabLocation: BubbleBottomBarFabLocation.end,
              items: [
                defaultBottomBarItem(context, "Home", TablerIcons.smart_home),
                defaultBottomBarItem(context, "Categories", TablerIcons.layout_grid),
                defaultBottomBarItem(context, "Suppliers", TablerIcons.users),
                defaultBottomBarItem(context, "Appointment", TablerIcons.clipboard,),
              ],
              onTap: (value) {
                LayoutCubit.get(context).changeBottomNav(value!);
              },
            ),
          );
        },
      ),
    );
  }



  BubbleBottomBarItem defaultBottomBarItem(context, String text, IconData icon) => BubbleBottomBarItem(
    backgroundColor: Colors.white,
    icon: Icon(icon, color: Colors.grey,),
    activeIcon: const Icon(null, size: 0,),
    title: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width*0.2,
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: primaryColor,
              fontSize: MediaQuery.of(context).size.width*0.04,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis
            ),
          ),
        ),
        const SizedBox(height: 3,),
        Container(
          width: 15,
          height: 3,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ],
    ),
  );



}
