import 'package:flutter/material.dart';

/// Controller to open dialogs.
class DialogController {
  /// Create an instance [DialogController].
  const DialogController();

  /// Shows a [SnackBar].
  void showSnackBar(BuildContext context, String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
  }
}
