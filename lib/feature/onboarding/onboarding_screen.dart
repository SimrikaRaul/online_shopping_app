import 'package:firebase_setup/feature/onboarding/discover_page.dart';
import 'package:firebase_setup/route/route.dart';
import 'package:firebase_setup/route/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
   OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();

  final _pages =  [
    {
      'title': 'Discover something new',
      'sub': 'Special new arrivals just for you',
      'img': 'assets/images/model1.png',
    },
    {
      'title': 'Update trendy outfit',
      'sub': 'Favorite brands and hottest trends',
      'img': 'assets/images/model2.png',
    },
    {
      'title': 'Explore your true style',
      'sub': 'Relax and let us bring the style to you',
      'img': 'assets/images/model3.png',
    },
  ];

  void _onNext(int index) {
    if (index == _pages.length - 1) {
      RouteGenerator.navigateToPageWithoutStack(context, Routes.signUpRoute);
    } else {
      _controller.nextPage(
        duration:  Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: _pages.length,
            itemBuilder: (context, i) {
              final p = _pages[i];
              return DiscoverScreenBody(
                title: p['title']!,
                subtitle: p['sub']!,
                imagePath: p['img']!,
                onButtonPressed: () => _onNext(i),
              );
            },
          ),
          Positioned(
            bottom: 110,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _controller,
                count: _pages.length,
                effect:  WormEffect(
                  dotColor: Colors.white38,
                  activeDotColor: Colors.white,
                  dotHeight: 8,
                  dotWidth: 8,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}