import 'package:flutter/material.dart';
import 'package:flutter_task/core/utilities/extensions/context_extension.dart';

class CustomAppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;

  const CustomAppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: context.appColors.primaryColor,
          foregroundColor: context.appColors.buttonTextColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          elevation: 4,
          shadowColor: context.appColors.primaryColor.withValues(alpha: 0.4),
        ),
        child: isLoading
            ? SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    context.appColors.buttonTextColor,
                  ),
                  strokeWidth: 2.5,
                ),
              )
            : Text(
                text,
                style: context.appTextStyles.font14MediumButtonText,
              ),
      ),
    );
  }
}
