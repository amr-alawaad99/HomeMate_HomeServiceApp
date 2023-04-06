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
  Function()? onTapFunction,
  Color prefixIconColor = Colors.grey
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
          onTap: onTapFunction,
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

Widget defaultCategoriesBox(
        {required ImageProvider img,
        required String text,
        double width = 60,
        double height = 60,
        double elevation = 3,
        Color color = Colors.white,
         Function()? onTap}) =>
    Material(
      color: color,
      elevation: elevation,
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: img,
              width: width,
              height: height,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              text,
              style: const TextStyle(
                fontFamily: "Roboto",
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );

Widget defaultCategoryChooser({required String text}) => InkWell(
      onTap: () {},
      child: Container(
        width: 95,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.5,
            color: secondaryColor,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: secondaryColor,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
//

Widget defaultAppointmentCard({
  required String serviceName,
  required String userName,
  required String date,
  required String time,
  required String status,
  required String cost,
  required ImageProvider image,
}) =>
    Material(
      elevation: 3,
      borderRadius: const BorderRadius.all(
        Radius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
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
                        style: const TextStyle(
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
                              image: image,
                              width: 30,
                              height: 30,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userName,
                                style: const TextStyle(
                                  fontSize: 15.0,
                                ),
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  Image(
                                    image: AssetImage('assets/images/star.png'),
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
                            style: const TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            time,
                            style: const TextStyle(
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
                            crossAxisAlignment: CrossAxisAlignment.end,
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
    );
//

Widget defaultSuppliersItem({
  required String mark,
  required String agentName,
  required String jop,
  required String address,
  required String distance,
  required int count,
  required BuildContext context,
}) {
  return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),

      ///To avoid nested scrolling
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            /**navigateAndPush(context, widget: );**/
          },
          child: Container(
            height: 150,
            child: Padding(
              padding:
                  const EdgeInsets.only(bottom: 8, top: 8, right: 16, left: 16),
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image(
                          image: tempImage,
                          height: 60,
                          width: 60,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(agentName,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Text(jop,
                                style: TextStyle(
                                  fontSize: 15,
                                )),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  TablerIcons.map_pin,
                                  size: 20,
                                  color: secondaryColor,
                                ),
                                Expanded(
                                  child: Text(address,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 15,
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.star,
                                size: 20,
                                color: Colors.amber,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                mark,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(distance,
                              style: TextStyle(
                                fontSize: 15,
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => SizedBox(),
      itemCount: count);
}
