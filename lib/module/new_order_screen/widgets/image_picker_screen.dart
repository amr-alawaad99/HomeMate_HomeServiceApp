// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
// import 'package:login_register_methods/module/new_order_screen/new_order_cubit/new_order_states.dart';
// import 'package:login_register_methods/shared/components/components.dart';
// import 'package:login_register_methods/shared/components/constants.dart';
//
// import '../new_order_cubit/new_order_cubit.dart';
//
// class ImagePickerScreen extends StatelessWidget {
//   const ImagePickerScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//         create: (BuildContext context) => NewOrderCubit(),
//         child: BlocConsumer<NewOrderCubit, NewOrderStates>(
//           listener: (context, state) {},
//           builder: (context, state) {
//             var cubit = NewOrderCubit.get(context);
//             return Dialog(
//               child: Column(
//                 children: [
//                   AppBar(
//                     shape: const RoundedRectangleBorder(
//                       borderRadius: BorderRadius.vertical(
//                         bottom: Radius.circular(15),
//                       ),
//                     ),
//                     elevation: 1,
//                     backgroundColor: primaryColor,
//                     iconTheme: IconThemeData(color: Colors.white),
//                     title: Text(
//                       'Upload Images',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Column(
//                       children: [
//                         Stack(
//                           children: [
//                             if (cubit.image != null)
//                               Positioned(
//                                   right: 0,
//                                   child: IconButton(
//                                     icon: Icon(TablerIcons.x),
//                                     onPressed: () {
//                                       cubit.clearImage();
//                                     },
//                                   )),
//                             SizedBox(
//                               height: 120,
//                               width: MediaQuery.of(context).size.width,
//                               child: FittedBox(
//                                 child: cubit.image == null
//                                     ? Icon(
//                                         TablerIcons.photo,
//                                         color: Colors.grey,
//                                       )
//                                     : Image.file(cubit.image! as File),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         if(cubit.image!=null)
//                         Row(
//                           children: [
//                             Expanded(
//                               child: defaultButton(
//                                 buttonColor: successColor,
//                                 text: 'Save',
//                                 onPress: () {
//                                   cubit.uploading = true;
//                                   cubit.uploadImage().then((url){
//                                     if(url != null){
//                                       cubit.uploading= false;
//                                     }
//                                   });
//                                 },
//                                 height: 40,
//                               ),
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             Expanded(
//                               child: defaultButton(
//                                 buttonColor: errorColor,
//                                 text: 'Cancel',
//                                 onPress: () {},
//                                 height: 40,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         defaultButton(
//                           text: 'Upload image',
//                           onPress: (){
//                             cubit.uploadImage();
//                           },
//                         ),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         if(cubit.uploading)
//                         CircularProgressIndicator(
//                           valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
//                         ),
//
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ));
//   }
// }
