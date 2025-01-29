import 'package:flutter/material.dart';

import '../widget/splash/splash_body.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashBodyWidget(),
    );
  }
}
