import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/cupertino.dart';
import 'package:gamer_tag/domain/model/model.dart';

class ChatBubble extends StatelessWidget {
  final Message message;
  final int expandValue;
  const ChatBubble({
    required this.message,
    super.key, required this.expandValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment:
            message.sendOrRecieve ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          BubbleSpecialThree(

            color: message.sendOrRecieve
                ? !message.timer?CupertinoColors.activeBlue:CupertinoColors.activeOrange
                : CupertinoColors.systemGrey5,
            isSender: message.sendOrRecieve,
            tail: true,
            text: message.text,
            textStyle: TextStyle(
              color: message.sendOrRecieve
                  ? CupertinoColors.white
                  : CupertinoColors.black,
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              message.sendOrRecieve && message.read
                  ? "Read ${message.readDate}"
                  : "",
              style: const TextStyle(
                fontSize: 10,
                color: CupertinoColors.systemGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
