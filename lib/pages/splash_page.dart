import 'package:flutter/material.dart';
import 'package:flutter_application_7/pages/main_layout.dart';
import 'package:get/get.dart';
// import 'home_page.dart';
import 'main_layout.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 2.0,
    ).animate(_animationController);

    _animationController.forward();

    // Navigate to home after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      Get.offAll(() => MainLayout());
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                './assets/icon/icon-rework.png',
                width: 100,
                height: 100,
              ),
              SizedBox(height: 10),
              Text(
                'NowFeed',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Serving the latest news for you!',
                style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.onPrimary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
