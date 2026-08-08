import 'package:firebase_setup/core/utils/status_utils.dart';
import 'package:firebase_setup/core/utils/string_consts.dart';
import 'package:firebase_setup/core/utils/validators.dart';
import 'package:firebase_setup/feature/login/bloc/login_bloc.dart';
import 'package:firebase_setup/feature/login/bloc/login_event.dart';
import 'package:firebase_setup/feature/login/bloc/login_state.dart';
import 'package:firebase_setup/shared_widget/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_setup/shared_widget/custom_elevated_button.dart';
import 'package:firebase_setup/route/route.dart';
import 'package:firebase_setup/route/route_generator.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30),
                        Text(logIntoStr, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                        SizedBox(height: 12),
                        Text(yourAccountStr, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                        SizedBox(height: 30),
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
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () => RouteGenerator.navigateToPage(context, Routes.forgotPasswordRoute),
                            child: Text(forgotPasswordStr, style: TextStyle(color: Colors.black54)),
                          ),
                        ),
                        SizedBox(height: 40),
                        BlocConsumer<LoginBloc, LoginState>(
                          listener: (context, state) {
                            if (state.status == StatusUtils.success) {
                              RouteGenerator.navigateToPageWithoutStack(context, Routes.homeRoute);
                            } else if (state.status == StatusUtils.failure) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(state.message ?? 'Login failed')),
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
                                        context.read<LoginBloc>().add(
                                          LoginButtonEvent(
                                            email: _emailController.text,
                                            password: _passwordController.text,
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
                                  : Text(loginStr, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                            );
                          },
                        ),
                        SizedBox(height: 24),
                        Center(child: Text(orlogInIntoStr, style: TextStyle(color: Colors.black54))),
                        SizedBox(height: 16),
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
                        Spacer(),
                        Center(
                          child: TextButton(
                            onPressed: () => RouteGenerator.navigateToPageWithoutStack(context, Routes.signUpRoute),
                            child: Text.rich(
                              TextSpan(
                                text: donotHaveAccountStr,
                                style: TextStyle(color: Colors.black54),
                                children: [
                                  TextSpan(
                                    text: signUpStr,
                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
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
          },
        ),
      ),
    );
  }

  Widget _socialIcon(String assetPath) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white, border: Border.all(color: Colors.black12)),
      padding: EdgeInsets.all(12),
      child: Image.asset(assetPath, fit: BoxFit.contain),
    );
  }
}