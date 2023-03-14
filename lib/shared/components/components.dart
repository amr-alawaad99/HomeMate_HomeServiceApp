import 'package:flutter/material.dart';
import 'package:login_register_methods/shared/components/constants.dart';

/// BUTTON
Widget defaultButton({
  double height = 60.0,
  double width = double.infinity,
  Color buttonColor = primaryColor,
  required String text,
  Color textColor = Colors.white,
  bool isBold = false,
  double fontSize = 18.0,
  required Function() onPress,
}) =>
    Container(
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
            offset: Offset(0.0, 0.75),
          ),
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

/// TEXT FROM FIELD
Widget defaultTextFromField({
  required String hintText,
  required TextEditingController controller,
  required TextInputType keyboardType,
  String? Function(String? value)? validator,
  bool isSuffix = false,
  bool isObscure = false,
  IconData? suffixIcon,
  Function()? suffixPressFunction,
}) =>
    Container(
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
          obscureText: isObscure,
          validator: validator,
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
            hintText: hintText,
            border: InputBorder.none,
            suffixIcon: suffixIcon != null
                ? IconButton(
                    icon: Icon(suffixIcon),
                    onPressed: suffixPressFunction,
                  )
                : null,
          ),
        ),
      ),
    );

/// NAVIGATE AND PUSH (KEEPS PREVIOUS PAGE OPENED)
Future navigateAndPush(
  context, {
  required Widget widget,
}) =>
    Navigator.push(
        context,
        DialogRoute(
          context: context,
          builder: (context) => widget,
        ));

/// NAVIGATE AND PUSH THEN DELETE (DELETES PREVIOUS PAGE)
Future navigatePushDelete(
  context, {
  required Widget widget,
}) =>
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ),
        (route) => false);

Widget defaultCategoriesBox({required String img, required String text}) =>
    Expanded(
      child: GestureDetector(
        onTap: () {
          /**navigateAndPush(context, widget: );**/
        },
        child: Material(
          elevation: 3,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          child: Container(
            height: 120,
            width: 100.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage(img),
                  width: 50,
                  height: 50,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(text),
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
          ),
        ),
      ),
    );
