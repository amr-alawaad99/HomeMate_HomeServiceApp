import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:login_register_methods/shared/components/constants.dart';

class HomeTechnicalScreen extends StatefulWidget {
  const HomeTechnicalScreen({super.key});

  @override
  State<HomeTechnicalScreen> createState() => _HomeTechnicalScreenState();
}

class _HomeTechnicalScreenState extends State<HomeTechnicalScreen> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState(){
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    // tabController.addListener(() {
    //   setState(() {
    //
    //   });
    // });
  }

  @override
  void dispose(){
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
          shadowColor: Colors.black,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TabBar(
              controller: tabController,
              labelPadding: EdgeInsets.symmetric(horizontal: 30),
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: primaryColor,
              ),
              tabs:  const [
                Tab(
                  child: Text(
                    'Progress',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Tab(
                  child: Text(
                    'Accepted',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          height: 600, //this size is important
          child: TabBarView(
            controller: tabController,
            children: [
              ListView.builder(
                itemCount: 12,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index){
                  return Container(
                    height: 80,
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 16, right: 16, bottom: 8),
                    padding: EdgeInsets.symmetric(horizontal: 8,vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Row(
                          children: [
                            Text(
                              'Client Name',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '10:0 AM : 2:30 PM',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Text(
                              'location',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                fontSize: 16,
                              ),
                            ),
                            Spacer(),
                            Text(
                              'Status',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Icon(
                              TablerIcons.circle,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              ListView.builder(
                itemCount: 12,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index){
                  return Container(
                    height: 80,
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 16, right: 16, bottom: 8),
                    padding: EdgeInsets.symmetric(horizontal: 8,vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Row(
                          children: [
                            Text(
                              'Client Name',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '10:0 AM : 2:30 PM',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Text(
                              'location',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                fontSize: 16,
                              ),
                            ),
                            Spacer(),
                            Text(
                              'Status',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Icon(
                              TablerIcons.circle,
                              color: Colors.cyanAccent,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

}





