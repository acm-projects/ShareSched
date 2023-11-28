import 'package:flutter/material.dart';
import 'package:myapp/colors/app_colors.dart';
import 'package:myapp/models/user_model.dart';
import 'package:myapp/pages/custom_widgets.dart';

class ChatScreen extends StatefulWidget {
  final UserModel friend;
  const ChatScreen({Key? key, required this.friend}) : super(key: key);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class ChatMessage {
  String message;
  bool isSentByUser;

  ChatMessage({required this.message, required this.isSentByUser});
}

class _ChatScreenState extends State<ChatScreen> {
  List<ChatMessage> messages = [];
  TextEditingController messageController = TextEditingController();
  Color iconColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isOnProfilePage: false,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: <Widget>[
          const Divider(
            color: Colors.white,
          ),
          const SizedBox(height: 40),
          Container(
            alignment: Alignment.center,
            height: 40,
            width: 150,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              widget.friend.username!,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Quicksand',
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                final message = messages[index];

                return MessageBubble(
                  message: message.message,
                  isSentByUser: message.isSentByUser,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Focus(
                    onFocusChange: (hasFocus) {
                      if (hasFocus) {
                        setState(() {
                          iconColor = Colors.blue;
                        });
                      } else {
                        setState(() {
                          iconColor = Colors.white;
                        });
                      }
                    },
                    child: TextField(
                      style: const TextStyle(
                          color: AppColors.primaryTextColor,
                          fontFamily: 'Quicksand'),
                      controller: messageController,
                      decoration: InputDecoration(
                        labelText: 'Message...',
                        labelStyle: const TextStyle(
                          fontFamily: 'Quicksand',
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        hintText: 'Send a message...',
                        hintStyle: const TextStyle(
                          fontFamily: 'Quicksand',
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: iconColor,
                  ),
                  onPressed: () {
                    if (messageController.text.isNotEmpty) {
                      setState(() {
                        messages.add(ChatMessage(
                            message: messageController.text,
                            isSentByUser: true));
                      });
                      messageController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isSentByUser;

  const MessageBubble(
      {Key? key, required this.message, required this.isSentByUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isSentByUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
          decoration: BoxDecoration(
            border: Border.all(
                width: 2.0,
                color: isSentByUser ? Colors.blue : AppColors.themeColor),
            color: Colors.black,
            borderRadius: isSentByUser
                ? const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  )
                : const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
          ),
          child: Text(
            message,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontFamily: 'Quicksand'),
          ),
        ),
      ],
    );
  }
}
