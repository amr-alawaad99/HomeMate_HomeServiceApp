import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

const Color primaryColor = Color(0xff734BA4);
const Color secondaryColor = Color(0xff28b5cd);
const Color informationColor = Color(0xff0063F8);
const Color successColor = Color(0xff00cf90);
const Color warningColor = Color(0xffffb300);
const Color errorColor = Color(0xffee4646);
const Color dark1 = Color(0xff212121);
const Color dark2 = Color(0xff424242);
const Color dark3 = Color(0xff616161);

Color scaffoldLightColor = Colors.grey.shade100;

ImageProvider tempImage = const NetworkImage('https://img.freepik.com/free-vector/self-care-concept_23-2148523717.jpg?w=740&t=st=1678538562~exp=1678539162~hmac=a7d5a1db32b0d9a70e2ebbf68ab260a7ff455a23edb61284689ea8c3559233dd',);

String uId = '';
bool? isUser;
String googleMapsAPIKey = "AIzaSyACWn0PuCuZ4YxN6Vyxjvgv1xhGIW_p-6M";
 const IconData home_repair_service_rounded = IconData(0xf7f4, fontFamily: 'MaterialIcons');


Widget comingSoonDialog() => Dialog(
  child: SizedBox(
    height: 200,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(TablerIcons.alert_triangle, size: 60, color: Colors.yellow.shade600,),
        SizedBox(height: 40,),
        Text("Coming Soon!", style: TextStyle(fontWeight: FontWeight.bold),)
      ],
    ),
  ),
);