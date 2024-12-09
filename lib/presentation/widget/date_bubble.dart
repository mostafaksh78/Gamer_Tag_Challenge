import 'package:flutter/cupertino.dart';
import 'package:gamer_tag/domain/model/model.dart';

class DateBubble extends StatelessWidget {
  final Date date;

  const DateBubble({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        date.date,
        style: const TextStyle(
          fontSize: 10,
          color: CupertinoColors.systemGrey,
        ),
      ),
    );
  }
}
