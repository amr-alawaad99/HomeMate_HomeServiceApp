import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_register_methods/model/user_model.dart';
import 'package:login_register_methods/module/sign_in_screen/cubit/cubit.dart';
import 'package:login_register_methods/module/sign_in_screen/cubit/states.dart';
import 'package:login_register_methods/shared/components/constants.dart';

/// BUTTON
Widget defaultButton({
  double height = 60.0,
  double width = double.infinity,
  Color buttonColor = primaryColor,
  String? text,
  Color textColor = Colors.white,
  bool isBold = false,
  double fontSize = 18.0,
  required Function() onPress,
  Widget? child,
}) =>
    Container(
      height: height,
      width: width,
      clipBehavior: Clip.antiAlias,
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
        child: child ??
            Text(
              text ?? "",
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
Widget defaultTextFormField(
        {required String hintText,
        required TextEditingController controller,
        required TextInputType keyboardType,
        String? Function(String? value)? validator,
        bool isSuffix = false,
        bool isEnabled = true,
        bool isObscure = false,
        IconData? suffixIcon,
        IconData? prefixIcon,
        int? maxLength,
        Function()? suffixPressFunction,
        Function()? prefixPressFunction,
        Function()? onTapFunction,
        ValueChanged<String>? onSubmit,
        Color prefixIconColor = Colors.grey,
        Color suffixIconColor = Colors.grey}) =>
    BlocConsumer<SignInCubit, SignInStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: SignInCubit.get(context).isDark
                ? Colors.grey[800]
                : scaffoldLightColor,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 20.0,
                  offset: Offset(0.0, 0.75)),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              onFieldSubmitted: onSubmit,
              maxLength: maxLength,
              inputFormatters: [
                LengthLimitingTextInputFormatter(maxLength),
                // Apply a formatter to limit the length
              ],
              style: const TextStyle(
                fontFamily: "Roboto",
                fontSize: 16.0,
              ),
              onTap: onTapFunction,
              enabled: isEnabled,
              obscureText: isObscure,
              validator: validator,
              controller: controller,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                counterText: '',
                //To Hide MaxLength
                hintStyle: const TextStyle(
                  color: Colors.grey,
                ),
                hintText: hintText,
                border: InputBorder.none,
                prefixIcon: prefixIcon != null
                    ? IconButton(
                        icon: Icon(
                          prefixIcon,
                          color: prefixIconColor,
                        ),
                        onPressed: prefixPressFunction,
                      )
                    : null,
                suffixIcon: suffixIcon != null
                    ? IconButton(
                        icon: Icon(
                          suffixIcon,
                          color: suffixIconColor,
                        ),
                        onPressed: suffixPressFunction,
                      )
                    : null,
              ),
            ),
          ),
        );
      },
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

/// Show Toast
void showToast({
  required String message,
  required Color toastColor,
  Color textColor = Colors.white,
  double fontSize = 16.0,
}) =>
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: toastColor,
      textColor: textColor,
      fontSize: fontSize,
    );

Widget defaultCategoriesBox({
  required ImageProvider img,
  required String text,
  double width = 60,
  double height = 60,
  double elevation = 3,
  Color? color,
  Color? textColor,
  Function()? onTap,
}) =>
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
              style: TextStyle(
                color: textColor,
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

Widget defaultSuppliersItem({
  required UserModel model,required context,
}) {
  return SizedBox(
    height: 130,
    child: Padding(
        padding: const EdgeInsets.only(top: 10, right: 15, left: 15),
        child: Container(
          decoration: BoxDecoration(
              color: SignInCubit.get(context).isDark
                  ? Color(0xff303030)
                  : Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: SignInCubit.get(context).isDark
                      ? Colors.transparent
                      : Colors.black12,
                  blurRadius: 20.0,
                  offset: Offset(0.0, 0.75),
                ),
              ],
              // color: Colors.white,
              borderRadius: BorderRadius.circular(10.0)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image(image: NetworkImage("${model.profilePic}"),)
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(model.profileName!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Text('jop',
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
                            child: Text(model.address!,
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
                          '??/5',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text('distance',
                        style: TextStyle(
                          fontSize: 15,
                        )),
                  ],
                )
              ],
            ),
          ),
        )),
  );
}
