import 'package:flutter/material.dart';
import 'package:mvv_managements/constants/app_icons.dart';

class MyErrorWidget extends StatelessWidget {
  const MyErrorWidget({
    super.key,
    required this.errorText,
    required this.onRetry,
  });

  final String errorText;
  final Function onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(AppIcons.error, size: 80.0, color: Colors.red),
          const SizedBox(height: 20.0),
          Text(
            errorText,
            style: const TextStyle(fontSize: 16.0, color: Colors.red),
          ),
          const SizedBox(height: 10.0),
          ElevatedButton(
            onPressed: () => onRetry(),
            child: const Text('Retry', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
