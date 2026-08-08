import 'package:firebase_setup/core/utils/status_utils.dart';
import 'package:firebase_setup/core/utils/string_consts.dart';
import 'package:firebase_setup/core/utils/validators.dart';
import 'package:firebase_setup/feature/signup/bloc/signup_bloc.dart';
import 'package:firebase_setup/feature/signup/bloc/signup_event.dart';
import 'package:firebase_setup/feature/signup/bloc/signup_state.dart';
import 'package:firebase_setup/shared_widget/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_setup/shared_widget/custom_elevated_button.dart';
import 'package:firebase_setup/route/route.dart';
import 'package:firebase_setup/route/route_generator.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                Text(createStr, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                SizedBox(height: 12),
                Text(yourAccountStr, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                CustomTextformField(
                  hintText: enterNameStr,
                  controller: _nameController,
                  validator: Validators.name,
                ),
                SizedBox(height: 20),
                CustomTextformField(
                  controller: _emailController,
                  hintText: emailAddressStr,
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.email,
                ),
                SizedBox(height: 20),
                CustomTextformField(
                  controller: _passwordController,
                  hintText: passwordStr,
                  obscureText: true,
                  validator: Validators.password,
                ),
                SizedBox(height: 20),
                CustomTextformField(
                  controller: _confirmPasswordController,
                  hintText: confirmPasswordStr,
                  obscureText: true,
                  validator: (value) =>
                      Validators.confirmPassword(value, _passwordController.text),
                ),
                SizedBox(height: 60),
                BlocConsumer<SignUpBloc, SignUpState>(
                  listener: (context, state) {
                    if (state.status == StatusUtils.success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message ?? 'Signed up successfully')),
                      );
                      RouteGenerator.navigateToPageWithoutStack(context, Routes.loginRoute);
                    } else if (state.status == StatusUtils.failure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message ?? 'Signup failed')),
                      );
                    }
                  },
                  builder: (context, state) {
                    final isLoading = state.status == StatusUtils.loading;
                    return CustomElevatedButton(
                      backgroundColor: Colors.black,
                      borderRadius: 30,
                      onPressed: isLoading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                context.read<SignUpBloc>().add(
                                  SignupButtonEvent(
                                    name: _nameController.text,
                                    emailAddress: _emailController.text,
                                    password: _passwordController.text,
                                    confirmPassword: _confirmPasswordController.text,
                                  ),
                                );
                              }
                            },
                      child: isLoading
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                            )
                          : Text(signUpStr, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                    );
                  },
                ),
                SizedBox(height: 40),
                Center(child: Text(orSignUpStr, style: TextStyle(color: Colors.black54))),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _socialIcon('assets/images/apple.png'),
                    SizedBox(width: 16),
                    _socialIcon('assets/images/google.png'),
                    SizedBox(width: 16),
                    _socialIcon('assets/images/facebook.png'),
                  ],
                ),
                SizedBox(height: 40),
                Center(
                  child: TextButton(
                    onPressed: () =>
                        RouteGenerator.navigateToPageWithoutStack(context, Routes.loginRoute),
                    child: Text.rich(
                      TextSpan(
                        text: alreadyHaveAccStr,
                        style: TextStyle(color: Colors.black54),
                        children: [
                          TextSpan(
                            text: loginStr,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _socialIcon(String assetPath) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(color: Colors.black12),
      ),
      padding: EdgeInsets.all(12),
      child: Image.asset(assetPath, fit: BoxFit.contain),
    );
  }
}