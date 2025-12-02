import 'package:flutter/material.dart';

abstract class AppSnackBarShower {
  static _snackBarBuilder({
    required String message,
    required AppSnackBarStates state,
  }) {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.all(8),
      content: Row(
        children: [
          Icon(state.icon, color: Colors.white),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      backgroundColor: state.color,
    );
  }

  static void showSnackBar({
    required BuildContext context,
    required String? message,
    required AppSnackBarStates state,
  }) {
    state.switchCase(
      success: () {
        ScaffoldMessenger.of(context).showSnackBar(
          _snackBarBuilder(message: message ?? '', state: state),
        );
      },
      error: () {
        ScaffoldMessenger.of(context).showSnackBar(
          _snackBarBuilder(
            message: message ?? '',
            state: state,
          ),
        );
      },
      warning: () {
        ScaffoldMessenger.of(context).showSnackBar(
          _snackBarBuilder(message: message ?? '', state: state),
        );
      },
      info: () {
        ScaffoldMessenger.of(context).showSnackBar(
          _snackBarBuilder(message: message ?? '', state: state),
        );
      },
    );
  }
}

enum AppSnackBarStates { success, error, warning, info }

extension SnackBarStatesExtension on AppSnackBarStates {
  Color get color {
    switch (this) {
      case AppSnackBarStates.success:
        return Colors.green;
      case AppSnackBarStates.error:
        return Colors.red;
      case AppSnackBarStates.warning:
        return Colors.orange;
      case AppSnackBarStates.info:
        return Colors.blue;
    }
  }

  IconData get icon {
    switch (this) {
      case AppSnackBarStates.success:
        return Icons.check_circle;
      case AppSnackBarStates.error:
        return Icons.error;
      case AppSnackBarStates.warning:
        return Icons.warning;
      case AppSnackBarStates.info:
        return Icons.info;
    }
  }
}

extension BoolExtension on AppSnackBarStates {
  bool get isSuccess => this == AppSnackBarStates.success;
  bool get isError => this == AppSnackBarStates.error;
  bool get isWarning => this == AppSnackBarStates.warning;
  bool get isInfo => this == AppSnackBarStates.info;
}

extension SnackBarStatesSwitch on AppSnackBarStates {
  void switchCase({
    required Function() success,
    required Function() error,
    required Function() warning,
    required Function() info,
  }) {
    switch (this) {
      case AppSnackBarStates.success:
        success();
        break;
      case AppSnackBarStates.error:
        error();
        break;
      case AppSnackBarStates.warning:
        warning();
        break;
      case AppSnackBarStates.info:
        info();
        break;
    }
  }
}
