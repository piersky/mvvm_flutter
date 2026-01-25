import 'package:flutter/material.dart';
import 'package:mvv_managements/widgets/error_widget.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyErrorWidget(
        errorText: "SplashScreen is not implemented yet.",
        onRetry: () {},
      ),
    );
  }
}
