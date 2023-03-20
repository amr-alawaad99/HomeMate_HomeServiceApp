import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:login_register_methods/layout/cubit/cubit.dart';
import 'package:login_register_methods/layout/cubit/states.dart';
import 'package:login_register_methods/module/drawer/my_drawer.dart';
import 'package:login_register_methods/module/new_order_screen/new_order_screen.dart';
import 'package:login_register_methods/shared/components/components.dart';
import 'package:login_register_methods/shared/components/constants.dart';

class MainLayoutScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var searchController = TextEditingController();

  MainLayoutScreen({super.key});

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
              drawer: const MyDrawer(),
              extendBody: true,
              body: NestedScrollView(
                floatHeaderSlivers: true,
                headerSliverBuilder: (context, innerBoxIsScrolled) => <Widget>[
                  SliverAppBar(
                    backgroundColor: primaryColor,
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(15))),
                    automaticallyImplyLeading: false,
                    flexibleSpace: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(15, 25, 15, 25),
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
                                  backgroundImage: tempImage,
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // PROFILE NAME
                                      const Text(
                                        "Hi, Rodina",
                                        style: TextStyle(
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
                                          Text(
                                            "Location should be, here!",
                                            style: TextStyle(
                                              fontFamily: "Roboto",
                                              color: Colors.grey.shade400,
                                              fontSize: 12,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                      color: scaffoldLightColor,
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
                                          prefixIcon:
                                              Padding(
                                                padding: EdgeInsets.only(bottom: 5),
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
                                    color: scaffoldLightColor,
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
                                        prefixIcon:
                                        Padding(
                                          padding: EdgeInsets.only(bottom: 5),
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
                  ),
                ],
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 56),
                    child: LayoutCubit.get(context)
                        .screens[LayoutCubit.get(context).currentIndex],
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  navigateAndPush(context, widget: NewOrderScreen());
                },
                backgroundColor: secondaryColor,
                child: const Icon(TablerIcons.plus),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endDocked,
              bottomNavigationBar: BubbleBottomBar(
                opacity: 0.2,
                currentIndex: LayoutCubit.get(context).currentIndex,
                backgroundColor: Colors.white,
                hasInk: true,
                hasNotch: true,
                fabLocation: BubbleBottomBarFabLocation.end,
                items: [
                  defaultBottomBarItem(context, "Home", TablerIcons.smart_home),
                  defaultBottomBarItem(
                      context, "Categories", TablerIcons.layout_grid),
                  defaultBottomBarItem(context, "Suppliers", TablerIcons.users),
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
      ),
    );
  }

  /*Stack(
  children: [
  /// Screen below the profile view
  SizedBox(height: MediaQuery.of(context).size.height * 0.10,),
  SingleChildScrollView(
  child: Padding(
  padding: const EdgeInsets.only(bottom: 56),
  child: LayoutCubit.get(context).screens[LayoutCubit.get(context).currentIndex],
  ),
  ),
  /// Main Profile View for all screens (also opens drawer on click)
  Container(
  height: MediaQuery.of(context).size.height * 0.12,
  decoration: const BoxDecoration(
  color: primaryColor,
  borderRadius: BorderRadius.vertical(bottom: Radius.circular(15.0)),
  ),
  child: Padding(
  padding: const EdgeInsetsDirectional.fromSTEB(15, 25, 25, 15),
  child: InkWell(
  onTap: () {
  scaffoldKey.currentState!.openDrawer();
  },
  child: Row(
  children: [
  // AVATAR
  CircleAvatar(
  backgroundImage: NetworkImage(tempImage),
  radius: 25,
  ),
  const SizedBox(width: 10,),
  // NAME AND LOCATION
  Expanded(
  child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
  // PROFILE NAME
  Text(
  "Hi, Rodina",
  style: TextStyle(
  fontFamily: "Roboto",
  color: Colors.white,
  fontSize: 15.0,
  ),
  ),
  const SizedBox(height: 2,),
  // LOCATION ICON AND LOCATION TEXT
  Row(
  crossAxisAlignment: CrossAxisAlignment.end,
  children: [
  Icon(
  TablerIcons.map_pin,
  color: Colors.grey.shade400,
  size: 18,
  ),
  const SizedBox(width: 5,),
  Text(
  "Location should be, here!",
  style: TextStyle(
  fontFamily: "Roboto",
  color: Colors.grey.shade400,
  fontSize: 12,
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
  ),
  ),
  ],
  )*/

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
            Container(
              width: MediaQuery.of(context).size.width * 0.2,
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: primaryColor,
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
                color: primaryColor,
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ],
        ),
      );
}
