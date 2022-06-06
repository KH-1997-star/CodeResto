import 'package:code_resto/utils/consts.dart';

String urlLogin = '${hostDynamique}login',
    urlSignUp = '${hostDynamique}inscription',
    urlAllTags = '${hostDynamique}readAll/tags?isActive=1&statut=created',
    urlSearchByWord = '${hostDynamique}rechercheMenuByWord',
    urlDetailMenu = '${hostDynamique}detailsMenu/',
    urlGetMonPanier = '${hostDynamique}getMonPanier',
    urlActiv = hostDynamique + "account/checkCodeActivationCompte",
    urlResend = hostDynamique + "reEnvoyerCodeActivation",
    urlSignInDirect = '${hostDynamique}inscriptionDirect',
    urlAjoutPanier = '${hostDynamique}ajoutMenuAuPanier',
    urlCreateCommand = '${hostDynamique}api/client/createCommande',
    urlUpdatePanier = '${hostDynamique}updateMenuAuPanier',
    urlSuppMenu = '${hostDynamique}removeProduitFromPanier';
final urlModeLiv =
    '${hostDynamique}api/client/affecterAddresseLivraisonToCommande';
final urlTheme =
    '${hostDynamique}readAll/themes?isActive=1&vueAvancer=themes_multi';
