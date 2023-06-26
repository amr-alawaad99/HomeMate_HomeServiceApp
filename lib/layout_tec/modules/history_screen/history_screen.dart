import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:login_register_methods/shared/components/constants.dart';
import '../../../layout/cubit/cubit.dart';
import '../../../model/orderModel.dart';
import '../../../module/appointment_details/appointment_detials_screen.dart';
import '../../../module/sign_in_screen/cubit/cubit.dart';
import '../../../shared/components/components.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var cubit = LayoutCubit.get(context);
    return Column(
      children: [
        StreamBuilder<List<OrderModel>>(
          stream: cubit.finishedOrders(cubit.originalUser!.serviceName!,cubit.originalUser!.uid!),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error No Data found! ${snapshot.error}');
            } else if (snapshot.hasData) {
              final allOrders = snapshot.data!.reversed;
              return ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: allOrders
                    .map(
                      (e) =>
                      defaultAppointmentCard(
                          model: e,
                          context: context,
                          onTap: () {
                            navigateAndPush(context,
                                widget: AppointmentDetails(
                                  model: e,
                                ));
                          }
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
    );
  }

  Widget defaultAppointmentCard(
      {required OrderModel model, required context, Function()? onTap}) =>
      Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15.0),
          child: Container(
            padding: const EdgeInsets.all(15),
            width: MediaQuery
                .of(context)
                .size
                .width,
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
                    Icon(
                      TablerIcons.circle,
                      color: successColor,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      model.status!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 16,
                          color: successColor,
                      ),
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

}
