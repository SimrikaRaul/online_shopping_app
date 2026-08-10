import 'package:firebase_setup/core/utils/helper_utils.dart';
import 'package:firebase_setup/core/utils/status_utils.dart';
import 'package:firebase_setup/core/utils/string_consts.dart';
import 'package:firebase_setup/core/utils/validators.dart';
import 'package:firebase_setup/feature/login/bloc/login_bloc.dart';
import 'package:firebase_setup/feature/login/bloc/login_event.dart';
import 'package:firebase_setup/feature/login/bloc/login_state.dart';
import 'package:firebase_setup/shared_widget/custom_textformfield.dart';
import 'package:firebase_setup/shared_widget/no_internet_page.dart';
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

  void _submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _dispatch(context);
    }
  }

  void _retry(BuildContext context) {
    _dispatch(context);
  }

  void _dispatch(BuildContext context) {
    context.read<LoginBloc>().add(
      LoginButtonEvent(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status == StatusUtils.success) {
            RouteGenerator.navigateToPageWithoutStack(context, Routes.bottomNavBarRoute);
          } else if (state.status == StatusUtils.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message ?? 'Login failed')),
            );
          }
        },
        builder: (context, state) {
          if (state.status == StatusUtils.noInternet) {
            return NoInternetPage(
              onPressed: () => _retry(context),
            );
          }

          final isLoading = state.status == StatusUtils.loading;
          return SafeArea(
            child: Stack(
              children: [
                LayoutBuilder(
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
                                CustomElevatedButton(
                                  text: loginStr,
                                  backgroundColor: Colors.black,
                                  borderRadius: 30,
                                  onPressed: isLoading ? null : () => _submit(context),
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
                if (isLoading) backdropFilter(context),
              ],
            ),
          );
        },
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