import 'package:flutter/material.dart';

class ApiErrorHandler {
  static String getErrorMessage(dynamic error) {
    if (error is Exception) {
      final message = error.toString();
      
      if (message.contains('Failed to load')) {
        return 'Failed to fetch data. Please check your internet connection.';
      } else if (message.contains('Connection refused')) {
        return 'Could not connect to the server. Please try another provider.';
      } else if (message.contains('SocketException')) {
        return 'Network error. Check your internet connection.';
      } else if (message.contains('TimeoutException')) {
        return 'Request timed out. Please try again.';
      } else {
        return message.replaceAll('Exception: ', '');
      }
    }
    return error.toString();
  }

  static void showErrorSnackbar(BuildContext context, dynamic error) {
    final message = getErrorMessage(error);
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  static void showWarningSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.orange,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  static void showSuccessSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
