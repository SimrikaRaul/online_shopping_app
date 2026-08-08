import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_setup/core/utils/injection_container.dart';
import 'package:firebase_setup/feature/login/bloc/login_bloc.dart';
import 'package:firebase_setup/feature/onboarding/onboarding_page.dart';
import 'package:firebase_setup/feature/signup/bloc/signup_bloc.dart';
import 'package:firebase_setup/firebase_options.dart';
import 'package:firebase_setup/route/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignUpBloc>(create: (context) => getIt<SignUpBloc>()),
         BlocProvider<LoginBloc>(create: (context) => getIt<LoginBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.generateRoute,
        title: 'Flutter Demo',
        theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
        home: OnboardingPage(),
      ),
    );
  }
}
