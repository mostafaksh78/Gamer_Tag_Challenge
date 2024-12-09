import 'package:equatable/equatable.dart';

abstract class Entity extends Equatable {}

class MessageEntity extends Entity {
  final String text;
  final int hour;
  final int minute;
  final int day;
  final int month;
  final int year;
  final bool timer;
  final int? readHour;
  final int? readMinute;
  final int? readDay;
  final int? readMonth;
  final int? readYear;
  final bool read;
  final bool sendOrRecieve;

  MessageEntity(this.text, this.year, this.month, this.day, this.hour,
      this.minute, this.read, this.sendOrRecieve,
      {this.readYear,
      this.readMonth,
      this.readDay,
      this.readHour,
      this.readMinute,this.timer = false});

  @override
  List<Object?> get props => [text,hour,minute,day,month,year,timer,readHour,readMonth,readDay,readYear,readMinute,read,sendOrRecieve];
}
