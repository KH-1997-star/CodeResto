// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

List<Profile> profileFromJson(String str) =>
    List<Profile>.from(json.decode(str).map((x) => Profile.fromJson(x)));

String profileToJson(List<Profile> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Profile {
  Profile({
    this.identifiant,
    this.nom,
    this.prenom,
    this.email,
    this.phone,
    this.aPropos,
    this.photoProfil,
    this.addresse,
    this.ville,
    this.pays,
    this.codePostal,
    this.position,
    this.tempsLivraison,
    this.timeLivraison,
    this.isActive,
    this.role,
  });

  dynamic identifiant;
  dynamic nom;
  dynamic prenom;
  dynamic email;
  dynamic phone;
  dynamic aPropos;
  dynamic photoProfil;
  dynamic addresse;
  dynamic ville;
  dynamic pays;
  dynamic codePostal;
  dynamic position;
  dynamic tempsLivraison;
  dynamic timeLivraison;
  dynamic isActive;
  dynamic role;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        identifiant: json["Identifiant"],
        nom: json["nom"],
        prenom: json["prenom"],
        email: json["email"],
        phone: json["phone"],
        aPropos: json["aPropos"],
        photoProfil: json["photoProfil"],
        addresse: json["addresse"],
        ville: json["ville"],
        pays: json["pays"],
        codePostal: json["codePostal"],
        position: json["position"],
        tempsLivraison: json["tempsLivraison"],
        timeLivraison: json["timeLivraison"],
        isActive: json["isActive"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "Identifiant": identifiant,
        "nom": nom,
        "prenom": prenom,
        "email": email,
        "phone": phone,
        "aPropos": aPropos,
        "photoProfil": photoProfil,
        "addresse": addresse,
        "ville": ville,
        "pays": pays,
        "codePostal": codePostal,
        "position": position,
        "tempsLivraison": tempsLivraison,
        "timeLivraison": timeLivraison,
        "isActive": isActive,
        "role": role,
      };
}
