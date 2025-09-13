import 'package:expense_tracker_mobile/app/router.dart';
import 'package:expense_tracker_mobile/app/theme/app_colors.dart';
import 'package:expense_tracker_mobile/app/theme/app_dimensions.dart';
import 'package:expense_tracker_mobile/app/theme/app_text_styles.dart';
import 'package:expense_tracker_mobile/core/extensions/build_context_extensions.dart';
import 'package:expense_tracker_mobile/core/services/session_service.dart';
import 'package:expense_tracker_mobile/presentation/widgets/common/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final sessionService = GetIt.instance<SessionService>();

    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.profile)),
      body: Padding(
        padding: AppDimensions.paddingAllL,
        child: Column(
          children: [
            // Profile Header
            Container(
              width: double.infinity,
              padding: AppDimensions.paddingAllL,
              decoration: BoxDecoration(
                color: AppColors.primaryContainer,
                borderRadius: BorderRadius.circular(AppDimensions.radiusL),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: AppColors.primary,
                    child: Icon(Icons.person, size: 40, color: AppColors.onPrimary),
                  ),
                  const SizedBox(height: AppDimensions.spaceM),
                  Text(
                    context.l10n.welcomeUser,
                    style: AppTextStyles.headlineMedium.copyWith(color: AppColors.primary),
                  ),
                  const SizedBox(height: AppDimensions.spaceS),
                  Text(
                    context.l10n.manageAccount,
                    style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary.withValues(alpha: 0.7)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppDimensions.spaceXL),

            // Profile Options
            _buildProfileOption(
              icon: Icons.account_circle_outlined,
              title: context.l10n.accountSettings,
              subtitle: context.l10n.updatePersonalInfo,
              onTap: () {
                // TODO: Navigate to account settings
              },
            ),

            // _buildProfileOption(
            //   icon: Icons.notifications_outlined,
            //   title: context.l10n.notifications,
            //   subtitle: context.l10n.manageNotifications,
            //   onTap: () {
            //     // TODO: Navigate to notifications settings
            //   },
            // ),
            _buildProfileOption(
              icon: Icons.security_outlined,
              title: context.l10n.security,
              subtitle: context.l10n.changePassword,
              onTap: () {
                // TODO: Navigate to security settings
              },
            ),

            // _buildProfileOption(
            //   icon: Icons.help_outline,
            //   title: context.l10n.helpSupport,
            //   subtitle: context.l10n.getHelp,
            //   onTap: () {
            //     // TODO: Navigate to help page
            //   },
            // ),
            const Spacer(),

            // Logout Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () async {
                  await _handleLogout(context, sessionService);
                },
                icon: const Icon(Icons.logout),
                label: Text(context.l10n.logout),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.error,
                  side: BorderSide(color: AppColors.error),
                  padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingM),
                ),
              ),
            ),

            const SizedBox(height: AppDimensions.spaceL),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.spaceM),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(AppDimensions.paddingS),
          decoration: BoxDecoration(
            color: AppColors.primaryContainer,
            borderRadius: BorderRadius.circular(AppDimensions.radiusS),
          ),
          child: Icon(icon, color: AppColors.primary),
        ),
        title: Text(title, style: AppTextStyles.titleMedium),
        subtitle: Text(subtitle, style: AppTextStyles.bodySmall),
        trailing: Icon(Icons.chevron_right, color: AppColors.primary),
        onTap: onTap,
      ),
    );
  }

  Future<void> _handleLogout(BuildContext context, SessionService sessionService) async {
    final shouldLogout = await ConfirmationDialog.show(
      context,
      title: context.l10n.logout,
      content: context.l10n.logoutConfirmation,
      confirmText: context.l10n.logout,
      isDestructive: true,
    );

    if (shouldLogout == true) {
      await sessionService.clearSession();
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(context, RouteName.login.path, (route) => false);
      }
    }
  }
}
