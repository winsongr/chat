import 'package:chat/app/utils/exports.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_3.dart';

class ChatBubbleWidget extends StatelessWidget {
  final Alignment bubbleAlignment;
  final String? message;
  final AssetImage? userAvatar;
  final BubbleType bubbleType;
  const ChatBubbleWidget({
    super.key,
    required this.bubbleAlignment,
    this.message,
    this.userAvatar,
    required this.bubbleType,
  });

  @override
  Widget build(BuildContext context) {
    if (bubbleAlignment == Alignment.topLeft) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: Get.width * 0.03,
          ),
          Container(
            margin: EdgeInsets.only(
              bottom: Get.height * 0.015,
            ),
            child: CircleAvatar(
              radius: Get.width * 0.04,
              backgroundColor: Colors.transparent,
              backgroundImage: userAvatar,
            ),
          ),
          _messages(context, message ?? '', bubbleAlignment, bubbleType),
        ],
      );
    } else {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _messages(context, message ?? '', bubbleAlignment, bubbleType),
          Container(
            margin: EdgeInsets.only(
              bottom: Get.height * 0.015,
            ),
            child: CircleAvatar(
              radius: Get.width * 0.04,
              backgroundColor: Colors.transparent,
              backgroundImage: userAvatar,
            ),
          ),
          SizedBox(
            width: Get.width * 0.03,
          ),
        ],
      );
    }
  }
}

Widget _messages(BuildContext context, String message,
    Alignment bubbleAlignment, BubbleType bubbleType) {
  return ChatBubble(
    clipper: ChatBubbleClipper3(type: bubbleType),
    alignment: bubbleAlignment,
    margin: EdgeInsets.only(
      top: Get.height * 0.02,
      left: Get.width * 0.01,
      bottom: Get.height * 0.02,
    ),
    backGroundColor:
        bubbleAlignment == Alignment.topLeft ? Colors.grey : Colors.blue,
    child: Container(
      constraints: BoxConstraints(
        maxWidth: Get.width * 0.7,
      ),
      child: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
    ),
  );
}
