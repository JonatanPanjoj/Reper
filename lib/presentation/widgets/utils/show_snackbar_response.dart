import 'package:flutter/material.dart';
import 'package:reper/domain/entities/entities.dart';

enum SnackBarStatus { success, error, info }

dynamic showSnackbarResponse({
  required BuildContext context,
  required ResponseStatus response,
  String? successMessage,
  String? errorMessage,
  bool showSuccessMessage = true,
}) {
  if (!response.hasError) {
    if (showSuccessMessage) {
      showSnackBar(
        context: context,
        message: successMessage ?? response.message,
        status: SnackBarStatus.success,
      );
    }
  } else {
    showSnackBar(
      context: context,
      message: errorMessage ?? response.message,
      status: SnackBarStatus.error,
    );
  }
}

showSnackBar(
    {required BuildContext context,
    required String message,
    SnackBarStatus? status = SnackBarStatus.info}) {
  ScaffoldMessenger.of(context).showSnackBar(
    CustomSnackBar(
      context: context,
      message: message,
      status: status!,
    ),
  );
}

class CustomSnackBar extends SnackBar {
  CustomSnackBar({
    super.key,
    required String message,
    required SnackBarStatus status,
    required BuildContext context,
  }) : super(
          content: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: _getBackgroundColor(context, status),
          behavior: SnackBarBehavior.floating,
          width: MediaQuery.of(context).size.width * 0.85,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        );

  static Color _getBackgroundColor(
      BuildContext context, SnackBarStatus status) {
    final colors = Theme.of(context).colorScheme;
    switch (status) {
      case SnackBarStatus.success:
        return Colors.green; // Define el color para el estado 'success'
      case SnackBarStatus.error:
        return colors.error; // Define el color para el estado 'error'
      case SnackBarStatus.info:
        return colors.primary; // Define el color para el estado 'info'
      default:
        return colors.primary; // Define un color por defecto
    }
  }
}
