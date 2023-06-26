import 'package:flutter/material.dart';

class OrdersTechnicalScreen extends StatelessWidget {
  const OrdersTechnicalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ListView.builder(
      itemCount: 12,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index){
        return Container(
          margin: EdgeInsets.only(top: 8),
          padding: const EdgeInsets.only( right: 16, left: 16),
          child: Stack(
            children: [
              Container(
                height: size.height * 0.1,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              Row(
                children: [
                  Container(
                    height: size.height * 0.1,
                    width: size.width * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://d3eeke16mv0lt7.cloudfront.net/sites/default/files/styles/article_hero_image__1_5x/public/field/image/google-location-privacy.jpg?itok=aWO7w39o'
                          ),
                          fit: BoxFit.cover
                      ),
                    ),
                  ),
                  Container(
                    height: size.height * 0.1,
                    width: size.width * 0.7,
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: Column(
                      children: const [
                        Row(
                          children: [
                            //Name of Client here
                            Text(
                              'Client Name',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                            Spacer(),
                            // Time for doing Order
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
                            //Location Of Order here
                            Text(
                              'location',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                fontSize: 16,
                              ),
                            ),
                            Spacer(),
                            // Distance between technical and client
                            Text(
                              'distance',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
