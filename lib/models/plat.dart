// To parse this JSON data, do
//
//     final plat = platFromJson(jsonString);

import 'dart:convert';

Plat platFromJson(String str) => Plat.fromJson(json.decode(str));

String platToJson(Plat data) => json.encode(data.toJson());

class Plat {
  Plat({
    this.count,
    this.results,
  });

  int? count;
  List<Result>? results;

  factory Plat.fromJson(Map<String, dynamic> json) => Plat(
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
    this.description,
    this.statut,
    this.prix,
    this.image,
    this.tags,
    this.intituleOffreCourte,
    this.intituleOffre,
    this.prixApplicable,
    this.pourcentage,
    this.offre,
    this.titreOffre,
    this.imageAb,
    this.hasOffre,
    this.like,
  });

  String? identifiant;
  String? titre;
  String? description;
  String? statut;
  double? prix;
  String? image;
  List<String>? tags;
  String? intituleOffreCourte;
  String? intituleOffre;
  double? prixApplicable;
  dynamic pourcentage;
  String? offre;
  String? titreOffre;
  String? imageAb;
  bool? hasOffre;
  bool? like;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        identifiant: json["Identifiant"],
        titre: json["titre"],
        description: json["description"],
        statut: json["statut"],
        prix: json["prix"].toDouble(),
        image: json["image"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        intituleOffreCourte: json["intituleOffreCourte"],
        intituleOffre: json["intituleOffre"],
        prixApplicable: json["prixApplicable"].toDouble(),
        pourcentage: json["pourcentage"],
        offre: json["offre"],
        titreOffre: json["titreOffre"],
        imageAb: json["imageAb"],
        hasOffre: json["hasOffre"],
        like: json["like"],
      );

  Map<String, dynamic> toJson() => {
        "Identifiant": identifiant,
        "titre": titre,
        "description": description,
        "statut": statut,
        "prix": prix,
        "image": image,
        "tags": List<dynamic>.from(tags!.map((x) => x)),
        "intituleOffreCourte": intituleOffreCourte,
        "intituleOffre": intituleOffre,
        "prixApplicable": prixApplicable,
        "pourcentage": pourcentage,
        "offre": offre,
        "titreOffre": titreOffre,
        "imageAb": imageAb,
        "hasOffre": hasOffre,
        "like": like,
      };
}
