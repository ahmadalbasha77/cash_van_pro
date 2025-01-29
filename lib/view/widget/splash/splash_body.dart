import 'package:flutter/material.dart';

import '../../../core/app_color.dart';

class SplashBodyWidget extends StatefulWidget {
  const SplashBodyWidget({super.key});

  @override
  State<SplashBodyWidget> createState() => _SplashBodyWidgetState();
}

class _SplashBodyWidgetState extends State<SplashBodyWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final screenWidth = MediaQuery.of(context).size.width;
    _animation = Tween<double>(begin: -200, end: screenWidth + 200)
        .animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.repeat(reverse: false);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(_animation.value, 0),
                child: child,
              );
            },
            child: Image.asset(
              'assets/images/mndbi2.png',
              color: AppColor.primaryColor,
              width: 300,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.28,
          ),
          const CircularProgressIndicator(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.06,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              '© 2025 All rights reserved to Royal Soft Company',
              style: TextStyle(fontSize: 12),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Text(
            'Version 1.0.0',
            style: TextStyle(fontSize: 14, color: AppColor.primaryColor),
          )
        ],
      ),
    );
  }
}
