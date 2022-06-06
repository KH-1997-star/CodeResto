import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

const hostDynamique = 'http://51.83.99.222:8052/';
const tokenconst = "token";
const idConst = 'id';
const idAnonym = 'idAnonym';
const idPanier = 'idPanier';
const idCommande = 'idCommande';
const logoShare = 'logo';
const erreurUlterieur =
    'une erreur s\'est produite veuillez réessayer ultérieurement';
MaskTextInputFormatter? maskFormatter = MaskTextInputFormatter(
    mask: '+33 # ## ## ## ##', filter: {"#": RegExp(r'[0-9]')});

const erreurCnx =
    'une érreur c\'est produite veuillez vérifier votre connexion internet et réessayer';
const erreurClient =
    'il semble qu\'il y ait une erreur veuillez vérifier vos informations puis réessayer de nouveau';
