import 'package:flutter/cupertino.dart';


//
class Groups {
  String name;
  String color;
  String createAt;
  String lastUpdate;

  Groups({this.name, this.color, this.createAt, this.lastUpdate});

  Groups.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    color = json['color'];
    createAt = json['create_at'];
    lastUpdate = json['last_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['color'] = this.color;
    data['create_at'] = this.createAt;
    data['last_update'] = this.lastUpdate;
    return data;
  }
}