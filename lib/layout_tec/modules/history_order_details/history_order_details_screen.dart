import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galleryimage/galleryimage.dart';
import 'package:login_register_methods/layout/cubit/cubit.dart';
import 'package:login_register_methods/layout/cubit/states.dart';


import '../../../model/cost_model.dart';
import '../../../model/orderModel.dart';

import '../../../module/google_maps_widget/order_tracking_screen.dart';
import '../../../module/sign_in_screen/cubit/cubit.dart';
import '../../../shared/resources/constants_manager.dart';

class HistoryOrderDetailsScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final OrderModel model;

  HistoryOrderDetailsScreen({
    super.key,
    required this.model,
  });



  @override
  Widget build(BuildContext context) {
    var cubit = LayoutCubit.get(context);
    String urlText = model.image!;
    List<String> urls = urlText.split(',');
    urls.removeLast();

    List<String> location = model.gpsLocation!.split(',');
    double latitude = double.parse(location[0]);
    double longitude = double.parse(location[1]);

    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {
        if (state is UploadOfferSuccessState) {
          cubit.checkOffers(model.orderUid!, cubit.originalUser!.uid!);
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        print("SSSSSSSSSSS ${cubit.isOffered}");
        return ConditionalBuilder(
          builder: (context) => Scaffold(
            backgroundColor: SignInCubit.get(context).isDark
                ? Color(0xff212121)
                : scaffoldLightColor,
            key: scaffoldKey,
            extendBody: true,
            appBar: AppBar(
              elevation: SignInCubit.get(context).isDark ? 0 : 3,
              iconTheme: const IconThemeData(color: Colors.white),
              leading: IconButton(
                  onPressed: () {
                    cubit.isOffered == null;
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back)),
              title: const Text(
                'Order Details',
                style: TextStyle(color: Colors.white, fontFamily: "Roboto"),
              ),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(15),
                ),
              ),
              backgroundColor: SignInCubit.get(context).isDark
                  ? Color(0xff303030)
                  : primaryColor,
            ),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
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
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 12,
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
                            height: 12,
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
                            height: 12,
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
                            height: 12,
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
                            height: 12,
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
                            height: 12,
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
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: GalleryImage(
                                colorOfNumberWidget:
                                    SignInCubit.get(context).isDark
                                        ? Colors.white.withOpacity(0.2)
                                        : Colors.black,
                                galleryBackgroundColor:
                                    SignInCubit.get(context).isDark
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
                                numOfShowImages:
                                    urls.length >= 3 ? 3 : urls.length,
                                titleGallery: 'Order photos'.toUpperCase(),
                                childAspectRatio: 1.2,
                              ),
                            ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Location on map'.toUpperCase(),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          OrderTrackingScreen(
                            lat: latitude,
                            lng: longitude,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Chosen Offer'.toUpperCase(),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          StreamBuilder<List<OfferModel>>(
                            stream: cubit.userOffer(
                                model.orderUid!, cubit.originalUser!.uid!),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text(
                                    'Error No Data found! ${snapshot.error}');
                              } else if (snapshot.hasData) {
                                final userOffer = snapshot.data!.reversed;
                                return ListView(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  children: userOffer
                                      .map(
                                        (e) => defaultOfferCard(
                                          context: context,
                                          model: e,
                                        ),
                                      )
                                      .toList(),
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
                ),
              ],
            ),
          ),
          condition: state is! CheckOfferLoadingState,
          fallback: (context) => Center(child: CircularProgressIndicator()),
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
            height: 7,
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

Widget defaultOfferCard({
  required context,
  required OfferModel model,
}) =>
    Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: SignInCubit.get(context).isDark
            ? Color(0xff303030)
            : secondaryColor,
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
      child: Row(children: [
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
                children: [
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
                'Estimated cost',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,

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
    );
