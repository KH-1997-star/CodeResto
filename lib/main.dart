// @dart=2.9
import 'package:code_resto/models/color_model.dart';
import 'package:code_resto/screens/abonnemant_screeen.dart';
import 'package:code_resto/screens/code_qr_screen.dart';
import 'package:code_resto/screens/detail_menu_screen.dart';
import 'package:code_resto/screens/edit_profile_screen.dart';
import 'package:code_resto/screens/favoris_screen.dart';
import 'package:code_resto/screens/first_screen.dart';
import 'package:code_resto/screens/forget_password_one_screen.dart';
import 'package:code_resto/screens/home_screen.dart';
import 'package:code_resto/screens/leading_screen.dart';
import 'package:code_resto/screens/login_screen.dart';
import 'package:code_resto/screens/myvalid_email_screen.dart';
import 'package:code_resto/screens/oops404_screen.dart';
import 'package:code_resto/screens/panier_screen.dart';
import 'package:code_resto/screens/profile_screen.dart';
import 'package:code_resto/screens/recap_screen.dart';
import 'package:code_resto/screens/sign_up_screen.dart';
import 'package:code_resto/screens/type_commande_screen.dart';
import 'package:code_resto/services/favoris_repo.dart';
import 'package:code_resto/services/profile_repo.dart';
import 'package:code_resto/services/theme_repo.dart';
import 'package:code_resto/utils/colors.dart';
import 'package:code_resto/utils/functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'screens/forget_password_three.dart';
import 'screens/forget_password_two_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51KyGBWGPdMzPfqhtjDVHLjPaTyhvJmj3SZ6MhpvgpaXlgmvAfQtC2LOA964bHKc5atUu7XFvQWbsUkXTtaO2anEk00aEOFXVd6";

  await Stripe.instance.applySettings();
  getThemee() async {
    await themerep.getTheme().then((value) {
      print("maiiiin");
      print(value);
      dataTheme = value;
    });
  }

  await getThemee();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => ProfileRepo()),
      ChangeNotifierProvider(create: (_) => FavorisRepo()),
    ], child: const MyApp()),
  );
}

ThemeRepo themerep = ThemeRepo();
ThemeModel dataTheme = ThemeModel();

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: 'Poppins',
            primaryColor:
                HexColor(dataTheme.results[0].couleurPrincipal ?? 'ff000000'),
            secondaryHeaderColor:
                HexColor(dataTheme.results[0].couleurSecondaire ?? 'ff78FFE4'),
            scaffoldBackgroundColor: Colors.white,
            primarySwatch: Colors.blue,
            appBarTheme: const AppBarTheme(
              centerTitle: true,
              titleTextStyle: TextStyle(
                color: myBlack,
                fontSize: 20,
              ),
              elevation: 0,
              backgroundColor: myWhite,
            )),
        initialRoute: '/',
        routes: {
          '/': (context) => const LeadingScreen(),
          '/first_screen': (context) => const FirstScreen(),
          '/signup_screen': (context) => const SignInScreen(),
          '/login_screen': (context) => const LoginScreen(),
          '/type_commande': (context) => const TypeCommandeScreen(),
          '/code_qr_screen': (context) => const CodeQrScreen(),
          '/home_screen': (context) => const HomeScreen(),
          '/panier_screen': (context) => const PanierScreen(),
          '/favoris_screen': (context) => const FavorisScreen(),
          '/detail_menu_screen': (context) => const DetailMenuScreen(
                index: 0,
                imagePath: 'plateau-repas.png',
                id: '',
              ),
          '/profile_screen': (context) => const ProfileScreen(),
          '/edit_profile_screen': (context) => const EditProfileScreen(),
          '/validate_email_screen': (context) => const ValidateEmailScreen(),
          '/forgetPwdOne': (context) => const ForgetPwdOneScreen(),
          '/forgetPwdTwo': (context) => const ForgetPwdTwoScreen(),
          '/forgetPwdThree': (context) => const ForgetPwdThreeScreen(),
          '/abonnement_screen': (context) => AbonnementScreen(),
          '/recap_screen': (context) => const RecapScreen(),
          '/oops_404': (context) => const Oops404Screen(),
        },
      ),
    );
  }
}
