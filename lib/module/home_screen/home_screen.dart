import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:login_register_methods/layout/cubit/cubit.dart';
import '../../model/category_model.dart';
import '../../model/user_model.dart';
import '../../shared/components/components.dart';
import '../../shared/resources/constants_manager.dart';
import '../technical_details_screen/technical_details_screen.dart';

class ItemCatModel {
  String? image;
  String? name;

  ItemCatModel({
    required this.name,
    required this.image,
  });
}

class SupplierModel {
  final String serviceName;
  final String userName;
  final String rate;
  final String address;
  final String distance;

  final ImageProvider image;
  SupplierModel({
    required this.serviceName,
    required this.userName,
    required this.rate,
    required this.address,
    required this.distance,
    required this.image
  });


}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<Categories> categories = [
      Categories(
        title: 'Cleaning',
        img: AssetImage('assets/images/cleaning.png'),
      ),
      Categories(
        title: 'Kitchen',
        img: AssetImage('assets/images/kitchen.png'),
      ),
      Categories(
        title: 'Plumbing',
        img: AssetImage('assets/images/plumbing.png'),
      ),
      Categories(
        title: 'Paint',
        img: AssetImage('assets/images/paint.png'),
      ),
      Categories(
        title: 'Carpentry',
        img: AssetImage('assets/images/carpentry.png'),
      ),
      Categories(
        title: 'Electricity',
        img: AssetImage('assets/images/electrician.png'),
      )
    ];

    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Offers are here
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: const Image(
                  image: AssetImage('assets/images/carpenter.jpg'),
                ),

              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Service",
                style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 100,
                child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.all(2),
                      width: 100,
                      height: 100,
                      child: defaultCategoriesBox(
                          onTap: (){
                          },
                          elevation: 3,
                          width: 50,
                          height: 50,
                          img: categories[index].img,
                          text: categories[index].title),
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      width: 8,
                    ),
                    itemCount: categories.length),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "popular Suppliers",
                style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              StreamBuilder<List<UserModel>>(
                stream: LayoutCubit.get(context).allSuppliers(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error No Data found! ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final techs = snapshot.data!.reversed;
                    return ListView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: techs
                          .map(
                            (e) => defaultSuppliersItem(
                          model: e,
                          context: context,
                          /// Navigator to Technical Details Screen
                          press: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context){
                                return TechnicalDetailsScreen(model: e,);
                              }),
                            );
                          },
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
              // SizedBox(
              //   height: MediaQuery.of(context).size.height+100,
              //   child: ListView.separated(
              //     physics: NeverScrollableScrollPhysics(),
              //     itemBuilder: (context, index) => defaultSupplierCard(suppliers[index]),
              //     separatorBuilder: (context, index) => Container(height: 2,),
              //     itemCount: 6,
              //   ),
              // ),
            ],
          )),
    );
  }

  // Widget defaultSupplierCard(
  //     SupplierModel model,
  //     ) => InkWell(
  //           onTap: () {
  //             /**navigateAndPush(context, widget: );**/
  //
  //           },
  //           child: SizedBox(
  //             height: 145,
  //             child: Padding(
  //               padding:
  //                   const EdgeInsets.only(bottom: 8, top: 8, right: 5, left: 5),
  //               child: Material(
  //                 elevation: 3,
  //                 borderRadius: const BorderRadius.all(Radius.circular(10)),
  //                 child: Padding(
  //                   padding: const EdgeInsets.all(16.0),
  //                   child: Row(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       ClipRRect(
  //                         borderRadius: BorderRadius.circular(5),
  //                         child: Image(
  //                           image:model.image,
  //                           height: 60,
  //                           width: 60,
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         width: 20,
  //                       ),
  //                       Expanded(
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Text(model.userName,
  //                                 maxLines: 1,
  //                                 overflow: TextOverflow.ellipsis,
  //                                 style: TextStyle(
  //                                   fontWeight: FontWeight.bold,
  //                                 )),
  //                             SizedBox(
  //                               height: 10,
  //                             ),
  //                             Text(model.serviceName,
  //                                 style: TextStyle(
  //                                   fontSize: 15,
  //                                 )),
  //                             SizedBox(
  //                               height: 10,
  //                             ),
  //                             Row(
  //                               mainAxisAlignment: MainAxisAlignment.start,
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               children: [
  //                                 Icon(
  //                                   TablerIcons.map_pin,
  //                                   size: 20,
  //                                   color: secondaryColor,
  //                                 ),
  //                                 Expanded(
  //                                   child: Text(model.address,
  //                                       maxLines: 2,
  //                                       overflow: TextOverflow.ellipsis,
  //                                       style: TextStyle(
  //                                         fontSize: 15,
  //                                       )),
  //                                 ),
  //                               ],
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         width: 10,
  //                       ),
  //                       Column(
  //                         children: [
  //                           Row(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             mainAxisAlignment: MainAxisAlignment.start,
  //                             children: [
  //                               Icon(
  //                                 Icons.star,
  //                                 size: 20,
  //                                 color: Colors.amber,
  //                               ),
  //                               SizedBox(
  //                                 width: 4,
  //                               ),
  //                               Text(
  //                                 model.rate,
  //                                 style: TextStyle(
  //                                   fontSize: 15,
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                           SizedBox(
  //                             height: 30,
  //                           ),
  //                           Text(model.distance,
  //                               style: TextStyle(
  //                                 fontSize: 15,
  //                               )),
  //                         ],
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         );
}
