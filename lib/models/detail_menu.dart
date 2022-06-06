// To parse this JSON data, do
//
//     final detailMenu = detailMenuFromJson(jsonString);

import 'dart:convert';

List<DetailMenu> detailMenuFromJson(String str) =>
    List<DetailMenu>.from(json.decode(str).map((x) => DetailMenu.fromJson(x)));

String detailMenuToJson(List<DetailMenu> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DetailMenu {
  DetailMenu({
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
    this.categorie,
    this.like,
    this.hasOffre,
    this.imageAb,
    this.intituleOffre,
    this.intituleOffreCourte,
    this.offre,
    this.pourcentage,
    this.prixApplicable,
    this.titreOffre,
  });

  dynamic identifiant;
  dynamic titre;
  dynamic description;
  dynamic statut;
  dynamic linkedRestaurant;
  dynamic prix;
  String? image;
  List<dynamic>? tags;
  List<Taille>? tailles;
  List<Boison>? sauces;
  List<Boison>? viandes;
  List<Boison>? garnitures;
  List<Boison>? boisons;
  List<dynamic>? autres;
  dynamic categorie;
  bool? like;
  String? intituleOffreCourte;
  String? intituleOffre;
  dynamic prixApplicable;
  dynamic pourcentage;
  String? offre;
  String? titreOffre;
  String? imageAb;
  bool? hasOffre;

  factory DetailMenu.fromJson(Map<String, dynamic> json) => DetailMenu(
        identifiant: json["Identifiant"],
        titre: json["titre"],
        description: json["description"],
        statut: json["statut"],
        linkedRestaurant: json["linkedRestaurant"],
        prix: json["prix"].toDouble(),
        image: json["image"],
        tags: List<dynamic>.from(json["tags"].map((x) => x)),
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
        autres: List<dynamic>.from(json["autres"].map((x) => x)),
        categorie: json['categorie'],
        like: json['like'],
        intituleOffreCourte: json['intituleOffreCourte'],
        intituleOffre: json['intituleOffre:'],
        prixApplicable: json['prixApplicable'],
        pourcentage: json['pourcentage'],
        offre: json['offre'],
        titreOffre: json['titreOffre'],
        imageAb: json['imageAb'],
        hasOffre: json['hasOffre'],
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
        "autres": List<dynamic>.from(autres!.map((x) => x)),
        "categorie": categorie,
        'like': like,
        'intituleOffreCourte': intituleOffreCourte,
        'intituleOffre': intituleOffre,
        'prixApplicable': prixApplicable,
        'pourcentage': pourcentage,
        'offre': offre,
        'titreOffre': titreOffre,
        'imageAb': imageAb,
        'hasOffre': hasOffre,
      };
}

class Boison {
  Boison({
    this.titre,
    this.qteMax,
    this.qteMin,
    this.produits,
  });
  dynamic titre;
  dynamic qteMax;
  dynamic qteMin;
  List<Produit>? produits;

  factory Boison.fromJson(Map<String, dynamic> json) => Boison(
        titre: json['titre'],
        qteMax: json["qteMax"],
        qteMin: json["qteMin"],
        produits: List<Produit>.from(
            json["produits"].map((x) => Produit.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'titre': titre,
        "qteMax": qteMax,
        "qteMin": qteMin,
        "produits": List<dynamic>.from(produits!.map((x) => x.toJson())),
      };
}

class Produit {
  Produit({
    this.id,
    this.prixFacculatitf,
    this.name,
  });

  dynamic id;
  dynamic prixFacculatitf;
  dynamic name;

  factory Produit.fromJson(Map<String, dynamic> json) => Produit(
        id: json["id"],
        prixFacculatitf: json["prixFacculatitf"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "prixFacculatitf": prixFacculatitf,
        "name": name,
      };
}

class Taille {
  Taille({
    this.id,
    this.prix,
    this.name,
  });

  dynamic id;
  dynamic prix;
  dynamic name;

  factory Taille.fromJson(Map<String, dynamic> json) => Taille(
        id: json["id"],
        prix: json["prix"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "prix": prix,
        "name": name,
      };
}
