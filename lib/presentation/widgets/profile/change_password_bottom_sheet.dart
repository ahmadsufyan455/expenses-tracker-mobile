import 'package:expense_tracker_mobile/app/theme/app_dimensions.dart';
import 'package:expense_tracker_mobile/core/extensions/build_context_extensions.dart';
import 'package:expense_tracker_mobile/presentation/pages/profile/bloc/profile_bloc.dart';
import 'package:expense_tracker_mobile/presentation/widgets/common/error_dialog.dart';
import 'package:expense_tracker_mobile/presentation/widgets/common/global_button.dart';
import 'package:expense_tracker_mobile/presentation/widgets/auth/password_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class ChangePasswordBottomSheet extends StatefulWidget {
  const ChangePasswordBottomSheet({super.key});

  static Future<bool?> show(BuildContext context) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const ChangePasswordBottomSheet(),
    );
  }

  @override
  State<ChangePasswordBottomSheet> createState() => _ChangePasswordBottomSheetState();
}

class _ChangePasswordBottomSheetState extends State<ChangePasswordBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  late ProfileBloc _bloc;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.instance<ProfileBloc>();
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppDimensions.radiusL),
          topRight: Radius.circular(AppDimensions.radiusL),
        ),
      ),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        bloc: _bloc,
        listener: (context, state) {
          _handlePasswordState(state);
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.only(
              left: AppDimensions.paddingL,
              right: AppDimensions.paddingL,
              top: AppDimensions.paddingL,
              bottom: MediaQuery.of(context).viewInsets.bottom + AppDimensions.paddingL,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Handle bar
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: AppDimensions.spaceL),

                // Title
                Text(
                  context.l10n.changePasswordTitle,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: AppDimensions.spaceL),

                // Form
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Current Password
                      PasswordTextField(
                        controller: _currentPasswordController,
                        labelText: context.l10n.currentPassword,
                        hintText: context.l10n.enterCurrentPassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return context.l10n.currentPasswordRequired;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: AppDimensions.spaceM),

                      // New Password
                      PasswordTextField(
                        controller: _newPasswordController,
                        labelText: context.l10n.newPassword,
                        hintText: context.l10n.enterNewPassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return context.l10n.newPasswordRequired;
                          }
                          if (value.length < 8) {
                            return context.l10n.newPasswordTooShort(8);
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: AppDimensions.spaceM),

                      // Confirm Password
                      PasswordTextField(
                        controller: _confirmPasswordController,
                        labelText: context.l10n.confirmNewPassword,
                        hintText: context.l10n.confirmYourNewPassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return context.l10n.fieldRequired(context.l10n.confirmNewPassword);
                          }
                          if (value != _newPasswordController.text) {
                            return context.l10n.passwordsDontMatch;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: AppDimensions.spaceXL),

                      // Change Password Button
                      GlobalButton(
                        onPressed: _changePassword,
                        text: context.l10n.changePasswordButton,
                        isLoading: _isLoading,
                      ),
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

  void _changePassword() {
    if (_formKey.currentState!.validate()) {
      _bloc.add(ChangePasswordEvent(
        currentPassword: _currentPasswordController.text,
        newPassword: _newPasswordController.text,
      ));
    }
  }

  void _handlePasswordState(ProfileState state) {
    if (state is ChangePasswordLoading) {
      setState(() {
        _isLoading = true;
      });
    } else if (state is ChangePasswordSuccess) {
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop(true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.l10n.passwordChangedSuccessfully),
          backgroundColor: Colors.green,
        ),
      );
    } else if (state is ChangePasswordFailure) {
      setState(() {
        _isLoading = false;
      });
      ErrorDialog.show(context, state.failure);
    }
  }
}