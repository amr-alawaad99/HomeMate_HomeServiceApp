import 'package:flutter/material.dart';
import '../../../shared/components/constants.dart';

class NotificationsTechnicalScreen extends StatelessWidget {
  const NotificationsTechnicalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        foregroundColor: Colors.white,

        title: Text(
          "Notifications",
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  "Today",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: 3,
                shrinkWrap: true,
                itemBuilder: (context, int index){
                  return Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:  [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          child: CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 24,
                            backgroundImage: NetworkImage(
                              'https://www.lifewire.com/thmb/YBQuRMKxxhx3Zb3uJ1x-QOT6VsM=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Maplocation_-5a492a4e482c52003601ea25.jpg',
                            ),
                          ),
                        ),
                        Container(
                          height: 56,
                          width: size.width * 0.75,
                          margin: EdgeInsets.only(left: 8, bottom: 8, top: 8),
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
                                      fontSize: 16,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    '45m ago',
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
                                    'distance (23 Km)',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(
                height: 24,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  "Earlier",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              ListView.builder(
                itemCount: 11,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, int index){
                  return Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:  [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          child: CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 24,
                            backgroundImage: NetworkImage(
                              'https://www.lifewire.com/thmb/YBQuRMKxxhx3Zb3uJ1x-QOT6VsM=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Maplocation_-5a492a4e482c52003601ea25.jpg',
                            ),
                          ),
                        ),
                        Container(
                          height: 56,
                          width: size.width * 0.75,
                          margin: EdgeInsets.only(left: 8, bottom: 8, top: 8),
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
                                      fontSize: 16,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    '45m ago',
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
                                    'distance (23 Km)',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}


