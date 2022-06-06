// To parse this JSON data, do
//
//     final tags = tagsFromJson(jsonString);

import 'dart:convert';

Tags tagsFromJson(String str) => Tags.fromJson(json.decode(str));

String tagsToJson(Tags data) => json.encode(data.toJson());

class Tags {
  Tags({
    this.results,
    this.count,
  });

  List<Result>? results;
  int? count;

  factory Tags.fromJson(Map<String, dynamic> json) => Tags(
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
        "count": count,
      };
}

class Result {
  Result({
    this.identifiant,
    this.libelle,
    this.description,
    this.statut,
    this.isActive,
    this.dateCreation,
    this.dateLastModif,
  });

  String? identifiant;
  String? libelle;
  String? description;
  String? statut;
  String? isActive;
  DateTime? dateCreation;
  DateTime? dateLastModif;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        identifiant: json["Identifiant"],
        libelle: json["libelle"],
        description: json["description"],
        statut: json["statut"],
        isActive: json["isActive"],
        dateCreation: DateTime.parse(json["dateCreation"]),
        dateLastModif: DateTime.parse(json["dateLastModif"]),
      );

  Map<String, dynamic> toJson() => {
        "Identifiant": identifiant,
        "libelle": libelle,
        "description": description,
        "statut": statut,
        "isActive": isActive,
        "dateCreation": dateCreation!.toIso8601String(),
        "dateLastModif": dateLastModif!.toIso8601String(),
      };
}
