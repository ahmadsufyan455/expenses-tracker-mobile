import 'package:expense_tracker_mobile/app/router.dart';
import 'package:expense_tracker_mobile/app/theme/app_dimensions.dart';
import 'package:expense_tracker_mobile/app/theme/app_text_styles.dart';
import 'package:expense_tracker_mobile/core/extensions/build_context_extensions.dart';
import 'package:expense_tracker_mobile/core/services/session_service.dart';
import 'package:expense_tracker_mobile/core/utils/validation_utils.dart';
import 'package:expense_tracker_mobile/presentation/pages/auth/login/bloc/login_bloc.dart';
import 'package:expense_tracker_mobile/presentation/widgets/auth/auth_header.dart';
import 'package:expense_tracker_mobile/presentation/widgets/auth/auth_link_text.dart';
import 'package:expense_tracker_mobile/presentation/widgets/auth/auth_text_field.dart';
import 'package:expense_tracker_mobile/presentation/widgets/auth/password_text_field.dart';
import 'package:expense_tracker_mobile/presentation/widgets/common/error_dialog.dart';
import 'package:expense_tracker_mobile/presentation/widgets/common/global_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  late LoginBloc _bloc;
  late SessionService _sessionService;

  @override
  void initState() {
    super.initState();
    _bloc = GetIt.instance<LoginBloc>();
    _sessionService = GetIt.instance<SessionService>();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      _bloc.add(LoginSubmitted(email: _emailController.text.trim().toLowerCase(), password: _passwordController.text));
    }
  }

  void _navigateToRegister() {
    Navigator.pushNamed(context, RouteName.register.path);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: BlocConsumer<LoginBloc, LoginState>(
        bloc: _bloc,
        listener: (context, state) {
          _handleLoginState(state);
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: AppDimensions.paddingAllL,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: AppDimensions.spaceXXL),

                  // Header Section
                  AuthHeader(title: context.l10n.welcomeBack, subtitle: context.l10n.loginSubtitle),

                  const SizedBox(height: AppDimensions.spaceXXL),

                  // Login Form
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
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
                          hintText: context.l10n.passwordHint,
                          textInputAction: TextInputAction.done,
                          validator: ValidationUtils.validatePassword,
                          onFieldSubmitted: (_) => _handleLogin(),
                        ),

                        const SizedBox(height: AppDimensions.spaceXL),

                        // Login Button
                        GlobalButton(text: context.l10n.signIn, onPressed: _handleLogin, isLoading: _isLoading),

                        const SizedBox(height: AppDimensions.spaceXL),

                        // Divider
                        Row(
                          children: [
                            const Expanded(child: Divider()),
                            Padding(
                              padding: AppDimensions.paddingHorizontalM,
                              child: Text(
                                context.l10n.or,
                                style: AppTextStyles.bodyMedium.copyWith(color: theme.colorScheme.onSurfaceVariant),
                              ),
                            ),
                            const Expanded(child: Divider()),
                          ],
                        ),

                        const SizedBox(height: AppDimensions.spaceXL),

                        // Register Link
                        AuthLinkText(
                          normalText: context.l10n.dontHaveAccount,
                          linkText: context.l10n.signUp,
                          onTap: _navigateToRegister,
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

  void _handleLoginState(LoginState state) {
    if (state is LoginLoading) {
      _handleLoadingState(true);
    } else if (state is LoginSuccess) {
      _handleLoadingState(false);

      // Save token to session
      _sessionService.saveToken(
        accessToken: state.data.accessToken,
        tokenType: state.data.tokenType,
        expiresIn: state.data.expiresIn,
      );

      // Navigate to home page
      Navigator.pushNamedAndRemoveUntil(context, RouteName.home.path, (route) => false);
    } else if (state is LoginFailure) {
      _handleLoadingState(false);
      ErrorDialog.show(context, state.failure);
    }
  }

  void _handleLoadingState(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }
}
