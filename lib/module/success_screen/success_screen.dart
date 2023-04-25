import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:login_register_methods/shared/components/components.dart';
import 'package:login_register_methods/shared/components/constants.dart';

import '../../layout/main_layout_screen.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width/2,
        padding: EdgeInsets.all(20),
        child: defaultButton(text: 'OK', onPress: (){
          navigateAndPush(context, widget: MainLayoutScreen());
        },height: 50),
      ),
      backgroundColor: scaffoldLightColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: scaffoldLightColor,
                      border: Border.all(
                        width: 2,
                        color: successColor
                      )),
                  height: 200,
                  width: 200,

                ),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: successColor,
                  ),
                  height: 150,
                  width: 150,
                  child: Icon(
                    TablerIcons.check,
                    size: 120,
                    color: Colors.white,
                  ),
                ),

              ],
            ),
            Text('Success!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 50,
                )),
            Text(
                'The request has been sent successfully\n waiting for the suppliers ',
                textAlign: TextAlign.center,
                style: TextStyle()),
            SizedBox(height: 15,),

          ],
        ),
      ),
    );
  }
}
