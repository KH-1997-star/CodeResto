// To parse this JSON data, do
//
//     final themeModel = themeModelFromJson(jsonString);

import 'dart:convert';

ThemeModel themeModelFromJson(String str) =>
    ThemeModel.fromJson(json.decode(str));

String themeModelToJson(ThemeModel data) => json.encode(data.toJson());

class ThemeModel {
  ThemeModel({
    this.count,
    this.results,
  });

  int? count;
  List<Result>? results;

  factory ThemeModel.fromJson(Map<String, dynamic> json) => ThemeModel(
        count: json["count"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.identifiant,
    this.titre,
    this.logo,
    this.couleurPrincipal,
    this.couleurSecondaire,
    this.autres,
    this.isActive,
  });

  String? identifiant;
  String? titre;
  String? logo;
  String? couleurPrincipal;
  String? couleurSecondaire;
  String? autres;
  String? isActive;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        identifiant: json["Identifiant"],
        titre: json["titre"],
        logo: json["logo"],
        couleurPrincipal: json["couleurPrincipal"],
        couleurSecondaire: json["couleurSecondaire"],
        autres: json["autres"],
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "Identifiant": identifiant,
        "titre": titre,
        "logo": logo,
        "couleurPrincipal": couleurPrincipal,
        "couleurSecondaire": couleurSecondaire,
        "autres": autres,
        "isActive": isActive,
      };
}
