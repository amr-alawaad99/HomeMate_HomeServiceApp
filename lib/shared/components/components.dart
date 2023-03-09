import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:login_register_methods/shared/components/constants.dart';

Widget defaultButton({
  double height = 60.0,
  double width = double.infinity,
  Color buttonColor = primaryColor,
  required String text,
  Color textColor = Colors.white,
  bool isBold = false,
  double fontSize = 18.0,
  required Function() onPress,
}) => Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(10.0),
        ),
        boxShadow: const <BoxShadow>[
          BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0.0, 0.75),),
        ],
      ),
      child: MaterialButton(
        onPressed: onPress,
        child: Text(
          text,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontFamily: 'Roboto',
            color: textColor,
            fontSize: fontSize,
          ),
        ),
      ),
    );

Widget defaultTextFromField({
  required String hintText,
  String? Function(String? value)? validator,
  bool isSuffix = false,
}) => Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black12,
              blurRadius: 20.0,
              offset: Offset(0.0, 0.75)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextFormField(
          style: const TextStyle(
              fontFamily: "Roboto",
              fontSize: 18.0,
          ),
          decoration: InputDecoration(
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
            hintText: hintText,
            border: InputBorder.none,
            suffixIcon: IconButton(
              onPressed: () {},
              icon: Icon(
                isSuffix == true? TablerIcons.eye : null,
              ),
            ),
          ),
          validator: validator,
        ),
      ),
    );
