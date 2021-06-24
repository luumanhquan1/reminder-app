import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get getDateOnString {
    String thu = '';
    if (this.weekday == 1) {
      thu = 'Thứ Hai';
    }
    if (this.weekday == 2) {
      thu = 'Thứ Ba';
    }
    if (this.weekday == 3) {
      thu = 'Thứ Tư';
    }
    if (this.weekday == 4) {
      thu = 'Thứ Năm';
    }
    if (this.weekday == 5) {
      thu = 'Thứ Sáu';
    }
    if (this.weekday == 6) {
      thu = 'Thứ Bảy';
    }
    if (this.weekday == 7) {
      thu = 'Chủ Nhật';
    }
    if (this.day == DateTime.now().day &&
        this.month == DateTime.now().month &&
        this.year == DateTime.now().year) {
      return 'Hôm Nay';
    } else if (this.day == DateTime.now().day + 1 &&
        this.month == DateTime.now().month &&
        this.year == DateTime.now().year) {
      return 'Ngày Mai';
    } else if (this.day == DateTime.now().day + 2 &&
        this.month == DateTime.now().month &&
        this.year == DateTime.now().year) {
      return 'Ngày Kia';
    } else {
      return thu + ',ngày ${this.day} tháng ${this.month}, ${this.year}';
    }
  }

  int getTimeInt({bool date, bool time, int hour, int minute}) {
    int h = hour * 60 * 60 * 1000 + minute * 60 * 1000;
    if (date) {
      if (time) {
        int a = DateTime.parse(DateFormat('yyyy-MM-dd').format(this))
                .millisecondsSinceEpoch +
            h +
            1000;
        return a;
      } else {
        int a = DateTime.parse(DateFormat('yyyy-MM-dd').format(this))
            .millisecondsSinceEpoch;
        return a;
      }
    } else {
      return null;
    }
  }

  String getTimeDate(
      {TimeOfDay timeOfDay, bool isTimeSwitch, bool isDateSwitch}) {
    String k = '';
    if (isTimeSwitch) {
      k = "${timeOfDay.hour}:${timeOfDay.minute},ngày ${this.day} thg ${this.month},${this.year}";
    } else {
      k = "ngày ${this.day} thg ${this.month},${this.year}";
    }
    return k;
  }

  String dateTimeFormat() {
    return DateFormat('yyyy-MM-dd').format(this);
  }
}
