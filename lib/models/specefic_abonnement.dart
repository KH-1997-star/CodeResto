// To parse this JSON data, do
//
//     final speceficAbonnement = speceficAbonnementFromJson(jsonString);

import 'dart:convert';

SpeceficAbonnement speceficAbonnementFromJson(String str) =>
    SpeceficAbonnement.fromJson(json.decode(str));

String speceficAbonnementToJson(SpeceficAbonnement data) =>
    json.encode(data.toJson());

class SpeceficAbonnement {
  SpeceficAbonnement({
    this.count,
    this.results,
  });

  int? count;
  List<Result>? results;

  factory SpeceficAbonnement.fromJson(Map<String, dynamic> json) =>
      SpeceficAbonnement(
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
    this.linkedOptionAbonnements,
    this.expidation,
    this.statut,
    this.prixTtc,
    this.linkedCompte,
    this.typeAbonnement,
    this.idPaiement,
    this.modePaiement,
    this.statutPaiement,
  });

  String? identifiant;
  List<LinkedOptionAbonnement>? linkedOptionAbonnements;
  Expidation? expidation;
  String? statut;
  dynamic prixTtc;
  String? linkedCompte;
  String? typeAbonnement;
  String? idPaiement;
  String? modePaiement;
  String? statutPaiement;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        identifiant: json["Identifiant"],
        linkedOptionAbonnements: List<LinkedOptionAbonnement>.from(
            json["linkedOptionAbonnements"]
                .map((x) => LinkedOptionAbonnement.fromJson(x))),
        expidation: Expidation.fromJson(json["expidation"]),
        statut: json["statut"],
        prixTtc: json["prixTTC"],
        linkedCompte: json["linkedCompte"],
        typeAbonnement: json["typeAbonnement"],
        idPaiement: json["idPaiement"],
        modePaiement: json["modePaiement"],
        statutPaiement: json["statutPaiement"],
      );

  Map<String, dynamic> toJson() => {
        "Identifiant": identifiant,
        "linkedOptionAbonnements":
            List<dynamic>.from(linkedOptionAbonnements!.map((x) => x.toJson())),
        "expidation": expidation!.toJson(),
        "statut": statut,
        "prixTTC": prixTtc,
        "linkedCompte": linkedCompte,
        "typeAbonnement": typeAbonnement,
        "idPaiement": idPaiement,
        "modePaiement": modePaiement,
        "statutPaiement": statutPaiement,
      };
}

class Expidation {
  Expidation({
    this.date,
    this.timezoneType,
    this.timezone,
  });

  DateTime? date;
  int? timezoneType;
  String? timezone;

  factory Expidation.fromJson(Map<String, dynamic> json) => Expidation(
        date: DateTime.parse(json["date"]),
        timezoneType: json["timezone_type"],
        timezone: json["timezone"],
      );

  Map<String, dynamic> toJson() => {
        "date": date!.toIso8601String(),
        "timezone_type": timezoneType,
        "timezone": timezone,
      };
}

class LinkedOptionAbonnement {
  LinkedOptionAbonnement({
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
  String? avantage;
  String? typeMenu;
  List<dynamic>? listeMenus;

  factory LinkedOptionAbonnement.fromJson(Map<String, dynamic> json) =>
      LinkedOptionAbonnement(
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
        avantage: json["avantage"],
        typeMenu: json["typeMenu"],
        listeMenus: List<dynamic>.from(json["listeMenus"].map((x) => x)),
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
        "avantage": avantage,
        "typeMenu": typeMenu,
        "listeMenus": List<dynamic>.from(listeMenus!.map((x) => x)),
      };
}
