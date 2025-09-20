import 'package:expense_tracker_mobile/app/router.dart';
import 'package:expense_tracker_mobile/app/theme/app_colors.dart';
import 'package:expense_tracker_mobile/app/theme/app_dimensions.dart';
import 'package:expense_tracker_mobile/core/extensions/build_context_extensions.dart';
import 'package:expense_tracker_mobile/core/services/session_service.dart';
import 'package:expense_tracker_mobile/domain/dto/profile_dto.dart';
import 'package:expense_tracker_mobile/presentation/pages/profile/bloc/profile_bloc.dart';
import 'package:expense_tracker_mobile/presentation/widgets/common/error_dialog.dart';
import 'package:expense_tracker_mobile/presentation/widgets/common/global_button.dart';
import 'package:expense_tracker_mobile/presentation/widgets/common/global_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key, required this.profile});

  final ProfileDto profile;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();

  late ProfileBloc _bloc;
  final _sessionService = GetIt.instance<SessionService>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.instance<ProfileBloc>();
    _initializeData();
  }

  void _initializeData() {
    _firstNameController.text = widget.profile.firstName;
    _lastNameController.text = widget.profile.lastName;
    _emailController.text = widget.profile.email;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.editProfile), elevation: 0),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        bloc: _bloc,
        listener: (context, state) {
          _handleProfileState(state);
        },
        builder: (context, state) {
          final theme = Theme.of(context);

          return SingleChildScrollView(
            padding: AppDimensions.paddingAllL,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Header
                Container(
                  width: double.infinity,
                  padding: AppDimensions.paddingAllL,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                    border: Border.all(
                      color: theme.colorScheme.outline.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: theme.colorScheme.primary,
                        child: Icon(Icons.person, size: 50, color: theme.colorScheme.onPrimary),
                      ),
                      const SizedBox(height: AppDimensions.spaceM),
                      Text(
                        context.l10n.personalInformation,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: theme.colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppDimensions.spaceXL),

                // Profile Form
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // First Name
                      GlobalTextFormField(
                        controller: _firstNameController,
                        labelText: context.l10n.firstName,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return context.l10n.fieldRequired(context.l10n.firstName);
                          }
                          if (value.length < 2) {
                            return context.l10n.fieldTooShort(context.l10n.firstName, 2);
                          }
                          if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                            return context.l10n.nameLettersOnly(context.l10n.firstName);
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: AppDimensions.spaceM),

                      // Last Name
                      GlobalTextFormField(
                        controller: _lastNameController,
                        labelText: context.l10n.lastName,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return context.l10n.fieldRequired(context.l10n.lastName);
                          }
                          if (value.length < 2) {
                            return context.l10n.fieldTooShort(context.l10n.lastName, 2);
                          }
                          if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                            return context.l10n.nameLettersOnly(context.l10n.lastName);
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: AppDimensions.spaceM),

                      // Email
                      GlobalTextFormField(
                        controller: _emailController,
                        labelText: context.l10n.email,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return context.l10n.emailRequired;
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return context.l10n.emailInvalid;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: AppDimensions.spaceXL),

                      // Save Button
                      GlobalButton(onPressed: _saveProfile, text: context.l10n.saveChanges, isLoading: _isLoading),
                      const SizedBox(height: AppDimensions.spaceXL),

                      // Danger Zone
                      _buildDangerZone(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDangerZone() {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: AppDimensions.paddingAllL,
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning_outlined, color: AppColors.error),
              const SizedBox(width: AppDimensions.spaceS),
              Text(
                context.l10n.dangerZone,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: AppColors.error,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spaceM),
          Text(
            context.l10n.deleteAccountDescription,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.error,
            ),
          ),
          const SizedBox(height: AppDimensions.spaceM),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _showDeleteAccountDialog,
              icon: const Icon(Icons.delete_forever_outlined),
              label: Text(context.l10n.deleteAccount),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.error,
                side: BorderSide(color: AppColors.error),
                padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingM),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      _bloc.add(
        UpdateProfileEvent(
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          email: _emailController.text.trim(),
        ),
      );
    }
  }


  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: Icon(Icons.warning_outlined, color: AppColors.error, size: 32),
        title: Text(context.l10n.deleteAccount),
        content: Text(context.l10n.deleteAccountWarning),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(context.l10n.cancel)),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _bloc.add(DeleteAccountEvent());
            },
            child: Text(context.l10n.deleteAccount, style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }

  void _handleProfileState(ProfileState state) {
    if (state is UpdateProfileLoading) {
      setState(() {
        _isLoading = true;
      });
    } else if (state is UpdateProfileSuccess) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.l10n.profileUpdatedSuccessfully), backgroundColor: Colors.green));
      // Navigate back and refresh profile
      Navigator.pop(context, true);
    } else if (state is UpdateProfileFailure) {
      setState(() {
        _isLoading = false;
      });
      ErrorDialog.show(context, state.failure);
    } else if (state is DeleteAccountSuccess) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.l10n.accountDeletedSuccessfully), backgroundColor: Colors.green));
      // Clear session and navigate to login screen
      _sessionService.clearSession().then((_) {
        if (mounted) {
          Navigator.pushNamedAndRemoveUntil(context, RouteName.login.path, (route) => false);
        }
      });
    } else if (state is DeleteAccountFailure) {
      ErrorDialog.show(context, state.failure);
    }
  }
}
