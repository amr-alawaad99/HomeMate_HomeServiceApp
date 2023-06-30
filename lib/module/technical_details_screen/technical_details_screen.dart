import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../shared/components/constants.dart';

class TechnicalDetailsScreen extends StatelessWidget {
  const TechnicalDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldLightColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: Icon(TablerIcons.arrow_left),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Technical Details',
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: Center(
                child: CircleAvatar(
                  radius: 92,
                  backgroundColor: Colors.grey,
                  backgroundImage: tempImage,
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Center(
              child: Text(
                'Technical Name',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontFamily: 'Roboto',

                ),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    'Rating   ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    '??/5',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Icon(
                    Icons.star,
                    size: 20,
                    color: Colors.amber,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    'Reviews',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    'no. reviews',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Some Reviews',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  ListView.builder(
                    itemCount: 8,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, int index){
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 28,
                                backgroundImage: tempImage,
                                backgroundColor: Colors.grey,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'User Name',
                                  ),
                                  Text(
                                    'Review Messages \n more text here',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 16,

                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }
                  ),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
