import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:login_register_methods/model/appointment.dart';
import 'package:login_register_methods/model/orderModel.dart';
import 'package:login_register_methods/shared/components/components.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/constants.dart';
import '../appointment_details/appointment_detials_screen.dart';
import '../sign_in_screen/cubit/cubit.dart';

class AppointmentsScreen extends StatelessWidget {
  final List<ChooseCategory> categories = [
    ChooseCategory(category: 'All'),
    ChooseCategory(category: 'waiting'),
    ChooseCategory(category: 'underway'),
    ChooseCategory(category: 'finished'),
  ];

  AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = LayoutCubit.get(context);

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 15,
                left: 15,
              ),
              child: SizedBox(
                height: 30,
                width: double.infinity,
                child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            cubit.changeAppointmentIndex(index);
                            print(categories[index].category);
                          },
                          child: Container(
                            width: 90,
                            height: 100,
                            decoration: BoxDecoration(
                              color: cubit.appointmentSelectedIndex == index
                                  ?secondaryColor.withOpacity(0.1):Colors.transparent,
                              border: cubit.appointmentSelectedIndex == index
                                  ? Border.all(
                                      width: 1.5,
                                      color: secondaryColor,
                                    )
                                  : null,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Text(
                                categories[index].category,
                                style: TextStyle(

                                  color: cubit.appointmentSelectedIndex == index
                                      ? secondaryColor
                                      : Colors.grey,
                                  fontSize: 18,
                                  fontWeight: cubit.appointmentSelectedIndex == index
                                      ?FontWeight.bold:FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                        ),
                    separatorBuilder: (context, index) => const SizedBox(
                          width: 8,
                        ),
                    itemCount: categories.length),
              ),
            ),
            Column(
              children: [
                StreamBuilder<List<OrderModel>>(
                  stream: cubit.appointmentSelectedIndex == 0?
                      cubit.allUserOrders(cubit.originalUser!.uid!):cubit.orders(cubit.originalUser!.uid!,
                      categories[cubit.appointmentSelectedIndex].category),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error No Data found! ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final orders = snapshot.data!.reversed;
                      return ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: orders
                            .map(
                              (e) => defaultAppointmentCard(
                                  model: e,
                                  context: context,
                                  onTap: () {
                                    navigateAndPush(context,
                                        widget: AppointmentDetails(
                                          model: e,
                                        ));
                                  }),
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
          ],
        );
      },
    );
  }

  Widget defaultAppointmentCard(
          {required OrderModel model, required context, Function()? onTap}) =>
      Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.serviceName!,
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
                              image: model.status == 'waiting'
                                  ? tempImage
                                  : NetworkImage(model.profilePic!),
                              width: 50,
                              height: 50,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  model.status == 'waiting'
                                      ? 'waiting for technical offers!'
                                      : model.profileName!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
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
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '??/5',
                                      style: TextStyle(
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Icon(
                              TablerIcons.edit,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(width: 5,),
                          Text(
                            model.notes!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12.0,
                            ),
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
                            model.date!,
                            style: const TextStyle(
                              fontSize: 12.0,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            model.time!,
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
                            color: model.status == 'finished'
                                ? successColor
                                : warningColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            model.status!.toUpperCase(),
                            style: TextStyle(
                                fontSize: 12.0,
                                color: model.status == 'finished'
                                    ? successColor
                                    : warningColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Estimated Cost',
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      model.cost!,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: secondaryColor,
                      ),
                    ),
                    SizedBox(height: 40),
                    StreamBuilder<int>(
                      stream: LayoutCubit.get(context)
                          .allOrderOffersLength(model.orderUid!),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error No Data found! ${snapshot.error}');
                        } else if (snapshot.hasData) {
                          return CircleAvatar(
                            backgroundColor: secondaryColor,
                            radius: 15,
                            child: Text(
                              '${snapshot.data}',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        } else {
                          return Center(
                              child: CircularProgressIndicator(
                            color: primaryColor,
                          ));
                        }
                      },
                    ),
                    SizedBox(height: 40),
                    InkWell(
                      onTap: () {
                        LayoutCubit.get(context)
                            .removeOrder(orderUid: model.orderUid!);
                        LayoutCubit.get(context).removeOfferWithOrder(orderUId: model.orderUid!);

                      },
                      child: Icon(
                        TablerIcons.trash,
                        color: errorColor,
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
