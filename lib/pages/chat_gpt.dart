import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/colors/app_colors.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:myapp/providers/user_model_provider.dart';

class VirtualAssistantScreen extends StatefulWidget {
  const VirtualAssistantScreen({Key? key}) : super(key: key);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class VirtualAssistant {
  static String id = '2';
  static String name = 'ScheduleGPT';
  static String trainingPrompt =
      "Role: You are an AI virtual assistant trained to assist users with academic scheduling and course information. Responsibilities: 1. Provide Course Details: Offer information about course prerequisites, instructor details, course content, and credit hours. 2. Assist with Scheduling: Help users plan their academic schedules, including class timings, exam dates, and study timelines. 3. Offer Study Plan Advice: Give suggestions on balancing course loads and effective study strategies. 4. General Academic Inquiries: Respond to general questions about academic programs and school policies. Limitations: Do not provide personal opinions or subjective advice. Avoid giving information outside the scope of academic scheduling and course details. Direct users to official academic resources for confirmation of critical information. Example Interactions: User: Can you tell me what the prerequisites are for the Advanced Biology course? AI: The prerequisites for Advanced Biology include Introductory Biology and Chemistry 101. It's also recommended to have a basic understanding of statistics. User: I'm struggling to fit all my courses into my schedule. Can you help? AI: Certainly! Let's look at your current course list and see how we can organize them efficiently. Please provide me with the courses you are planning to take. User: How can I manage my study time effectively for my upcoming exams? AI: A good approach...";
  static String initialPrompt =
      "Hello! I'm ScheduleGPT. As an AI assistant specialized in academic scheduling and course info, I'm here to help organize your schedule, provide course details, and offer study plan advice.";
  static String avatarPath = 'assets/page-1/images/custom/ScheduleGPT.png';
}

class ChatMessage {
  String message;
  bool isSentByUser;
  Role role;

  ChatMessage(
      {required this.message, required this.isSentByUser, required this.role});
}

class _ChatScreenState extends State<VirtualAssistantScreen> {
  List<ChatMessage> messages = [];
  TextEditingController messageController = TextEditingController();
  Color iconColor = Colors.white;
  final openAI = OpenAI.instance.build(
      token: dotenv.env['OPENAI_API_KEY'],
      baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)),
      enableLog: true);

  void sendInitialPrompt() async {
    final request = ChatCompleteText(
      messages: [
        Messages(role: Role.system, content: VirtualAssistant.trainingPrompt)
      ],
      maxToken: 200,
      model: Gpt4ChatModel(),
    );

    final response = await openAI.onChatCompletion(request: request);
    // Optionally process the response if needed
  }

  void chatComplete() async {
    List<Messages> conversationHistory = messages
        .map((chatMessage) =>
            Messages(role: chatMessage.role, content: chatMessage.message))
        .toList();

    conversationHistory
        .add(Messages(role: Role.user, content: messageController.text));

    // Send the entire conversation to GPT
    final request = ChatCompleteText(
      messages: conversationHistory,
      maxToken: 200,
      model: Gpt4ChatModel(),
    );

    final response = await openAI.onChatCompletion(request: request);
    for (var element in response!.choices) {
      setState(() {
        messages.add(ChatMessage(
            message: element.message?.content ?? "",
            isSentByUser: false,
            role: Role.system));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    messages.add(ChatMessage(
        message: VirtualAssistant.initialPrompt,
        isSentByUser: false,
        role: Role.system));
    sendInitialPrompt();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                color: AppColors.themeColor,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              VirtualAssistant.name,
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
                            isSentByUser: true,
                            role: Role.user));
                      });
                      chatComplete();
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

class MessageBubble extends ConsumerWidget {
  final String message;
  final bool isSentByUser;

  const MessageBubble({
    Key? key,
    required this.message,
    required this.isSentByUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment:
          isSentByUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isSentByUser)
          _AIImage(), // Display user image for received messages
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
        SizedBox(
          height: 100,
        ),
        if (isSentByUser) _userImage(ref),
      ],
    );
  }

  Widget _AIImage() {
    return Padding(
      padding: EdgeInsets.only(right: 8.0, bottom: 8.0),
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        backgroundImage: AssetImage(VirtualAssistant.avatarPath),
        radius: 20,
      ),
    );
  }

  Widget _userImage(WidgetRef ref) {
    String? userAvatarURL = ref.read(userModelProvider).avatarURL;
    if (userAvatarURL!.isEmpty) {
      userAvatarURL =
          "https://static.vecteezy.com/system/resources/previews/020/765/399/non_2x/default-profile-account-unknown-icon-black-silhouette-free-vector.jpg";
    }
    return Padding(
      padding: const EdgeInsets.only(),
      child: CircleAvatar(
        backgroundImage: NetworkImage(userAvatarURL!),
        radius: 14.7,
      ),
    );
  }
}
