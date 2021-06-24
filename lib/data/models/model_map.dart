import 'package:flutter/material.dart';
import 'package:ghichu/data/models/prorities.dart';
import 'package:ghichu/data/models/reminder.dart';


import 'group.dart';

class ModelListReminder {
  static Map<String, Map<String, List<Reminder>>> listReminder = {
    'Reminder': {}
  };
  static Map<String, dynamic> myList = {
    'Reminder':''
  };
  static Map<String, dynamic> reminderApp = ReminderApp(reminders: [], groups: [
    Groups(name: 'Reminder', color: Colors.blue.value.toString())
  ], priorities: [
    Priorities(name: 'không có'),
    Priorities(name: 'Thấp'),
    Priorities(name: 'Trung bình'),
    Priorities(name: 'Cao')
  ]).toJson();
}

//
class ReminderApp {
  List<Reminders> reminders;
  List<Groups> groups;
  List<Priorities> priorities;

  ReminderApp({this.reminders, this.groups, this.priorities});

  ReminderApp.fromJson(Map<String, dynamic> json) {
    if (json['reminders'] != null) {
      reminders = new List<Reminders>();
      json['reminders'].forEach((v) {
        reminders.add(new Reminders.fromJson(v));
      });
    }
    if (json['groups'] != null) {
      groups = new List<Groups>();
      json['groups'].forEach((v) {
        groups.add(new Groups.fromJson(v));
      });
    }
    if (json['priorities'] != null) {
      priorities = new List<Priorities>();
      json['priorities'].forEach((v) {
        priorities.add(new Priorities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reminders != null) {
      data['reminders'] = this.reminders.map((v) => v.toJson()).toList();
    }
    if (this.groups != null) {
      data['groups'] = this.groups.map((v) => v.toJson()).toList();
    }
    if (this.priorities != null) {
      data['priorities'] = this.priorities.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
