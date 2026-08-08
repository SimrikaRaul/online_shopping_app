import 'package:firebase_setup/core/utils/string_consts.dart';
import 'package:firebase_setup/shared_widget/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:firebase_setup/shared_widget/custom_elevated_button.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black12),
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: Icon(Icons.arrow_back, size: 20),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              SizedBox(height: 30),
              Text(
                forgotPasswordStr,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Text(
                forgotPasswordText,
                style: TextStyle(color: Colors.black54, height: 1.5),
              ),
              SizedBox(height: 30),
              CustomTextformField(
                hintText: enterYourEmailStr,
                prefixIcon: Icon(Icons.email_outlined, size: 20),
              ),
              Spacer(),
              CustomElevatedButton(
                text: sendStr,
                backgroundColor: Colors.black,
                borderRadius: 30,
                onPressed: () {},
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
