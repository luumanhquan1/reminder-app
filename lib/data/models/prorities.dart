class Priorities {
  String name;
  String createAt;
  String lastUpdate;

  Priorities({this.name, this.createAt, this.lastUpdate});

  Priorities.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    createAt = json['create_at'];
    lastUpdate = json['last_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['create_at'] = this.createAt;
    data['last_update'] = this.lastUpdate;
    return data;
  }
}