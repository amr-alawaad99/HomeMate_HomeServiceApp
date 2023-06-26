// import 'package:flutter/material.dart';
// import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
// import 'package:login_register_methods/shared/components/constants.dart';
//
// import '../../../model_tech/chat_tech.dart';
// import 'chat_card_widget.dart';
//
// class ChatsTechnicalScreen extends StatelessWidget {
//
//   final Chat chat;
//   final VoidCallback press;
//
//   const ChatsTechnicalScreen({
//     super.key,
//     required this.chat,
//     required this.press,
//   });
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: primaryColor,
//         leading: IconButton(
//           icon: Icon(
//             TablerIcons.arrow_left,
//             size: 24,
//             color: Colors.white,
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: Text(
//           'Messages',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//             fontFamily: 'Roboto',
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(
//               TablerIcons.search,
//               size: 24,
//               color: Colors.white,
//             ),
//             onPressed: (){},
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.fromLTRB(
//                 16, 0, 16, 16),
//             color: primaryColor,
//             child: Row(
//               children: [
//                 // FillOutlineButton(press: () {}, text: "Recent Message"),
//                 // const SizedBox(width: 16),
//                 // FillOutlineButton(
//                 //   press: () {},
//                 //   text: "Active",
//                 //   isFilled: false,
//                 // ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: chatData.length,
//               itemBuilder: (context, index) => ChatCard(
//                 chat: chatData[index],
//                 press: () {
//                   // Navigator.push(
//                   //   context,
//                   //   MaterialPageRoute(
//                   //     builder: (context) => const MessagesScreen(),
//                   //   ),
//                   // );
//                 }
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
