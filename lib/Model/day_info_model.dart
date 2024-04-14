// To parse this JSON data, do
//
//     final dayInfo = dayInfoFromJson(jsonString);

import 'dart:convert';

DayInfo dayInfoFromJson(String str) => DayInfo.fromJson(json.decode(str));

String dayInfoToJson(DayInfo data) => json.encode(data.toJson());

class DayInfo {
  int? id;
  Day? day;
  List<Content>? contents;
  List<Content>? video;

  DayInfo({
    this.id,
    this.day,
    this.contents,
  });

  factory DayInfo.fromJson(Map<String, dynamic> json) => DayInfo(
    id: json["id"],
    day: json["day"] == null ? null : Day.fromJson(json["day"]),
    contents: json["contents"] == null ? [] : List<Content>.from(json["audio"]!.map((x) => Content.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "day": day?.toJson(),
    "contents": contents == null ? [] : List<dynamic>.from(contents!.map((x) => x.toJson())),
  };
}

class Content {
  String? id;
  int contentType;
  String title;
  String? timeDes;
  int duration;
  int watchDuration;
  int? number;
  String? path;

  Content({
    this.contentType = 1,
    this.title = "",
    this.id,
    this.duration = 0,
    this.watchDuration = 0,
    this.timeDes,
    this.path,
    this.number,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    contentType: json["contentType"],
    number: json["number"],
    title: json["title"],
    duration: json["duration"],
    watchDuration: json["watchDuration"],
    timeDes: json["timeDes"],
    path: json["path"],
    id: json["id"],
  );

  Content copyWith({
    int? contentType,
    String? title,
    String? timeDes,
    int? duration,
    int? watchDuration,
    String? path,
    String? id,
    int? number,
  }){
    return Content(
      contentType: contentType ?? this.contentType,
      duration: duration ?? this.duration,
      watchDuration: watchDuration ?? this.watchDuration,
      title: title ?? this.title,
      timeDes: timeDes ?? this.timeDes,
      path: path ?? this.path,
      number: number ?? this.number,
      id: id??this.id
    );
  }

  Map<String, dynamic> toJson() => {
    "contentType": contentType,
    "title": title,
    "duration": duration,
    "watchDuration": watchDuration,
    "timeDes": timeDes,
    "number": number,
    "path": path,
    "id" : id
  };
}

class Day {
  int number;
  String? title;
  String? description;
  bool isIdealProgram;
  double? percent;

  Day({
    this.number = -1,
    this.title,
    this.description,
    this.percent,
    this.isIdealProgram = false
  });


  factory Day.fromJson(Map<String, dynamic> json) => Day(
    number: json["number"],
    title: json["title"],
    description: json["description"],
    percent: json["percent"],
    isIdealProgram: json["isIdealProgram"],
  );

  Map<String, dynamic> toJson() => {
    "number": number,
    "title": title,
    "percent": percent,
    "description": description,
    "isIdealProgram": isIdealProgram,
  };
}

String idealProgramToJson(IdealProgram data) => json.encode(data.toJson());

class IdealProgram {
  String? title;
  int? id;
  List<Content>? content;

  IdealProgram({
    this.title,
    this.id,
    this.content,
  });

  factory IdealProgram.fromJson(Map<String, dynamic> json) => IdealProgram(
    title: json["title"],
    id: json["id"],
    content: json["content"] == null ? [] : List<Content>.from(json["content"]!.map((x) => Content.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "id": id,
    "content": content == null ? [] : List<dynamic>.from(content!.map((x) => x.toJson())),
  };
}

class NinthDayContent {
  String? title;
  int? id;
  List<NinthDayContentItem>? items;

  NinthDayContent({
    this.title,
    this.id,
    this.items,
  });

  factory NinthDayContent.fromJson(Map<String, dynamic> json) => NinthDayContent(
    title: json["title"],
    id: json["id"],
    items: json["items"] == null ? [] : List<NinthDayContentItem>.from(json["items"]!.map((x) => NinthDayContentItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "id": id,
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class NinthDayContentItem {
  String? description;
  int? id;
  Content? content;

  NinthDayContentItem({
    this.description,
    this.id,
    this.content,
  });

  factory NinthDayContentItem.fromJson(Map<String, dynamic> json) => NinthDayContentItem(
    description: json["description"],
    id: json["id"],
    content: json["content"],
  );

  Map<String, dynamic> toJson() => {
    "description": description,
    "id": id,
    "content": content,
  };
}
