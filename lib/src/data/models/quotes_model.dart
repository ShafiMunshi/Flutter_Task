import 'dart:convert';

import 'package:intl/intl.dart';

QuotesModel quotesModelFromJson(String str) =>
    QuotesModel.fromJson(json.decode(str));

class QuotesModel {
  List<QutesInfo> data;

  QuotesModel({
    required this.data,
  });

  factory QuotesModel.fromJson(Map<String, dynamic> json) => QuotesModel(
        data: List<QutesInfo>.from(
            json["data"].map((x) => QutesInfo.fromJson(x))),
      );
}

class QutesInfo {
  DateTime date;
  String name;
  String category;
  String location;
  

  QutesInfo({
    required this.date,
    required this.name,
    required this.category,
    required this.location,
    
  });

  factory QutesInfo.fromJson(Map<String, dynamic> json) => QutesInfo(
        date:
            DateTime.fromMillisecondsSinceEpoch(int.parse(json["date"]) * 1000),
        name: json["name"],
        category: json["category"],
        location: json["location"],

      );
}

