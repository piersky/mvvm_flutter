import 'package:flutter/material.dart';

class NavigationService {
  late GlobalKey<NavigatorState> navigatorKey;

  NavigationService() {
    navigatorKey = GlobalKey<NavigatorState>();
  }

  navigator(Widget widget) {
    return navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  navigatorReplace(Widget widget) {
    return navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  Future<void> showDialog(Widget widget) async {
    await showAdaptiveDialog(
      barrierDismissible: true,
      context: navigatorKey.currentContext!,
      builder: (context) => widget,
    );
  }

  void showSnackBar({required String message}) {
    final context = navigatorKey.currentContext!;
    ScaffoldMessenger.of(
      navigatorKey.currentContext!,
    ).hideCurrentMaterialBanner();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
