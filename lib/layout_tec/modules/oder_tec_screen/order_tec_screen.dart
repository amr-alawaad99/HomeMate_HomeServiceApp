

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import '../../../layout/cubit/cubit.dart';
import '../../../model/orderModel.dart';
import '../../../module/sign_in_screen/cubit/cubit.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../tec_order_details/tec_order_details.dart';

class OrderTechnicalScreen extends StatelessWidget {
  const OrderTechnicalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = LayoutCubit.get(context);
    return Column(
      children: [
        StreamBuilder<List<OrderModel>>(
          stream: cubit.allOrders(cubit.originalUser!.serviceName!),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error No Data found! ${snapshot.error}');
            } else if (snapshot.hasData) {
              final allOrders = snapshot.data!.reversed;
              return ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: allOrders.map(
                      (e) => defaultAppointmentCard(
                      model: e,
                      context: context,
                      onTap: () {
                        cubit.checkOffers(e.orderUid!, cubit.originalUser!.uid!);
                        navigateAndPush(context,
                            widget: TechnicalOrderDetails(
                              model: e,
                            ));
                      }),
                ).toList(),
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
    );
  }

  Widget defaultAppointmentCard({
    required OrderModel model,
    required context,
    Function()? onTap
  }) => Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width,
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
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      TablerIcons.category,
                      color: primaryColor,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      model.serviceName!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 19.0,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${calculateDistance(
                          double.parse(model.gpsLocation!.split(',')[0]),
                          double.parse(model.gpsLocation!.split(',')[1]),
                          double.parse(LayoutCubit.get(context).originalUser!.gpsLocation!.split(',')[0]),
                          double.parse(LayoutCubit.get(context).originalUser!.gpsLocation!.split(',')[1])
                      )}"
                    ),
                    Icon(
                      TablerIcons.circle,
                      color: warningColor,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      model.status!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 16, color: warningColor),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      TablerIcons.edit,
                      color: primaryColor,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      model.notes!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    Spacer(),
                    Text(
                      model.date!,
                      // model.date!,
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      TablerIcons.map_pin,
                      color: primaryColor,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Text(
                        model.location!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Spacer(),
                    Text(
                      model.time!,
                      // model.time!,
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );


  String calculateDistance(lat1, lon1, lat2, lon2){
    double p = 0.017453292519943295;
    double a = 0.5 - cos((lat2 - lat1) * p)/2 +
        cos(lat1 * p) * cos(lat2 * p) *
            (1 - cos((lon2 - lon1) * p))/2;
    double result = 12742 * asin(sqrt(a));
    return "${result.toStringAsFixed(2)}Km";
  }
}
