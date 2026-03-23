import 'package:flutter/material.dart';

class CustomSnackbar {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();
  static void show({required String message, bool isSuccess = true}) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
      duration: Duration(seconds: 2),
      content: _buildContent(message, isSuccess),
    );
    messengerKey.currentState
      ?..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static Widget _buildContent(String message, bool isSuccess) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: isSuccess ? Color(0xFF4CAF50) : Color(0xFFE53935),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 10, offset: Offset(0, 4))],
      ),
      child: Row(
        children: [
          Icon(isSuccess ? Icons.check_circle : Icons.error, color: Colors.white),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

class NavigationService {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static Future<dynamic> pushReplacement(Widget page) {
    return navigatorKey.currentState!.pushReplacement(MaterialPageRoute(builder: (_) => page));
  }
}
