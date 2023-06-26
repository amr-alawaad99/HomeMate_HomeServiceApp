import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:galleryimage/galleryimage.dart';
import 'package:login_register_methods/layout/cubit/cubit.dart';

import 'package:login_register_methods/shared/components/components.dart';

import '../../../model/orderModel.dart';

import '../../../module/sign_in_screen/cubit/cubit.dart';
import '../../../shared/components/constants.dart';

class TechnicalOrderDetails extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final OrderModel model;

  TechnicalOrderDetails({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    var costController = TextEditingController();
    var cubit = LayoutCubit.get(context);
    String urlText = model.image!;
    List<String> urls = urlText.split(',');

    urls.removeLast();

    return Scaffold(
      backgroundColor: SignInCubit.get(context).isDark
          ? Color(0xff212121)
          : scaffoldLightColor,
      key: scaffoldKey,
      extendBody: true,
      appBar: AppBar(
        elevation: SignInCubit.get(context).isDark ? 0 : 3,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Order Details',
          style: TextStyle(color: Colors.white, fontFamily: "Roboto"),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        backgroundColor:
            SignInCubit.get(context).isDark ? Color(0xff303030) : primaryColor,
      ),

      bottomNavigationBar: Container(
        margin: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width / 2,
        height: 60,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: primaryColor,
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
          onPressed: () {
            navigateAndPush(
              context,
              widget: offerCostDialog(
                onTap: () {
                  cubit.offerCreate(
                    username: cubit.originalUser!.profileName,
                    uId: cubit.originalUser!.uid,
                    orderUId: model.orderUid,
                    image: cubit.originalUser!.profilePic,
                    cost: costController.text,
                  );
                },
                controller: costController,
                context: context,
                model: model,
              ),
            );
          },
          child:
              // state is NewOrderUploadImageToFirebaseLoadingState ||
              //     state is UploadOrderLoadingState
              //     ?
              // const SizedBox(
              //     width: 25,
              //     height: 25,
              //     child: CircularProgressIndicator(
              //       color: Colors.white,
              //     ))
              //     :
              const Text(
            "Offer Cost",
            style: TextStyle(
              fontFamily: 'Roboto',
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 90,
                decoration: const BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      10.0,
                    ),
                  ),
                ),
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    // Stack(
                    //   alignment: Alignment.center,
                    //   children: [
                    //     Container(
                    //       decoration: const BoxDecoration(
                    //         color: Color(0xffd4f0f6),
                    //         borderRadius: BorderRadius.all(
                    //           Radius.circular(
                    //             10.0,
                    //           ),
                    //         ),
                    //       ),
                    //       width: 110,
                    //       height: 110,
                    //     ),
                    //     Image(
                    //       image: tempImage,
                    //       height: 80,
                    //       width: 80,
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Service Name:',
                          style: TextStyle(
                            color: scaffoldLightColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Text(
                          model.serviceName!,
                          style: TextStyle(
                            color: scaffoldLightColor,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        // Text(
                        //   'If you need of homes,office,\napartment ...etc',
                        //   style: TextStyle(
                        //     color: scaffoldLightColor,
                        //     fontSize: 15,
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              defaultContainer(
                  textColor: SignInCubit.get(context).isDark
                      ? Colors.white
                      : Colors.black,
                  width: MediaQuery.of(context).size.width,
                  color: SignInCubit.get(context).isDark
                      ? Color(0xff303030)
                      : Colors.white,
                  shadowColor: SignInCubit.get(context).isDark
                      ? Colors.transparent
                      : Colors.black12,
                  mainText: 'date',
                  modelText: model.date!),
              SizedBox(
                height: 15,
              ),
              defaultContainer(
                  width: MediaQuery.of(context).size.width,
                  color: SignInCubit.get(context).isDark
                      ? Color(0xff303030)
                      : Colors.white,
                  textColor: SignInCubit.get(context).isDark
                      ? Colors.white
                      : Colors.black,
                  shadowColor: SignInCubit.get(context).isDark
                      ? Colors.transparent
                      : Colors.black12,
                  mainText: 'time',
                  modelText: model.time!),
              SizedBox(
                height: 15,
              ),
              defaultContainer(
                textColor: SignInCubit.get(context).isDark
                    ? Colors.white
                    : Colors.black,
                width: MediaQuery.of(context).size.width,
                color: SignInCubit.get(context).isDark
                    ? Color(0xff303030)
                    : Colors.white,
                shadowColor: SignInCubit.get(context).isDark
                    ? Colors.transparent
                    : Colors.black12,
                mainText: 'details',
                modelText: model.notes!,
              ),
              SizedBox(
                height: 15,
              ),
              defaultContainer(
                  width: MediaQuery.of(context).size.width,
                  color: SignInCubit.get(context).isDark
                      ? Color(0xff303030)
                      : Colors.white,
                  textColor: SignInCubit.get(context).isDark
                      ? Colors.white
                      : Colors.black,
                  shadowColor: SignInCubit.get(context).isDark
                      ? Colors.transparent
                      : Colors.black12,
                  mainText: 'location',
                  modelText: model.location!),
              SizedBox(
                height: 15,
              ),
              defaultContainer(
                  width: MediaQuery.of(context).size.width,
                  color: SignInCubit.get(context).isDark
                      ? Color(0xff303030)
                      : Colors.white,
                  textColor: SignInCubit.get(context).isDark
                      ? Colors.white
                      : Colors.black,
                  shadowColor: SignInCubit.get(context).isDark
                      ? Colors.transparent
                      : Colors.black12,
                  mainText: 'status',
                  modelText: model.status!),
              SizedBox(
                height: 15,
              ),
              if (urls.isNotEmpty)
                Text(
                  'Order Photos'.toUpperCase(),
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              SizedBox(
                height: 5,
              ),
              if (urls.isNotEmpty)
                Container(
                  padding: EdgeInsets.all(10),
                  height: 117,
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
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: GalleryImage(
                    colorOfNumberWidget: SignInCubit.get(context).isDark
                        ? Colors.white.withOpacity(0.2)
                        : Colors.black,
                    galleryBackgroundColor: SignInCubit.get(context).isDark
                        ? Color(0xff303030)
                        : scaffoldLightColor,
                    textStyleOfNumberWidget: TextStyle(
                      fontFamily: "Roboto",
                      color: SignInCubit.get(context).isDark
                          ? Colors.black
                          : Colors.white,
                      fontSize: 25,
                    ),
                    imageUrls: urls,
                    errorWidget: SizedBox(),
                    crossAxisCount: 3,
                    numOfShowImages: urls.length >= 3 ? 3 : urls.length,
                    titleGallery: 'Order photos'.toUpperCase(),
                    childAspectRatio: 1.2,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget defaultContainer({
  required double width,
  required Color color,
  required Color textColor,
  required Color shadowColor,
  required String mainText,
  required String modelText,
}) =>
    Container(
      padding: const EdgeInsets.all(10),
      width: width,
      decoration: BoxDecoration(
        color: color,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: shadowColor,
            blurRadius: 20.0,
            offset: Offset(0.0, 0.75),
          ),
        ],
// color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            mainText.toUpperCase(),
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            modelText.toUpperCase(),
            style: TextStyle(
              color: textColor,
              fontSize: 15,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 6,
          ),
        ],
      ),
    );

Widget offerCostDialog({
  required controller,
  required context,
  required OrderModel model,
  required Function()? onTap,
}) =>
    Dialog(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
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
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Offer Cost!",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                color: SignInCubit.get(context).isDark
                    ? Color(0xff303030)
                    : Colors.grey[300],
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
                borderRadius: BorderRadius.circular(20.0),
              ),
              margin: EdgeInsets.all(10),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter Expected cost',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  suffixIcon: IconButton(
                    onPressed: onTap,
                    icon: Icon(TablerIcons.send),
                    color: primaryColor,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
