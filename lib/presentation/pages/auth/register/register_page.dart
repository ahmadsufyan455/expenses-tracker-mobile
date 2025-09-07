import 'package:expense_tracker_mobile/app/theme/app_colors.dart';
import 'package:expense_tracker_mobile/app/theme/app_dimensions.dart';
import 'package:expense_tracker_mobile/app/theme/app_text_styles.dart';
import 'package:expense_tracker_mobile/core/extensions/build_context_extensions.dart';
import 'package:expense_tracker_mobile/core/utils/validation_utils.dart';
import 'package:expense_tracker_mobile/presentation/pages/auth/register/bloc/register_bloc.dart';
import 'package:expense_tracker_mobile/presentation/widgets/auth/auth_button.dart';
import 'package:expense_tracker_mobile/presentation/widgets/auth/auth_header.dart';
import 'package:expense_tracker_mobile/presentation/widgets/auth/auth_link_text.dart';
import 'package:expense_tracker_mobile/presentation/widgets/auth/auth_text_field.dart';
import 'package:expense_tracker_mobile/presentation/widgets/auth/password_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _acceptTerms = false;

  late RegisterBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.instance<RegisterBloc>();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (_formKey.currentState!.validate()) {
      if (!_acceptTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(context.l10n.pleaseAcceptTerms),
            backgroundColor: AppColors.warning,
          ),
        );
        return;
      }

      _bloc.add(
        RegisterSubmitted(
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          email: _emailController.text.trim().toLowerCase(),
          password: _passwordController.text,
        ),
      );
    }
  }

  void _navigateToLogin() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: BlocConsumer<RegisterBloc, RegisterState>(
        bloc: _bloc,
        listener: (context, state) {
          _handleRegisterState(state);
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: AppDimensions.paddingAllL,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header Section
                  AuthHeader(
                    title: context.l10n.createAccount,
                    subtitle: context.l10n.registerSubtitle,
                    showBackButton: true,
                  ),

                  const SizedBox(height: AppDimensions.spaceXL),

                  // Registration Form
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // First Name and Last Name Row
                        Row(
                          children: [
                            // First Name Field
                            Expanded(
                              child: AuthTextField(
                                controller: _firstNameController,
                                labelText: context.l10n.firstName,
                                hintText: context.l10n.firstNameHint,
                                prefixIcon: Icons.person_outlined,
                                textCapitalization: TextCapitalization.words,
                                textInputAction: TextInputAction.next,
                                validator: (value) =>
                                    ValidationUtils.validateName(
                                      value,
                                      context.l10n.firstName,
                                    ),
                              ),
                            ),

                            const SizedBox(width: AppDimensions.spaceM),

                            // Last Name Field
                            Expanded(
                              child: AuthTextField(
                                controller: _lastNameController,
                                labelText: context.l10n.lastName,
                                hintText: context.l10n.lastNameHint,
                                prefixIcon: Icons.person_outline,
                                textCapitalization: TextCapitalization.words,
                                textInputAction: TextInputAction.next,
                                validator: (value) =>
                                    ValidationUtils.validateName(
                                      value,
                                      context.l10n.lastName,
                                    ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: AppDimensions.spaceL),

                        // Email Field
                        AuthTextField(
                          controller: _emailController,
                          labelText: context.l10n.email,
                          hintText: context.l10n.emailHint,
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: ValidationUtils.validateEmail,
                        ),

                        const SizedBox(height: AppDimensions.spaceL),

                        // Password Field
                        PasswordTextField(
                          controller: _passwordController,
                          labelText: context.l10n.password,
                          hintText: context.l10n.createPasswordHint,
                          textInputAction: TextInputAction.done,
                          validator: ValidationUtils.validatePassword,
                          onFieldSubmitted: (_) => _handleRegister(),
                        ),

                        const SizedBox(height: AppDimensions.spaceM),

                        const SizedBox(height: AppDimensions.spaceL),

                        // Terms and Conditions Checkbox
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: _acceptTerms,
                              onChanged: (value) {
                                setState(() {
                                  _acceptTerms = value ?? false;
                                });
                              },
                              activeColor: AppColors.primary,
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _acceptTerms = !_acceptTerms;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: RichText(
                                    text: TextSpan(
                                      style: AppTextStyles.bodySmall.copyWith(
                                        color:
                                            theme.colorScheme.onSurfaceVariant,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: context.l10n.agreeToTerms,
                                        ),
                                        TextSpan(
                                          text: context.l10n.termsAndConditions,
                                          style: TextStyle(
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        TextSpan(text: context.l10n.and),
                                        TextSpan(
                                          text: context.l10n.privacyPolicy,
                                          style: TextStyle(
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: AppDimensions.spaceXL),

                        // Register Button
                        AuthButton(
                          text: context.l10n.createAccountButton,
                          onPressed: _handleRegister,
                          isLoading: _isLoading,
                        ),

                        const SizedBox(height: AppDimensions.spaceXL),

                        // Login Link
                        AuthLinkText(
                          normalText: context.l10n.alreadyHaveAccount,
                          linkText: context.l10n.signIn,
                          onTap: _navigateToLogin,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppDimensions.spaceXL),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _handleRegisterState(RegisterState state) {
    if (state is RegisterLoading) {
      setState(() {
        _isLoading = true;
      });
    } else if (state is RegisterSuccess) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.l10n.accountCreatedSuccessfully),
          backgroundColor: AppColors.success,
        ),
      );
      Navigator.pop(context);
    } else if (state is RegisterFailure) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.failure.message),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }
}
