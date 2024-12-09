import 'package:gamer_tag/data/entity/message.dart';
import 'package:gamer_tag/utils.dart';

mixin DateParser on Entity {
  String get date;
}
mixin ReadDateParser on Entity {
  String get readDate;
}

class Message extends MessageEntity with ReadDateParser, DateParser {
  Message(super.text, super.year, super.month, super.day, super.hour,
      super.minute, super.read, super.sendOrRecieve,
      {super.readYear,
      super.readMonth,
      super.readDay,
      super.readHour,
      super.readMinute,super.timer});

  Message.entity(MessageEntity entity)
      : this(entity.text, entity.year, entity.month, entity.day, entity.hour,
            entity.month, entity.read, entity.sendOrRecieve,
            readYear: entity.readYear,
            readMonth: entity.readMonth,
            readDay: entity.readDay,
            readHour: entity.readHour,
            readMinute: entity.readMinute,timer: entity.timer);

  @override
  String get date =>"$year :${month.toMonth()} $day";

  @override
  String get readDate => "$readHour:$readMinute";
}

class Date extends Entity with DateParser {
  final int hour;
  final int year;
  final int minute;
  final int day;
  final int month;

  Date(this.year, this.month, this.day, this.hour, this.minute);

  @override
  String get date => "$year :${month.toMonth()} $day";

  @override
  List<Object?> get props => [year,month,day,hour,minute];
}
