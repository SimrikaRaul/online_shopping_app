import 'package:firebase_setup/core/utils/string_consts.dart';
import 'package:firebase_setup/route/route.dart';
import 'package:firebase_setup/route/route_generator.dart';
import 'package:firebase_setup/shared_widget/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("assets/images/onboarding_image.jpeg", fit: BoxFit.cover),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.5, 1.0],
                colors: [Colors.transparent, Colors.black87],
              ),
            ),
          ),

          Positioned(
            left: 24,
            right: 24,
            bottom: 40,
            child: Column(
              children: [
                Text(
                  welcomeTextStr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  welcomeDownTextStr,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70, fontSize: 15),
                ),

                SizedBox(height: 60),

                Center(
                  child: SizedBox(
                    width: 200,
                    child: CustomElevatedButton(
                      text: getStarted,
                      backgroundColor: Colors.white.withOpacity(0.15),
                      foregroundColor: Colors.white,
                      borderColor: Colors.white,
                      borderRadius: 30,
                      height: 52,
                      onPressed: () {
                        RouteGenerator.navigateToPage(
                          context,
                          Routes.onboardingScreenRoute,
                        );
                      },
                    ),
                  ),
                ),

                SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
