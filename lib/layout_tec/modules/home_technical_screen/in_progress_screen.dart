import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../../layout/cubit/cubit.dart';
import '../../../layout/cubit/states.dart';
import '../../../model/orderModel.dart';
import '../../../module/appointment_details/appointment_detials_screen.dart';
import '../../../module/sign_in_screen/cubit/cubit.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../tec_order_details/tec_order_details.dart';

class InProgressScreen extends StatelessWidget {
  const InProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = LayoutCubit.get(context);
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {      },
      builder: (context, state) {
        if(cubit.ordersUid.isEmpty){
          LayoutCubit.get(context).ss();
        }
        return Column(
          children: [
            ConditionalBuilder(
              condition: cubit.ordersUid.isNotEmpty,
              builder: (context) => StreamBuilder<List<OrderModel>>(
                stream: cubit.onWaitingOrders(cubit.ordersUid),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error No Data found! ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final allOrders = snapshot.data!.reversed;
                    print("///////////////////${allOrders.length}");
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
                                      widget: TechnicalOrderDetails(
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
              fallback: (context) => Container(),
            ),
          ],
        );
      },
    );
  }
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
                    color: warningColor,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    model.status!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      color: warningColor,
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