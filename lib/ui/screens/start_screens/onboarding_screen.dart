import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';
import '../auth_screens/auth_choose_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  static const routeName = "/onboarding-screen";

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    setOnBoardingShownTrue();
    Navigator.of(context)
        .pushReplacementNamed(AuthChooseScreen.routeName);
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset(
        "assets/images/$assetName",
        width: 250,
      ),
      alignment: Alignment.bottomCenter,
    );
  }

  setOnBoardingShownTrue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() async {
      await prefs.setBool('onBoardingShown', true);
    });
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(
      fontSize: 22,
      color: Colors.white,
    );

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16, 10, 16, 16),
      pageColor: primaryColor,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "",
          body: "Size yazılan reçeteleri görebilirsiniz.",
          image: _buildImage("prescription.png"),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "",
          body: "Zamanı gelen ilaçlar hakkında bildirim alabilirsiniz.",
          image: _buildImage("pills.png"),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "",
          body: "Doktorunuz hakkında bilgi edinebilirsiniz.",
          image: _buildImage("stethoscope.png"),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      showSkipButton: false,
      skipFlex: 0,
      nextFlex: 0,
      next: const Icon(
        Icons.arrow_forward,
        color: Colors.white,
      ),
      done: const Text(
        "Başla",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: darkGrayColor,
        activeColor: Colors.white,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
