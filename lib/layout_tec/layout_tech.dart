


import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../layout/cubit/cubit.dart';
import '../layout/cubit/states.dart';
import '../module/sign_in_screen/cubit/cubit.dart';
import '../module/sign_in_screen/cubit/states.dart';
import '../shared/components/constants.dart';
import 'modules/drawer/drawer_technical_screen.dart';
import 'modules/notifications_tech/notifications_tech_screen.dart';

class LayoutTecScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var searchController = TextEditingController();
  LayoutTecScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = LayoutCubit.get(context);
    return BlocConsumer<LayoutCubit,LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ColorfulSafeArea(
          color: primaryColor,
          child: Scaffold(
            key: scaffoldKey,
            drawer: const DrawerTechnicalScreen(),
            extendBody: true,
            body: ConditionalBuilder(
              condition: cubit.originalUser != null && cubit.originalUser!.profilePic != null,
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
                                bottom: Radius.circular(15)
                            )
                        ),
                        automaticallyImplyLeading: false,
                        flexibleSpace: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(15, 20, 15, 20),
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
                                          'https://img.freepik.com/free-vector/self-care-concept_23-2148523717.jpg?w=740&t=st=1678538562~exp=1678539162~hmac=a7d5a1db32b0d9a70e2ebbf68ab260a7ff455a23edb61284689ea8c3559233dd'
                                        // cubit.originalUser!.profilePic!
                                      ),
                                      radius: 25,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    // NAME AND LOCATION
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          // PROFILE NAME
                                          Text(
                                            "Hi, ",
                                            //${cubit.originalUser!.profileName!}
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
                                                  'not found',
                                                  // cubit.originalUser!.address!,
                                                  overflow: TextOverflow.ellipsis,
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
                                      icon: const Icon(
                                        TablerIcons.bell,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        print("N");
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder:(context)=> NotificationsTechnicalScreen()
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              if (LayoutCubit.get(context).currentIndex == 0)
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 2),
                                  child: Container(
                                    margin: EdgeInsets.symmetric(vertical: 16),
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
                                          "Search for Orders ",
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
                                ),
                            ],
                          ),
                        ),
                        bottom: LayoutCubit.get(context).currentIndex == 0
                            ? const PreferredSize(
                            preferredSize: Size.fromHeight(135),
                            child: SizedBox())
                            : LayoutCubit.get(context).currentIndex == 1
                            ? const PreferredSize(
                            preferredSize: Size.fromHeight(50),
                            child: SizedBox())
                            : const PreferredSize(
                            preferredSize: Size.fromHeight(50),
                            child: SizedBox()),
                      );
                    },
                  ),
                ],
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 56),
                    child: LayoutCubit.get(context)
                        .tecScreens[LayoutCubit.get(context).currentIndex],
                  ),
                ),
              ),
              fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
            ),

            bottomNavigationBar: BubbleBottomBar(
              backgroundColor: SignInCubit.get(context).isDark
                ? Color(0xff303030)
                : Colors.white,
              opacity: 0.2,
              currentIndex: LayoutCubit.get(context).currentIndex,
              hasInk: true,
              hasNotch: false,
              items: [
                defaultBottomBarItem(context, "Home", TablerIcons.smart_home),
                defaultBottomBarItem(context, "Orders", TablerIcons.list),
                defaultBottomBarItem(context, "History", TablerIcons.history),
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
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Container(
              width: 20,
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

