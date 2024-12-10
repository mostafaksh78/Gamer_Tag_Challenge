DateTime startDate = DateTime.now();

extension Date on int {
  String toMonth() {
    switch (this) {
      case 1:
        return 'Jan';
        break;
      case 2:
        return "Feb";
      case 3:
        return "Mrc";
      case 4:
        return "Apr";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "Aug";
      case 9:
        return "Sep";
      case 10:
        return "Oct";
      case 11:
        return "Nov";
      case 12:
        return "Dec";
      default:
        return "Alien Month";
    }
  }

  String toDay() {
    switch(this){
      case 1:
        return "Sat";
      case 2:
        return "Sun";
      case 3:
        return "Mon";
      case 4:
        return "Thu";
      case 5:
        return "Wen";
      case 6:
        return "Thr";
      case 7:
        return "Fri";
      default:
        return "Alien Day";
    }
  }
}

extension MinusDate on DateTime {
  DateTime minusHour() {
    var newHour = hour - 1;
    var newDay = day;
    var newMonth = month;
    var newYear = year;
    if (newHour <= -1) {
      newHour = 23;
      newDay -= 1;
    }
    if (newDay < 1) {
      newDay = 30;
      newMonth -= 1;
    }
    if (newMonth < 1) {
      newMonth = 12;
      newYear -= 1;
    }
    return DateTime(newYear, newMonth, newDay, newHour, minute);
  }
}

extension ConvertDateCompareToDate on DateTime {
  String convert(DateTime start) {
    if (day - start.day == 1) {
      var min = "";
      if (minute < 10) {
        min = "0$minute";
      } else {
        min = "$minute";
      }
      return "Yesterday $hour:$min";
    }
    if (day - start.day == 0) {
      var min = "";
      if (minute < 10) {
        min = "0$minute";
      } else {
        min = "$minute";
      }
      return "Today $hour:$min";
    }
    var min = "";
    if (minute < 10) {
      min = "0$minute";
    } else {
      min = "$minute";
    }
    return "${weekday.toDay()}, ${month.toMonth()} $day, $hour:$min";
  }
}
