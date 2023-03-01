import 'dart:async';

import 'package:contactouaty/ui/create_card_page.dart';
import 'package:contactouaty/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  String _userCard = "";
  @override
  void initState() {
    super.initState();
    _loadUserCard();
    Timer(
        const Duration(milliseconds: 2000),
        () =>
            //todo("update this")
            // Navigator.popAndPushNamed(context, routeName);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => (_userCard.isEmpty)
                      ? const CreateCardPage()
                      : HomePage()),
            ));
  }

  Future<void> _loadUserCard() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userCard = (prefs.getString('user_card') ?? "");
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        body: Container(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/images/profile.jpg",
                  ),
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Text(
                  'Contactouaty',
                  style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: "Pacifico"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
