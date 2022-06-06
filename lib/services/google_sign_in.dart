import 'package:code_resto/models/response.dart';
import 'package:code_resto/utils/consts.dart';
import 'package:code_resto/utils/functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSgnIn extends ChangeNotifier {
  GoogleSignIn googleSignIn = GoogleSignIn(
      /*  scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ], */
      );
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  GoogleSignInAccount? googleUser;

  googleLogIn() async {
    try {
      iPrint('11111');

      //shows you the first POPUP to choose the google acoount

      googleUser = await googleSignIn.signIn();
      iPrint('GOOGOGO');
      iPrint(googleUser);
      iPrint('2222');
      // if we didn't choose any user we exit from this function
      if (googleUser == null) return Response({}, false, message: erreurClient);
      iPrint('3333');

      // else
      _user = googleUser;

      // we await until authentication
      final googleAuth = await googleUser?.authentication;

      //get the googleAcount Credential

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      print("credentials");
      print(credential);
      //Finally we will connect with firebase with google credential
      var s = await FirebaseAuth.instance.signInWithCredential(credential);

      notifyListeners();
      //
      return Response({
        'id': googleUser?.id,
        'token': googleAuth?.accessToken,
        'nom': googleUser?.displayName,
        'email': googleUser?.email,
      }, true, message: 'succeed');
    } on PlatformException catch (e) {
      print("errrrrror");
      if (e.code == GoogleSignIn.kNetworkError) {
        String errorMessage =
            "A network error (such as timeout, interrupted connection or unreachable host) has occurred.";
        return Response({}, false, message: erreurCnx);
      } else {
        String errorMessage = "Something went wrong.";
        return Response({}, false, message: erreurCnx);
      }
    }
  }

  googleOut() async {
    try {
      await googleUser?.clearAuthCache();

      await FirebaseAuth.instance.signOut();
    } catch (e) {}
  }
}
