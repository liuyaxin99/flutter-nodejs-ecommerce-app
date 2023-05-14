import 'dart:async';
import 'package:dealhub/common/widgets/bottom_bar.dart';
import 'package:dealhub/features/admin/screens/admin_screen.dart';
import 'package:dealhub/features/auth/screens/auth_screen.dart';
import 'package:dealhub/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isVisible = false;

  _SplashScreenState() {
    Timer(const Duration(milliseconds: 2000), () {
      setState(() {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (context) =>
                    Provider.of<UserProvider>(context).user.token.isNotEmpty
                        ? Provider.of<UserProvider>(context).user.type == 'user'
                            ? const BottomBar()
                            : const AdminScreen()
                        : const AuthScreen()),
            (route) => false);
      });
    });

    Timer(const Duration(milliseconds: 10), () {
      setState(() {
        _isVisible =
            true; // Now it is showing fade effect and navigating to Login page
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(255, 153, 0, 1),
            Color.fromRGBO(244, 221, 17, 1)
          ],
          begin: FractionalOffset(0, 0),
          end: FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0,
        duration: const Duration(milliseconds: 1200),
        child: Center(
          child: Container(
            height: 140.0,
            width: 140.0,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 2.0,
                    offset: const Offset(5.0, 3.0),
                    spreadRadius: 2.0,
                  )
                ]),
            child: Center(
              child: ClipOval(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 120,
                  height: 45,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
