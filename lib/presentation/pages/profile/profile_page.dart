import 'package:expense_tracker_mobile/app/router.dart';
import 'package:expense_tracker_mobile/app/theme/app_dimensions.dart';
import 'package:expense_tracker_mobile/core/extensions/build_context_extensions.dart';
import 'package:expense_tracker_mobile/core/services/session_service.dart';
import 'package:expense_tracker_mobile/core/utils/date_utils.dart' as app_date_utils;
import 'package:expense_tracker_mobile/core/utils/package_info_utils.dart';
import 'package:expense_tracker_mobile/core/utils/preference_utils.dart';
import 'package:expense_tracker_mobile/presentation/pages/profile/bloc/profile_bloc.dart';
import 'package:expense_tracker_mobile/presentation/widgets/common/confirmation_dialog.dart';
import 'package:expense_tracker_mobile/presentation/widgets/common/error_dialog.dart';
import 'package:expense_tracker_mobile/presentation/widgets/common/global_button.dart';
import 'package:expense_tracker_mobile/presentation/widgets/profile/change_password_bottom_sheet.dart';
import 'package:expense_tracker_mobile/presentation/widgets/profile/default_filter_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ProfileBloc _bloc;
  final sessionService = GetIt.instance<SessionService>();
  String? _defaultFilter;

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.instance<ProfileBloc>()..add(GetProfileEvent());
    _loadDefaultFilter();
  }

  Future<void> _loadDefaultFilter() async {
    final filter = await PreferenceUtils.getDefaultDashboardFilter();
    if (mounted) {
      setState(() {
        _defaultFilter = filter ?? app_date_utils.AppDateUtils.getCurrentMonthFilter();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.profile)),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        bloc: _bloc,
        listener: (context, state) {
          _handleProfileState(state);
        },
        builder: (context, state) {
          if (state is GetProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final profile = state.data.profile;
          if (profile == null) {
            return const Center(child: Text('No profile data'));
          }

          final theme = Theme.of(context);

          return Padding(
            padding: AppDimensions.paddingAllL,
            child: Column(
              children: [
                // Profile Header
                Container(
                  width: double.infinity,
                  padding: AppDimensions.paddingAllL,
                  decoration: BoxDecoration(
                    color: theme.brightness == Brightness.dark
                        ? theme.colorScheme.surfaceContainerHighest
                        : theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                    border: theme.brightness == Brightness.dark
                        ? Border.all(color: theme.colorScheme.outline.withValues(alpha: 0.2), width: 1)
                        : null,
                    boxShadow: theme.brightness == Brightness.dark
                        ? null
                        : [
                            BoxShadow(
                              color: theme.shadowColor.withValues(alpha: 0.08),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: theme.colorScheme.primary,
                        child: Icon(Icons.person, size: 40, color: theme.colorScheme.onPrimary),
                      ),
                      const SizedBox(height: AppDimensions.spaceM),
                      Text(
                        profile.fullName,
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: theme.colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.spaceXS),
                      Text(
                        profile.email,
                        style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                      ),
                      const SizedBox(height: AppDimensions.spaceS),
                      Text(
                        context.l10n.manageAccount,
                        style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppDimensions.spaceXL),

                // Profile Options
                _buildProfileOption(
                  theme: theme,
                  icon: Icons.account_circle_outlined,
                  title: context.l10n.accountSettings,
                  subtitle: context.l10n.updatePersonalInfo,
                  onTap: () async {
                    final result = await Navigator.pushNamed(
                      context,
                      RouteName.editProfile.path,
                      arguments: {'profile': profile},
                    );
                    if (result == true) {
                      _bloc.add(GetProfileEvent());
                    }
                  },
                ),

                _buildProfileOption(
                  theme: theme,
                  icon: Icons.security_outlined,
                  title: context.l10n.security,
                  subtitle: context.l10n.changePassword,
                  onTap: () async {
                    await ChangePasswordBottomSheet.show(context);
                  },
                ),

                _buildProfileOption(
                  theme: theme,
                  icon: Icons.filter_list_outlined,
                  title: context.l10n.defaultDashboardFilter,
                  subtitle: _defaultFilter != null
                      ? app_date_utils.AppDateUtils.formatFilterToDisplayName(context, _defaultFilter!)
                      : context.l10n.defaultFilterDescription,
                  onTap: () async {
                    final result = await DefaultFilterBottomSheet.show(context, currentFilter: _defaultFilter);
                    if (result != null) {
                      await PreferenceUtils.saveDefaultDashboardFilter(result);
                      await _loadDefaultFilter();
                    }
                  },
                ),
                // const SizedBox(height: 4),
                FutureBuilder(
                  future: PackageInfoUtils.appVersion(),
                  builder: (context, asyncSnapshot) {
                    return Text('Version ${asyncSnapshot.data}', style: theme.textTheme.bodyMedium);
                  },
                ),

                const Spacer(),

                // Logout Button
                GlobalButton(
                  text: context.l10n.logout,
                  onPressed: () async {
                    await _handleLogout(context, sessionService);
                  },
                ),

                const SizedBox(height: AppDimensions.spaceL),
              ],
            ),
          );
        },
      ),
    );
  }

  void _handleProfileState(ProfileState state) {
    if (state is GetProfileFailure) {
      ErrorDialog.show(context, state.failure);
    }
  }

  Widget _buildProfileOption({
    required ThemeData theme,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.spaceM),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark
            ? theme.colorScheme.surfaceContainerHighest
            : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        border: theme.brightness == Brightness.dark
            ? Border.all(color: theme.colorScheme.outline.withValues(alpha: 0.2), width: 1)
            : null,
        boxShadow: theme.brightness == Brightness.dark
            ? null
            : [BoxShadow(color: theme.shadowColor.withValues(alpha: 0.08), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(AppDimensions.paddingS),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(AppDimensions.radiusS),
          ),
          child: Icon(icon, color: theme.colorScheme.primary),
        ),
        title: Text(title, style: theme.textTheme.titleMedium),
        subtitle: Text(subtitle, style: theme.textTheme.bodySmall),
        trailing: Icon(Icons.chevron_right, color: theme.colorScheme.onSurfaceVariant),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppDimensions.radiusM)),
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
