// To parse this JSON data, do
//
//     final abonnement = abonnementFromJson(jsonString);

import 'dart:convert';

Abonnement abonnementFromJson(String str) =>
    Abonnement.fromJson(json.decode(str));

String abonnementToJson(Abonnement data) => json.encode(data.toJson());

class Abonnement {
  Abonnement({
    this.count,
    this.results,
  });

  int? count;
  List<Result>? results;

  factory Abonnement.fromJson(Map<String, dynamic> json) => Abonnement(
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
    this.typesAbonnement,
    this.prixHebdomadaireTtc,
    this.prixMensuelTtc,
    this.prixTrimstielTtc,
    this.prixAnnuelTtc,
    this.etat,
    this.statut,
    this.avantage,
    this.typeMenu,
    this.listeMenus,
    this.cumulable,
    this.image,
    this.description,
  });

  String? identifiant;
  String? titre;
  List<String>? typesAbonnement;
  dynamic prixHebdomadaireTtc;
  dynamic prixMensuelTtc;
  dynamic prixTrimstielTtc;
  dynamic prixAnnuelTtc;
  String? etat;
  String? statut;
  List<Avantage>? avantage;
  String? typeMenu;
  List<String>? listeMenus;
  String? cumulable;
  String? image;
  String? description;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        identifiant: json["Identifiant"],
        titre: json["titre"],
        typesAbonnement:
            List<String>.from(json["typesAbonnement"].map((x) => x)),
        prixHebdomadaireTtc: json["prixHebdomadaireTTC"],
        prixMensuelTtc: json["prixMensuelTTC"],
        prixTrimstielTtc: json["prixTrimstielTTC"],
        prixAnnuelTtc: json["prixAnnuelTTC"],
        etat: json["etat"],
        statut: json["statut"],
        avantage: List<Avantage>.from(
            json["avantage"].map((x) => Avantage.fromJson(x))),
        typeMenu: json["typeMenu"],
        listeMenus: List<String>.from(json["listeMenus"].map((x) => x)),
        cumulable: json["cumulable"],
        image: json["image"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "Identifiant": identifiant,
        "titre": titre,
        "typesAbonnement": List<dynamic>.from(typesAbonnement!.map((x) => x)),
        "prixHebdomadaireTTC": prixHebdomadaireTtc,
        "prixMensuelTTC": prixMensuelTtc,
        "prixTrimstielTTC": prixTrimstielTtc,
        "prixAnnuelTTC": prixAnnuelTtc,
        "etat": etat,
        "statut": statut,
        "avantage": List<dynamic>.from(avantage!.map((x) => x.toJson())),
        "typeMenu": typeMenu,
        "listeMenus": List<dynamic>.from(listeMenus!.map((x) => x)),
        "cumulable": cumulable,
        "image": image,
        "description": description,
      };
}

class Avantage {
  Avantage({
    this.identifiant,
    this.etat,
    this.statut,
    this.typeOffre,
    this.nbreOffert,
    this.nbreAchatTotal,
    this.intituleOffre,
    this.pourcentage,
    this.intituleOffreCourte,
  });

  String? identifiant;
  String? etat;
  String? statut;
  String? typeOffre;
  int? nbreOffert;
  int? nbreAchatTotal;
  String? intituleOffre;
  int? pourcentage;
  String? intituleOffreCourte;

  factory Avantage.fromJson(Map<String, dynamic> json) => Avantage(
        identifiant: json["Identifiant"],
        etat: json["etat"],
        statut: json["statut"],
        typeOffre: json["typeOffre"],
        nbreOffert: json["nbreOffert"],
        nbreAchatTotal: json["nbreAchatTotal"],
        intituleOffre: json["intituleOffre"],
        pourcentage: json["pourcentage"],
        intituleOffreCourte: json["intituleOffreCourte"],
      );

  Map<String, dynamic> toJson() => {
        "Identifiant": identifiant,
        "etat": etat,
        "statut": statut,
        "typeOffre": typeOffre,
        "nbreOffert": nbreOffert,
        "nbreAchatTotal": nbreAchatTotal,
        "intituleOffre": intituleOffre,
        "pourcentage": pourcentage,
        "intituleOffreCourte": intituleOffreCourte,
      };
}
