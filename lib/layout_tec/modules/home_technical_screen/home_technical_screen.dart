import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:login_register_methods/shared/components/constants.dart';

import '../../../module/sign_in_screen/cubit/cubit.dart';

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
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
            shadowColor: Colors.black,
            child: Container(
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
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Accepted',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
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
              //For Progress Orders
              ListView.builder(
                itemCount: 12,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index){
                  return InkWell(
                    onTap: (){},
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(12),
                      margin: EdgeInsets.only(bottom: 16,left: 16, right: 16),
                      decoration: BoxDecoration(
                        color: SignInCubit.get(context).isDark
                            ? Color(0xff303030)
                            : Colors.white,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: SignInCubit.get(context).isDark
                                ? Colors.transparent
                                : Colors.black12,
                            blurRadius: 20.0,
                            offset: Offset(0.0, 0.75),
                          ),
                        ],
                        // color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                TablerIcons.category,
                                color: primaryColor,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                'model.serviceName!',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19.0,
                                ),
                              ),
                              Spacer(),
                              Text(
                                'model.date!',
                                // model.date!,
                                style: TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                TablerIcons.edit,
                                color: primaryColor,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                'model.notes!',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                              Spacer(),
                              Text(
                                'model.time!',
                                // model.time!,
                                style: TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),

                            ],
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(
                                TablerIcons.map_pin,
                                color: primaryColor,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: Text(
                                  'model.location!',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Spacer(),
                              Text(
                                'Status',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Icon(
                                TablerIcons.circle,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              //For Accepted Orders
              ListView.builder(
                itemCount: 12,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index){
                  return InkWell(
                    onTap: (){},
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(12),
                      margin: EdgeInsets.only(bottom: 16,left: 16, right: 16),
                      decoration: BoxDecoration(
                        color: SignInCubit.get(context).isDark
                            ? Color(0xff303030)
                            : Colors.white,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: SignInCubit.get(context).isDark
                                ? Colors.transparent
                                : Colors.black12,
                            blurRadius: 20.0,
                            offset: Offset(0.0, 0.75),
                          ),
                        ],
                        // color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                TablerIcons.category,
                                color: primaryColor,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                'model.serviceName!',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19.0,
                                ),
                              ),
                              Spacer(),
                              Text(
                                'model.date!',
                                // model.date!,
                                style: TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                TablerIcons.edit,
                                color: primaryColor,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                'model.notes!',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                              Spacer(),
                              Text(
                                'model.time!',
                                // model.time!,
                                style: TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),

                            ],
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(
                                TablerIcons.map_pin,
                                color: primaryColor,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: Text(
                                  'model.location!',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Spacer(),
                              Text(
                                'Status',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Icon(
                                TablerIcons.circle,
                                color: Colors.cyan,
                              ),
                            ],
                          ),
                        ],
                      ),
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





