import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:login_register_methods/layout/cubit/cubit.dart';
import 'package:login_register_methods/layout/cubit/states.dart';
import 'package:login_register_methods/module/drawer/my_drawer.dart';
import 'package:login_register_methods/module/new_order_screen/new_order_screen.dart';
import 'package:login_register_methods/module/sign_in_screen/cubit/cubit.dart';
import 'package:login_register_methods/shared/components/components.dart';
import 'package:login_register_methods/shared/components/constants.dart';

import '../module/sign_in_screen/cubit/states.dart';

class MainLayoutScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController searchController = TextEditingController();

  MainLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if(!FirebaseAuth.instance.currentUser!.emailVerified) {
          FirebaseAuth.instance.currentUser!.reload();
        }
        var cubit = LayoutCubit.get(context);
        return ColorfulSafeArea(
          color: primaryColor,
          child: Scaffold(
            key: scaffoldKey,
            drawer: const MyDrawer(),
            extendBody: true,
            body: ConditionalBuilder(
              condition: cubit.originalUser != null &&
                  cubit.originalUser!.profilePic != null,
              builder: (context) => NestedScrollView(
                floatHeaderSlivers: true,
                headerSliverBuilder: (context, innerBoxIsScrolled) => <Widget>[
                  BlocConsumer<SignInCubit, SignInStates>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return SliverAppBar(
                        backgroundColor: SignInCubit.get(context).isDark
                            ? Color(0xff303030)
                            : primaryColor,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(15))),
                        automaticallyImplyLeading: false,
                        flexibleSpace: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              15, 25, 15, 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  scaffoldKey.currentState!.openDrawer();
                                },
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      backgroundImage: NetworkImage(
                                          cubit.originalUser!.profilePic!),
                                      radius: 25,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    // NAME AND LOCATION
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // PROFILE NAME
                                          Text(
                                            "Hi, ${cubit.originalUser!.profileName!}",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontFamily: "Roboto",
                                              color: Colors.white,
                                              fontSize: 15.0,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 2,
                                          ),
                                          // LOCATION ICON AND LOCATION TEXT
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Icon(
                                                TablerIcons.map_pin,
                                                color: Colors.grey.shade400,
                                                size: 18,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  cubit.originalUser!.address!,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontFamily: "Roboto",
                                                    color: Colors.grey.shade400,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    // NOTIFICATION ICON
                                    IconButton(
                                      onPressed: () {
                                        print("N");
                                      },
                                      icon: const Icon(
                                        TablerIcons.bell,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (LayoutCubit.get(context).currentIndex == 0)
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      const Text(
                                        'What are you\nlooking for?',
                                        style: TextStyle(
                                          fontFamily: "Roboto",
                                          fontSize: 22.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          height: 1.5,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: SignInCubit.get(context).isDark
                                              ? Colors.grey[700]
                                              : scaffoldLightColor,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10.0)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: TextFormField(
                                            style: const TextStyle(
                                              fontFamily: "Roboto",
                                              fontSize: 16.0,
                                            ),
                                            controller: searchController,
                                            keyboardType: TextInputType.text,
                                            decoration: const InputDecoration(
                                              hintStyle: TextStyle(
                                                color: Colors.grey,
                                              ),
                                              hintText:
                                                  "Search for services or suppliers",
                                              border: InputBorder.none,
                                              prefixIcon: Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 5),
                                                child: Icon(TablerIcons.search),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              if (LayoutCubit.get(context).currentIndex == 1)
                                Column(
                                  children: [
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color:  SignInCubit.get(context).isDark
                                            ? Colors.grey[700]
                                            : scaffoldLightColor,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: TextFormField(
                                          style: const TextStyle(
                                            fontFamily: "Roboto",
                                            fontSize: 16.0,
                                          ),
                                          controller: searchController,
                                          keyboardType: TextInputType.text,
                                          decoration: const InputDecoration(
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                            ),
                                            hintText:
                                                "What service do you need",
                                            border: InputBorder.none,
                                            prefixIcon: Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 5),
                                              child: Icon(TablerIcons.search),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                        bottom: LayoutCubit.get(context).currentIndex == 0
                            ? const PreferredSize(
                                preferredSize: Size.fromHeight(210),
                                child: SizedBox())
                            : LayoutCubit.get(context).currentIndex == 1
                                ? const PreferredSize(
                                    preferredSize: Size.fromHeight(130),
                                    child: SizedBox())
                                : const PreferredSize(
                                    preferredSize: Size.fromHeight(50),
                                    child: SizedBox()),
                      );
                    },
                  ),
                ],
                body: Column(
                  children: [
                    if(!FirebaseAuth.instance.currentUser!.emailVerified)
                      Container(
                        color: Colors.yellow,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Icon(TablerIcons.alert_circle),
                            SizedBox(width: 10,),
                            Expanded(
                              child: Text(
                                "Your email is not verified! Please check your email address.",
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 56),
                          child: LayoutCubit.get(context)
                              .screens[LayoutCubit.get(context).currentIndex],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                navigateAndPush(context, widget: NewOrderScreen());
              },
              child: const Icon(
                TablerIcons.plus,
                color: Colors.white,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
            bottomNavigationBar: BubbleBottomBar(
              backgroundColor: SignInCubit.get(context).isDark
                  ? Color(0xff303030)
                  : Colors.white,
              opacity: 0.2,
              currentIndex: LayoutCubit.get(context).currentIndex,
              hasInk: true,
              hasNotch: true,
              fabLocation: BubbleBottomBarFabLocation.end,
              items: [
                defaultBottomBarItem(context, "Home", TablerIcons.smart_home),
                defaultBottomBarItem(
                    context, "Categories", TablerIcons.layout_grid),
                defaultBottomBarItem(
                  context,
                  "Suppliers",
                  TablerIcons.users,
                ),
                defaultBottomBarItem(
                  context,
                  "Appointment",
                  TablerIcons.clipboard,
                ),
              ],
              onTap: (value) {
                LayoutCubit.get(context).changeBottomNav(value!);
              },
            ),
          ),
        );
      },
    );
  }

  BubbleBottomBarItem defaultBottomBarItem(
          context, String text, IconData icon) =>
      BubbleBottomBarItem(
        backgroundColor: Colors.white,
        icon: Icon(
          icon,
          color: Colors.grey,
        ),
        activeIcon: const Icon(
          null,
          size: 0,
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: SignInCubit.get(context).isDark ? Colors.white : primaryColor,
                    fontSize: MediaQuery.of(context).size.width * 0.03,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Container(
              width: 15,
              height: 3,
              decoration: BoxDecoration(
                color:  SignInCubit.get(context).isDark ? Colors.white : primaryColor,
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ],
        ),
      );
}
