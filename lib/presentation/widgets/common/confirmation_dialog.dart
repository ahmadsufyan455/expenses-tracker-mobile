import 'package:expense_tracker_mobile/app/theme/app_colors.dart';
import 'package:expense_tracker_mobile/core/extensions/build_context_extensions.dart';
import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final String confirmText;
  final String? cancelText;
  final bool isDestructive;
  final VoidCallback? onConfirm;

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.content,
    required this.confirmText,
    this.cancelText,
    this.isDestructive = true,
    this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actionsAlignment: MainAxisAlignment.end,
      buttonPadding: const EdgeInsets.symmetric(horizontal: 8.0),
      actions: [
        IntrinsicWidth(
          child: TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            style: TextButton.styleFrom(
              minimumSize: const Size(64, 36),
            ),
            child: Text(cancelText ?? context.l10n.cancel),
          ),
        ),
        IntrinsicWidth(
          child: TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
              onConfirm?.call();
            },
            style: TextButton.styleFrom(
              foregroundColor: isDestructive ? AppColors.error : AppColors.primary,
              minimumSize: const Size(64, 36),
            ),
            child: Text(confirmText),
          ),
        ),
      ],
    );
  }

  /// Show confirmation dialog and return the result
  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required String content,
    required String confirmText,
    String? cancelText,
    bool isDestructive = true,
    VoidCallback? onConfirm,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => ConfirmationDialog(
        title: title,
        content: content,
        confirmText: confirmText,
        cancelText: cancelText,
        isDestructive: isDestructive,
        onConfirm: onConfirm,
      ),
    );
  }
}