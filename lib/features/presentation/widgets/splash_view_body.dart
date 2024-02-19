import 'package:flutter/material.dart';
import 'package:notes/features/presentation/views/home_page.dart';

class SplashViewbody extends StatefulWidget {
  const SplashViewbody({super.key});

  @override
  State<SplashViewbody> createState() => _SplashViewbodyState();
}

class _SplashViewbodyState extends State<SplashViewbody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  //This class manages the animation.
  //  It defines the duration, curve, and controls the status of the animation (like playing, stopping, repeating, etc.).
  late Animation<double> fadeAnimation;
  //  This class defines how a value changes over time.
  //  It represents the animation values that change from one value to another within a specified duration.

  @override
  void initState() {
    super.initState();
    initFadeAnimation();
    navigatetoonboarding();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }
  //  the dispose() method is used to release resources, like animation controllers,
  //  when a widget is removed from the screen. It prevents memory leaks and ensures proper cleanup

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
                animation: fadeAnimation,
                builder: (BuildContext context, Widget? child) {
                  return Opacity(
                    opacity: fadeAnimation.value,
                    child: Image.asset(
                      "assests/images/note_logo.png",
                      scale: 3,
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }

  void initFadeAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(animationController);
    animationController.forward();
  }

  void navigatetoonboarding() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 700),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return const HomePage();
        },
      ));
    });
  }
}
