import 'package:gamer_tag/domain/model/model.dart';

extension Date on int {
  String toMonth() {
    switch (this) {
      case 1:
        return 'January';
        break;
      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "October";
      case 12:
        return "December";
      default:
        return "Unknown month";
    }
  }
}
extension MinusDate on DateTime {
  DateTime minusHour() {
    var newHour = this.hour - 1;
    var newDay = this.day;
    var newMonth = this.month;
    var newYear = this.year;
    if(newHour <= -1){
      newHour =23;
      newDay -=1;
    }
    if(newDay<1){
      newDay = 30;
      newMonth -=1;
    }
    if(newMonth<1){
      newMonth = 12;
      newYear -=1;
    }
    return DateTime(newYear,newMonth,newDay,newHour,minute);
  }
}