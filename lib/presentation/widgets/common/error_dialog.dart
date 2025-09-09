import 'package:expense_tracker_mobile/app/theme/app_colors.dart';
import 'package:expense_tracker_mobile/app/theme/app_dimensions.dart';
import 'package:expense_tracker_mobile/app/theme/app_text_styles.dart';
import 'package:expense_tracker_mobile/core/errors/failure.dart';
import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final Failure failure;

  const ErrorDialog({
    super.key,
    required this.failure,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      ),
      contentPadding: AppDimensions.paddingAllL,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getIconForStatusCode(failure.statusCode),
            size: 64,
            color: _getColorForStatusCode(failure.statusCode),
          ),
          const SizedBox(height: AppDimensions.spaceL),
          Text(
            _getTitleForStatusCode(failure.statusCode),
            style: AppTextStyles.headlineSmall.copyWith(
              color: _getColorForStatusCode(failure.statusCode),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimensions.spaceM),
          Text(
            failure.message,
            style: AppTextStyles.bodyMedium.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimensions.spaceL),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => Navigator.of(context).pop(),
              style: FilledButton.styleFrom(
                backgroundColor: _getColorForStatusCode(failure.statusCode),
              ),
              child: Text(
                'OK',
                style: AppTextStyles.labelLarge.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconForStatusCode(int? statusCode) {
    if (statusCode == null) return Icons.error_outline;
    
    switch (statusCode) {
      case 400:
        return Icons.warning_amber_outlined;
      case 401:
        return Icons.lock_outline;
      case 403:
        return Icons.block_outlined;
      case 404:
        return Icons.search_off_outlined;
      case 408:
        return Icons.access_time_outlined;
      case 422:
        return Icons.error_outline;
      case 429:
        return Icons.speed_outlined;
      case 500:
      case 502:
      case 503:
      case 504:
        return Icons.dns_outlined;
      default:
        if (statusCode >= 400 && statusCode < 500) {
          return Icons.warning_amber_outlined;
        } else if (statusCode >= 500) {
          return Icons.dns_outlined;
        }
        return Icons.error_outline;
    }
  }

  Color _getColorForStatusCode(int? statusCode) {
    if (statusCode == null) return AppColors.error;
    
    switch (statusCode) {
      case 400:
      case 422:
        return AppColors.warning;
      case 401:
      case 403:
        return AppColors.error;
      case 404:
        return AppColors.info;
      case 408:
      case 429:
        return AppColors.warning;
      case 500:
      case 502:
      case 503:
      case 504:
        return AppColors.error;
      default:
        if (statusCode >= 400 && statusCode < 500) {
          return AppColors.warning;
        } else if (statusCode >= 500) {
          return AppColors.error;
        }
        return AppColors.error;
    }
  }

  String _getTitleForStatusCode(int? statusCode) {
    if (statusCode == null) return 'Error';
    
    switch (statusCode) {
      case 400:
        return 'Bad Request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Access Denied';
      case 404:
        return 'Not Found';
      case 408:
        return 'Request Timeout';
      case 422:
        return 'Validation Error';
      case 429:
        return 'Too Many Requests';
      case 500:
        return 'Server Error';
      case 502:
        return 'Bad Gateway';
      case 503:
        return 'Service Unavailable';
      case 504:
        return 'Gateway Timeout';
      default:
        if (statusCode >= 400 && statusCode < 500) {
          return 'Client Error';
        } else if (statusCode >= 500) {
          return 'Server Error';
        }
        return 'Error';
    }
  }

  static void show(BuildContext context, Failure failure) {
    showDialog(
      context: context,
      builder: (context) => ErrorDialog(failure: failure),
    );
  }
}