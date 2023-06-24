import 'package:flutter/material.dart';
import 'package:galleryimage/galleryimage.dart';


import '../../model/orderModel.dart';
import '../../shared/components/constants.dart';
import '../sign_in_screen/cubit/cubit.dart';

class AppointmentDetails extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final OrderModel model;

  AppointmentDetails({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    String urlText = model.image!;
    List<String> urls = urlText.split(',');
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
          'Appointment Details',
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
                height: 20,
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
                height: 20,
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
                height: 20,
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
                  modelText: model.notes!),
              SizedBox(
                height: 20,
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
                height: 20,
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
                height: 20,
              ),
              urls.length ==0 ?SizedBox():GalleryImage(
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
                numOfShowImages: urls.length,
                titleGallery: 'Order photos'.toUpperCase(),
                childAspectRatio: 1.2,
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
   double height = 80,
  required Color color,
  required Color textColor,
  required Color shadowColor,
  required String mainText,
  required String modelText,
}) =>
    Container(
      padding: const EdgeInsets.all(10),
      height: height,
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
          Expanded(
            child: Text(

              modelText.toUpperCase(),
              style: TextStyle(
                color: textColor,
                fontSize: 15,
              ),
              overflow: TextOverflow.ellipsis,maxLines: 6,
            ),
          ),
        ],
      ),
    );
