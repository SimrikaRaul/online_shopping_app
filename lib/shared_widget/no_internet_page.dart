import 'package:firebase_setup/shared_widget/custom_elevated_button.dart';
import 'package:flutter/material.dart';

class NoInternetPage extends StatelessWidget {
  Function()? onPressed;
  NoInternetPage({super.key,this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.wifi_off, size: 80, color: Colors.grey.shade400),
              SizedBox(height: 24),
              Text(
                "No Internet Connection",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Please check your connection and try again",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              ),
              SizedBox(height: 32),
              CustomElevatedButton(
                text: "Retry",
                backgroundColor: Color(0xffcf342f),
                borderRadius: 12,
                height: 50,
                onPressed: onPressed
              ),
            ],
          ),
        ),
      ),
    );
  }
}
