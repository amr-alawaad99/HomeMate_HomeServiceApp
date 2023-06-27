import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galleryimage/galleryimage.dart';
import 'package:login_register_methods/layout/cubit/cubit.dart';
import 'package:login_register_methods/layout/cubit/states.dart';
import 'package:login_register_methods/shared/components/components.dart';

import '../../model/cost_model.dart';
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

    urls.removeLast();
    var cubit = LayoutCubit.get(context);

    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: SignInCubit
              .get(context)
              .isDark
              ? Color(0xff212121)
              : scaffoldLightColor,
          key: scaffoldKey,
          extendBody: true,
          appBar: AppBar(
            elevation: SignInCubit
                .get(context)
                .isDark ? 0 : 3,
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
            backgroundColor: SignInCubit
                .get(context)
                .isDark
                ? Color(0xff303030)
                : primaryColor,
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
                      textColor: SignInCubit
                          .get(context)
                          .isDark
                          ? Colors.white
                          : Colors.black,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      color: SignInCubit
                          .get(context)
                          .isDark
                          ? Color(0xff303030)
                          : Colors.white,
                      shadowColor: SignInCubit
                          .get(context)
                          .isDark
                          ? Colors.transparent
                          : Colors.black12,
                      mainText: 'date',
                      modelText: model.date!),
                  SizedBox(
                    height: 15,
                  ),
                  defaultContainer(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      color: SignInCubit
                          .get(context)
                          .isDark
                          ? Color(0xff303030)
                          : Colors.white,
                      textColor: SignInCubit
                          .get(context)
                          .isDark
                          ? Colors.white
                          : Colors.black,
                      shadowColor: SignInCubit
                          .get(context)
                          .isDark
                          ? Colors.transparent
                          : Colors.black12,
                      mainText: 'time',
                      modelText: model.time!),
                  SizedBox(
                    height: 15,
                  ),
                  defaultContainer(
                    textColor: SignInCubit
                        .get(context)
                        .isDark
                        ? Colors.white
                        : Colors.black,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    color: SignInCubit
                        .get(context)
                        .isDark
                        ? Color(0xff303030)
                        : Colors.white,
                    shadowColor: SignInCubit
                        .get(context)
                        .isDark
                        ? Colors.transparent
                        : Colors.black12,
                    mainText: 'details',
                    modelText: model.notes!,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  defaultContainer(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      color: SignInCubit
                          .get(context)
                          .isDark
                          ? Color(0xff303030)
                          : Colors.white,
                      textColor: SignInCubit
                          .get(context)
                          .isDark
                          ? Colors.white
                          : Colors.black,
                      shadowColor: SignInCubit
                          .get(context)
                          .isDark
                          ? Colors.transparent
                          : Colors.black12,
                      mainText: 'location',
                      modelText: model.location!),
                  SizedBox(
                    height: 15,
                  ),
                  defaultContainer(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      color: SignInCubit
                          .get(context)
                          .isDark
                          ? Color(0xff303030)
                          : Colors.white,
                      textColor: SignInCubit
                          .get(context)
                          .isDark
                          ? Colors.white
                          : Colors.black,
                      shadowColor: SignInCubit
                          .get(context)
                          .isDark
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
                        color: SignInCubit
                            .get(context)
                            .isDark
                            ? Color(0xff303030)
                            : Colors.white,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: SignInCubit
                                .get(context)
                                .isDark
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
                        colorOfNumberWidget: SignInCubit
                            .get(context)
                            .isDark
                            ? Colors.white.withOpacity(0.2)
                            : Colors.black,
                        galleryBackgroundColor: SignInCubit
                            .get(context)
                            .isDark
                            ? Color(0xff303030)
                            : scaffoldLightColor,
                        textStyleOfNumberWidget: TextStyle(
                          fontFamily: "Roboto",
                          color: SignInCubit
                              .get(context)
                              .isDark
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
                  if(model.status == 'waiting')
                    StreamBuilder<List<OfferModel>>(
                      stream: LayoutCubit.get(context).allOrderOffers(
                        model.orderUid!,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error No Data found! ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          final userOffer = snapshot.data!.reversed;
                          List<Widget> model = userOffer.map((e) =>
                              defaultOffersCard(context: context, model: e,),)
                              .toList();
                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) =>
                            userOffer.map((e) => defaultOffersCard(
                                context: context,
                                model: e,
                                list: model,
                                index: index),).toList()[index],
                            itemCount: model.length,
                          );
                        } else {
                          return Center(
                              child: CircularProgressIndicator(
                                color: primaryColor,
                              ));
                        }
                      },
                    ),
                  if(model.status != 'waiting')
                    StreamBuilder<List<OfferModel>>(
                      stream: LayoutCubit.get(context).acceptedOffer(
                        model.orderUid!,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error No Data found! ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          final userOffer = snapshot.data!.reversed;
                          List<Widget> model = userOffer.map((e) =>
                              defaultOffersCard(context: context, model: e,),)
                              .toList();
                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) =>
                            userOffer.map((e) => defaultOffersCard(
                                context: context,
                                model: e,
                                list: model,
                                index: index),).toList()[index],
                            itemCount: model.length,
                          );
                        } else {
                          return Center(
                              child: CircularProgressIndicator(
                                color: primaryColor,
                              ));
                        }
                      },
                    ),
                ],
              ),
            ),
          ),
        );
      },
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
            modelText,
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

Widget defaultOffersCard({
  int? index,
  List? list,
  required context,
  required OfferModel model,
  Function()? onPressAccept,
  Function()? onPressViewTechnicalInfo,
}) =>
    Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: InkWell(
        onTap: () {
          LayoutCubit.get(context).selectedOffer(list!, index!);
        },
        child: AnimatedContainer(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: SignInCubit
                .get(context)
                .isDark
                ? Color(0xff303030)
                : secondaryColor,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: SignInCubit
                    .get(context)
                    .isDark
                    ? Colors.transparent
                    : Colors.black12,
                blurRadius: 20.0,
                offset: Offset(0.0, 0.75),
              ),
            ],
// color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
          duration: Duration(seconds: 5),
          child: Column(
            children: [
              Row(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image(
                    image: NetworkImage(model.image!),
                    width: 60,
                    height: 60,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.profileName!.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          Image(
                            image: AssetImage('assets/images/star.png'),
                            width: 18.0,
                            height: 18.0,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "??/5",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'ex.cost'.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${model.cost} EGP".toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
              SizedBox(
                height: 10,
              ),
              if (index == LayoutCubit
                  .get(context)
                  .offerIndex)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if(model.status == 'waiting')
                      defaultButton(
                          buttonColor: successColor,
                          width: 100,
                          height: 30,
                          text: 'accept'.toUpperCase(),
                          fontSize: 12,
                          onPress: () {
                            LayoutCubit.get(context).updateUserAppointment(
                                cost: model.cost,
                                orderUid: model.orderUId,
                                profileName
                                :model.profileName,
                                profilePic
                                :model.image,);
                            LayoutCubit.get(context).updateTechnicalOrder(offerUid: model.offerUId);
                          }),
                    SizedBox(
                      width: 10,
                    ),
                    defaultButton(
                        width: 110,
                        height: 30,
                        text: 'view profile'.toUpperCase(),
                        fontSize: 12,
                        onPress: () {
                          onPressViewTechnicalInfo;
                        }),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
