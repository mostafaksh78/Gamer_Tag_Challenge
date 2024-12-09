import 'package:gamer_tag/data/data_source/data_source.dart';
import 'package:gamer_tag/data/entity/message.dart';
import 'package:gamer_tag/data/entity/user.dart';
import 'package:gamer_tag/utils.dart';


class FakeSource implements MessageSource {
  @override
  Future<List<MessageEntity>> loadMessages(int from, int to,UserEntity user) async {
    await Future.delayed(Duration(seconds: 3));
    var ret = <MessageEntity>[];
    var date = startDate;
    for (int i = from; i < to; i++) {
      var year = date.year;
      var month = date.month;
      var day = date.day;
      var hour = date.hour;
      var minute = date.minute;
      var read = i % 10 == 0;
      var send = i % 5 == 0;
      var readHour = hour;
      var readDay = day;
      var readMonth = month;
      var readMinute = minute;
      var readYear = year;
      var entity = MessageEntity(
          "Test Text ${user.id} ${i}", year, month, day, hour, minute, read, send,
          readYear: readYear,
          readMinute: readMinute,
          readHour: readHour,
          readDay: readDay,
          readMonth: readMonth);
      ret.add(entity);
      date = date.minusHour();
    }
    return ret;
  }

  @override
  Future<List<UserEntity>> loadUsers() async {
    return <UserEntity>[
      UserEntity("Mostafa", "M1"),
      UserEntity("Ali", "A1"),
      UserEntity("Danial", "D1")
    ];
  }

  @override
  Future<void> removeMessage(MessageEntity message,UserEntity user) async {
    // await Future.delayed(Duration(seconds: 1));
    return;
  }

  @override
  Future<void> sendMessage(MessageEntity message,UserEntity user) async {
    // await Future.delayed(Duration(seconds: 1));
    return;
  }
}
