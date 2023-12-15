import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:task_manager_with_getx/ui/controllers/auth_controller.dart';
import 'package:task_manager_with_getx/ui/screens/login_screen.dart';
import 'package:task_manager_with_getx/ui/screens/main_bottom_nav_screen.dart';
import 'package:task_manager_with_getx/ui/widgets/body_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    goToLogin();
  }

  void goToLogin() async {
    final bool isLoggedIn = await Get.find<AuthController>().checkAuthState();
    Future.delayed(const Duration(seconds: 2)).then((value) => {
          Get.offAll(
            isLoggedIn ? const MainBottomNavScreen() : const LoginScreen(),
          ),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BodyBackground(
      child: Center(
        child: SvgPicture.asset(
          "assets/images/logo.svg",
          width: 120,
        ),
      ),
    ));
  }
}
