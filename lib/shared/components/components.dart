import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
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
  IconData? prefixIcon,
  Function()? suffixPressFunction,
  Function()? prefixPressFunction,
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
            fontSize: 16.0,
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
            prefixIcon: prefixIcon != null
                ? IconButton(
                    icon: Icon(prefixIcon),
                    onPressed: prefixPressFunction,
                  )
                : null,
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
      child: InkWell(
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

Widget defaultCategoryChooser({required String text}) => InkWell(
      onTap: () {},
      child: Container(
        width: 95,
        height: 100,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: secondaryColor,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.5,
            color: secondaryColor,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );

Widget defaultAppointmentCard(
        {required String serviceName,
        required String userName,
        required String date,
        required String time,
        required String status,
        required String cost,required int count}) =>
    ListView.separated(
        itemBuilder: (BuildContext context, int index) => InkWell(
              onTap: () {
                /**navigateAndPush(context, widget: );**/
              },
              child: Material(
                elevation: 3,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  serviceName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19.0,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image(
                                        image: NetworkImage(tempImage),
                                        width: 30,
                                        height: 30,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          userName,
                                          style: TextStyle(
                                            fontSize: 15.0,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Image(
                                              image: AssetImage(
                                                  'assets/images/star.png'),
                                              width: 15.0,
                                              height: 15.0,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '4.5/5',
                                              style: TextStyle(
                                                fontSize: 12.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      date,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      time,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Icon(
                                      TablerIcons.circle,
                                      size: 20,
                                      color: secondaryColor,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      status,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Cost',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                  ),
                                ),
                                Text(
                                  cost,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: secondaryColor,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: double.infinity,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: () {},
                                          child: Icon(
                                            TablerIcons.trash,
                                            color: errorColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        separatorBuilder: (BuildContext context, int index) => SizedBox(
              height: 15,
            ),
        itemCount: count);
