import 'package:flutter/material.dart';

class CustomLoadingErrorWidget<T> extends StatelessWidget {
  final bool isLoading;
  final List<T>? list;
  final String? error;
  final Widget child;
  final Widget? customLoading;

  const CustomLoadingErrorWidget({
    super.key,
    required this.isLoading,
    required this.list,
    required this.child,
    required this.error,
    this.customLoading,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading == true) {
      return customLoading ??
          const Center(
            child: CircularProgressIndicator(),
          );
    } else if (list == null || list!.isEmpty || list == []) {
      return Center(child: Text(error!));
    } else {
      return child;
    }
  }
}
