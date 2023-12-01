
import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/core/utils/widgets/routers.dart';
import 'package:digitalis_restaurant_app/module/account/account_view_page.dart';
import 'package:digitalis_restaurant_app/module/start/presentation/onBoarding_screen/on_boarding_screen.dart';
import 'package:digitalis_restaurant_app/module/start/presentation/splash_screen/widgets/splash_screen_body.dart';
import 'package:digitalis_restaurant_app/provider/database/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static String routeName = "/splash";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    checkFirstRun();
  }

  Future<void> checkFirstRun() async {
    WidgetsFlutterBinding.ensureInitialized();
    final prefs = await SharedPreferences.getInstance();
   // final isFirstRun = prefs.getBool('isFirstRun') ?? true;

    await Future.delayed(Duration(seconds: 5), () {
      DatabaseProvider().getToken().then((value) {
        if (value == '') {
          Navigator.pushNamed(context, OnBoardingScreen.routeName);
        } else {
          Navigator.pushNamed(context, AccountViewPage.routeName);
        }
      });
    });

    /* if (isFirstRun) {
      Navigator.of(context).pushReplacementNamed('/onboarding');
    } else {
      Navigator.of(context).pushReplacementNamed('/home');
    } */
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const Scaffold(
      body: SplashScreenBody(),
    );
  }
}



/* import 'package:digitalis_restaurant_app/core/utils/size_config.dart';
import 'package:digitalis_restaurant_app/module/start/presentation/splash_screen/widgets/splash_screen_body.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static String routeName = "/splash";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const Scaffold(
      body: SplashScreenBody(),
    );
  }
} */