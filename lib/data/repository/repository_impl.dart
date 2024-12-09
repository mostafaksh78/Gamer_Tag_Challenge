import 'package:gamer_tag/data/data_source/data_source.dart';
import 'package:gamer_tag/data/entity/message.dart';
import 'package:gamer_tag/domain/model/model.dart';
import 'package:gamer_tag/domain/model/user.dart';
import 'package:gamer_tag/domain/repository/repository.dart';

class RepositoryImpl extends Repository {
  final MessageSource messageSource;

  RepositoryImpl(this.messageSource) : super();

  @override
  Future<List<Entity>> loadData(int from, int to, User user) async {
    var data = await messageSource.loadMessages(from, to, user);
    if (data.isEmpty) {
      return [];
    } else {
      var ret = <Entity>[];
      int preDay = data[0].day;
      int preMonth = data[0].month;
      int preYear = data[0].year;
      int preMinute = data[0].minute;
      int preHour = data[0].hour;
      for (int i = 0; i < data.length; i++) {
        MessageEntity message = data[i];
        ret.add(Message.entity(message));
        var day = message.day;
        var month = message.month;
        var year = message.year;
        var hour = message.hour;
        var minute = message.minute;
        if (year != preYear || day != preDay || month != preMonth) {
          var date = Date(message.year, message.month, message.day,
              message.hour, message.minute);
          ret.add(date);
        }
        preDay = day;
        preMonth = month;
        preYear = year;
        preHour = hour;
        preMinute = minute;
      }
      var date = Date(preYear, preMonth, preDay, preHour, preMinute);
      ret.add(date);
      return ret;
    }
  }

  @override
  Future<void> removeMessage(Message message, User user) async {
    await messageSource.removeMessage(message, user);
    emitRemoveMessage(user, message);
  }

  @override
  Future<void> sendMessage(Message message, User user) async {
    await messageSource.sendMessage(message, user);
    emitNewMessage(user, message);
    if (message.timer) {
      Future.delayed(const Duration(minutes: 1)).then(
        (value) {
          removeMessage(message, user);
        },
      );
    }
  }

  @override
  Future<List<User>> loadUsers() async {
    var ret = <User>[];

    var us = await messageSource.loadUsers();
    for (var u in us) {
      ret.add(User.entity(u));
    }
    return ret;
  }
}
