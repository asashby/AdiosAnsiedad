import 'dart:convert';

import 'day_info_model.dart';

PreferenceData preferenceDataFromJson(String str) => PreferenceData.fromJson(json.decode(str));

String preferenceDataToJson(PreferenceData data) => json.encode(data.toJson());

class PreferenceData {
  int? id;
  List<Content>? content;

  PreferenceData({
    this.id,
    this.content,
  });

  factory PreferenceData.fromJson(Map<String, dynamic> json) => PreferenceData(
    id: json["id"],
    content: json["content"] == null ? [] : List<Content>.from(json["content"]!.map((x) => Content.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "content": content == null ? [] : List<dynamic>.from(content!.map((x) => x.toJson())),
  };
}