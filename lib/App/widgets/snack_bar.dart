import 'package:flutter/material.dart';

enum SNACK { SUCCESS, FAILED }

getSnackBar(BuildContext context, String message, SNACK type, {String? title}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(
        child: Text(
          message,
          maxLines: 2,
          style: TextStyle(
            color: Theme.of(context).colorScheme.scrim,
            fontSize: 13,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      backgroundColor: type == SNACK.SUCCESS ? Colors.green : Colors.red,
      elevation: 10,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(5),
      duration: const Duration(seconds: 2),
    ),
  );
}

void errorMessage(BuildContext context, String message) {
  if (message.isEmpty || message == "") return;
  getSnackBar(context, message, SNACK.FAILED);
}

void successMessage(BuildContext context, String message) {
  if (message.isEmpty || message == "") return;
  getSnackBar(context, message, SNACK.SUCCESS);
}
