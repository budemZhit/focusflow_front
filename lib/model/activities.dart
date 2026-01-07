class Categories {
  List<Activities>? activities;

  Categories({this.activities});

  Categories.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      activities = <Activities>[];
      json['categories'].forEach((v) {
        activities!.add(Activities.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (activities != null) {
      data['categories'] = activities!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString(){
    return activities.toString();
  }
}

class Activities {
  int? id;
  String? key;
  String? name;
  int? color;

  Activities({this.id, this.key, this.name, this.color});

  Activities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    name = json['name'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['key'] = key;
    data['name'] = name;
    data['color'] = color;
    return data;
  }

  @override
  String toString(){
    return "{"
        "id: $id,"
        "key: $key,"
        "name: $name,"
        "color: $color"
        "}";
  }
}