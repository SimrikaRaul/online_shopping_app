import 'package:firebase_setup/core/utils/string_consts.dart';

import 'package:firebase_setup/shared_widget/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class DiscoverScreenBody extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final VoidCallback onButtonPressed;

  DiscoverScreenBody({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Fixed-ratio split background
        Column(
          children: [
            Expanded(flex: 55, child: Container(color: Colors.white)),
            Expanded(flex: 45, child: Container(color: Color(0xFF3A3A3D))),
          ],
        ),

        // Foreground content
        SafeArea(
          child: Column(
            children: [
              SizedBox(height: 40),
              Text(
                title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                subtitle,
                style: TextStyle(fontSize: 15, color: Colors.black54),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 60),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: CustomElevatedButton(
                  text: shoppingNowStr,
                  backgroundColor: Colors.white.withOpacity(0.15),
                  foregroundColor: Colors.white,
                  borderColor: Colors.white,
                  borderRadius: 30,
                  onPressed: onButtonPressed,
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ],
    );
  }
}
