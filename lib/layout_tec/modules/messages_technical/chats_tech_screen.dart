import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:login_register_methods/shared/resources/constants_manager.dart';
import '../../../model_tech/chat_tech.dart';

class ChatsTechnicalScreen extends StatelessWidget {
  const ChatsTechnicalScreen({super.key});



  // final Chat chat;
  // final VoidCallback press;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: Icon(
            TablerIcons.arrow_left,
            size: 24,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Chats',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              TablerIcons.search,
              size: 24,
              color: Colors.white,
            ),
            onPressed: (){},
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(
                16, 0, 16, 16),
            color: primaryColor,
            child: Row(
              children: [

              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: chatData.length,
              itemBuilder: (context, index) {
              return InkWell(
                onTap: (){},
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundImage: AssetImage('chat.image'),
                          ),
                          // if (chat.isActive)
                          //   Positioned(
                          //     right: 0,
                          //     bottom: 0,
                          //     child: Container(
                          //       height: 16,
                          //       width: 16,
                          //       decoration: BoxDecoration(
                          //         color: primaryColor,
                          //         shape: BoxShape.circle,
                          //         border: Border.all(
                          //           color: Theme.of(context).scaffoldBackgroundColor,
                          //           width: 3
                          //         ),
                          //       ),
                          //     ),
                          //   )
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'chat.name',
                                style:
                                const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 8),
                              Opacity(
                                opacity: 0.64,
                                child: Text(
                                  'chat.lastMessage',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Opacity(
                        opacity: 0.64,
                        child: Text('chat.time'),
                      ),
                    ],
                  ),
                ),
              );
              }
              ),
            ),
        ],
      ),
    );
  }
}

