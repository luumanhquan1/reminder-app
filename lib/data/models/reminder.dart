import 'dart:core';

class Reminder{
  String title,note,priority,group;
  int date;
  int createAt,lastUpdate;
  bool time;
  Reminder(this.title, this.note,this.group,this.priority, this.date,
      this.createAt,this.lastUpdate,this.time);
}
//
class Reminders {
  String title;
  String notes;
  Details details;
  String list;
  String createAt;
  String lastUpdate;

  Reminders(
      {this.title,
        this.notes,
        this.details,
        this.list,
        this.createAt,
        this.lastUpdate});

  Reminders.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    notes = json['notes'];
    details =
    json['details'] != null ? new Details.fromJson(json['details']) : null;
    list = json['list'];
    createAt = json['create_at'];
    lastUpdate = json['last_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['notes'] = this.notes;
    if (this.details != null) {
      data['details'] = this.details.toJson();
    }
    data['list'] = this.list;
    data['create_at'] = this.createAt;
    data['last_update'] = this.lastUpdate;
    return data;
  }
}

class Details {
  String date;
  String time;
  String priority;

  Details({this.date, this.time, this.priority});

  Details.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    time = json['time'];
    priority = json['priority'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['time'] = this.time;
    data['priority'] = this.priority;
    return data;
  }
}