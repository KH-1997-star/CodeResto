// To parse this JSON data, do
//
//     final favoris = favorisFromJson(jsonString);

import 'dart:convert';

Favoris favorisFromJson(String str) => Favoris.fromJson(json.decode(str));

String favorisToJson(Favoris data) => json.encode(data.toJson());

class Favoris {
  Favoris({
    this.count,
    this.results,
  });

  int? count;
  List<Result>? results;

  factory Favoris.fromJson(Map<String, dynamic> json) => Favoris(
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
    this.compte,
    this.menu,
  });

  String? identifiant;
  String? compte;
  List<Menu>? menu;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        identifiant: json["Identifiant"],
        compte: json["compte"],
        menu: List<Menu>.from(json["menu"].map((x) => Menu.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Identifiant": identifiant,
        "compte": compte,
        "menu": List<dynamic>.from(menu!.map((x) => x.toJson())),
      };
}

class Menu {
  Menu({
    this.identifiant,
    this.titre,
    this.description,
    this.statut,
    this.linkedRestaurant,
    this.prix,
    this.image,
    this.tags,
    this.tailles,
    this.sauces,
    this.viandes,
    this.garnitures,
    this.boisons,
    this.autres,
    this.isActive,
    this.categorie,
    this.prixT,
    this.prixS,
    this.prixV,
    this.prixG,
    this.prixB,
  });

  String? identifiant;
  String? titre;
  String? description;
  String? statut;
  String? linkedRestaurant;
  double? prix;
  String? image;
  List<String>? tags;
  List<Taille>? tailles;
  List<Boison>? sauces;
  List<Boison>? viandes;
  List<Boison>? garnitures;
  List<Boison>? boisons;
  List<Boison>? autres;
  String? isActive;
  List<dynamic>? categorie;
  String? prixT;
  String? prixS;
  String? prixV;
  String? prixG;
  String? prixB;

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        identifiant: json["Identifiant"],
        titre: json["titre"],
        description: json["description"],
        statut: json["statut"],
        linkedRestaurant: json["linkedRestaurant"],
        prix: json["prix"].toDouble(),
        image: json["image"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        tailles:
            List<Taille>.from(json["tailles"].map((x) => Taille.fromJson(x))),
        sauces:
            List<Boison>.from(json["sauces"].map((x) => Boison.fromJson(x))),
        viandes:
            List<Boison>.from(json["viandes"].map((x) => Boison.fromJson(x))),
        garnitures: List<Boison>.from(
            json["garnitures"].map((x) => Boison.fromJson(x))),
        boisons:
            List<Boison>.from(json["boisons"].map((x) => Boison.fromJson(x))),
        autres: json["autres"] == null
            ? null
            : List<Boison>.from(json["autres"].map((x) => Boison.fromJson(x))),
        isActive: json["isActive"],
        categorie: json["categorie"] == null
            ? null
            : List<dynamic>.from(json["categorie"].map((x) => x)),
        prixT: json["prixT"],
        prixS: json["prixS"],
        prixV: json["prixV"],
        prixG: json["prixG"],
        prixB: json["prixB"],
      );

  Map<String, dynamic> toJson() => {
        "Identifiant": identifiant,
        "titre": titre,
        "description": description,
        "statut": statut,
        "linkedRestaurant": linkedRestaurant,
        "prix": prix,
        "image": image,
        "tags": List<dynamic>.from(tags!.map((x) => x)),
        "tailles": List<dynamic>.from(tailles!.map((x) => x.toJson())),
        "sauces": List<dynamic>.from(sauces!.map((x) => x.toJson())),
        "viandes": List<dynamic>.from(viandes!.map((x) => x.toJson())),
        "garnitures": List<dynamic>.from(garnitures!.map((x) => x.toJson())),
        "boisons": List<dynamic>.from(boisons!.map((x) => x.toJson())),
        "autres": autres == null
            ? null
            : List<dynamic>.from(autres!.map((x) => x.toJson())),
        "isActive": isActive,
        "categorie": categorie == null
            ? null
            : List<dynamic>.from(categorie!.map((x) => x)),
        "prixT": prixT,
        "prixS": prixS,
        "prixV": prixV,
        "prixG": prixG,
        "prixB": prixB,
      };
}

class Boison {
  Boison({
    this.qteMax,
    this.qteMin,
    this.titre,
    this.produits,
  });

  int? qteMax;
  int? qteMin;
  String? titre;
  List<Produit>? produits;

  factory Boison.fromJson(Map<String, dynamic> json) => Boison(
        qteMax: json["qteMax"],
        qteMin: json["qteMin"],
        titre: json["titre"],
        produits: List<Produit>.from(
            json["produits"].map((x) => Produit.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "qteMax": qteMax,
        "qteMin": qteMin,
        "titre": titre,
        "produits": List<dynamic>.from(produits!.map((x) => x.toJson())),
      };
}

class Produit {
  Produit({
    this.id,
    this.prixFacculatitf,
  });

  String? id;
  int? prixFacculatitf;

  factory Produit.fromJson(Map<String, dynamic> json) => Produit(
        id: json["id"],
        prixFacculatitf: json["prixFacculatitf"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "prixFacculatitf": prixFacculatitf,
      };
}

class Taille {
  Taille({
    this.prix,
    this.id,
  });

  int? prix;
  String? id;

  factory Taille.fromJson(Map<String, dynamic> json) => Taille(
        prix: json["prix"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "prix": prix,
        "id": id,
      };
}
