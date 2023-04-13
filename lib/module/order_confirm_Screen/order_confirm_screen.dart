import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../shared/components/constants.dart';

class OrderConfirmScreen extends StatelessWidget {
  OrderConfirmScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldLightColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Confirm Order Data',
          style: TextStyle(color: Colors.white, fontFamily: "Roboto"),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 150,
                decoration: const BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      10.0,
                    ),
                  ),
                ),
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Color(0xffd4f0f6),
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                10.0,
                              ),
                            ),
                          ),
                          width: 110,
                          height: 110,
                        ),
                        Image(
                          image: AssetImage('assets/images/cleaning.png'),
                          height: 80,
                          width: 80,
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cleaning',
                          style: TextStyle(
                            color: scaffoldLightColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'If you need of homes,office,\napartment ...etc',
                          style: TextStyle(
                            color: scaffoldLightColor,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                title: Text('DATE AND TIME'),
                iconColor: primaryColor,
                subtitle: Text('14 Apr, 2023\n01:30 AM '),
                trailing: IconButton(
                  icon: Icon(
                    TablerIcons.edit,
                  ),
                  onPressed: () {},
                ),
                contentPadding: EdgeInsets.all(5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
