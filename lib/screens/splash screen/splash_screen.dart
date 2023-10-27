import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/screens/splash%20screen/splash_services.dart';
import 'package:instagram_clone/utills/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  CheckUserState splashServices = CheckUserState();
  @override
  void initState() {
    super.initState();
    //addData();
    splashServices.islogin(context);
  }

  // addData() async {
  //   UserProivder _userProvider = Provider.of(context, listen: false);
  //   await _userProvider.refreshUser();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          "assets/images/ic_instagram.svg",
          color: primaryColor,
        ),
      ),
    );
  }
}
