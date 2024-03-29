// import 'package:flutter/material.dart';
// import '../../../model_tech/chat_tech.dart';
// import '../../../shared/components/constants.dart';
//
//
//
// class ChatCard extends StatelessWidget {
//   const ChatCard({
//     Key? key,
//     required this.chat,
//     required this.press,
//   }) : super(key: key);
//
//   final Chat chat;
//   final VoidCallback press;
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: press,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(
//             horizontal: 16, vertical: 8),
//         child: Row(
//           children: [
//             Stack(
//               children: [
//                 CircleAvatar(
//                   radius: 24,
//                   backgroundImage: AssetImage(chat.image),
//                 ),
//                 if (chat.isActive)
//                   Positioned(
//                     right: 0,
//                     bottom: 0,
//                     child: Container(
//                       height: 16,
//                       width: 16,
//                       decoration: BoxDecoration(
//                         color: primaryColor,
//                         shape: BoxShape.circle,
//                         border: Border.all(
//                             color: Theme.of(context).scaffoldBackgroundColor,
//                             width: 3),
//                       ),
//                     ),
//                   )
//               ],
//             ),
//             Expanded(
//               child: Padding(
//                 padding:
//                 const EdgeInsets.symmetric(horizontal: 16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       chat.name,
//                       style:
//                       const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//                     ),
//                     const SizedBox(height: 8),
//                     Opacity(
//                       opacity: 0.64,
//                       child: Text(
//                         chat.lastMessage,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Opacity(
//               opacity: 0.64,
//               child: Text(chat.time),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }