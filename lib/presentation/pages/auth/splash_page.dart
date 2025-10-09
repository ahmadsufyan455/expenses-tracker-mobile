import 'package:expense_tracker_mobile/app/router.dart';
import 'package:expense_tracker_mobile/app/theme/app_colors.dart';
import 'package:expense_tracker_mobile/app/theme/app_dimensions.dart';
import 'package:expense_tracker_mobile/app/theme/app_text_styles.dart';
import 'package:expense_tracker_mobile/core/extensions/build_context_extensions.dart';
import 'package:expense_tracker_mobile/core/services/session_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:network_logger/network_logger.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startSplashSequence();
    if (kDebugMode) {
      NetworkLoggerOverlay.attachTo(context);
    }
  }

  void _setupAnimations() {
    _animationController = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeInOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
      ),
    );

    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 0.8, curve: Curves.easeOutCubic),
      ),
    );
  }

  bool _isLoggedIn() {
    final sessionService = GetIt.instance<SessionService>();
    return sessionService.isLoggedIn();
  }

  void _startSplashSequence() {
    _animationController.forward();
    Future.delayed(const Duration(milliseconds: 3000), () {
      if (mounted) {
        if (_isLoggedIn()) {
          Navigator.pushReplacementNamed(context, RouteName.home.path);
        } else {
          Navigator.pushReplacementNamed(context, RouteName.login.path);
        }
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: isDark ? AppColors.primaryGradientDark : AppColors.primaryGradient),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated Logo/Icon
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _fadeAnimation,
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.2),
                                blurRadius: 20,
                                offset: const Offset(0, 10),
                              ),
                            ],
                          ),
                          child: ClipOval(
                            child: Image.asset('assets/icons/app_icon.png', width: 120, height: 120, fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: AppDimensions.spaceXL),

                // Animated App Name
                AnimatedBuilder(
                  animation: _slideAnimation,
                  builder: (context, child) {
                    return SlideTransition(
                      position: _slideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Column(
                          children: [
                            Text(
                              'ExpenseTracker',
                              style: AppTextStyles.displayMedium.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                              textAlign: TextAlign.center,
                            ),

                            const SizedBox(height: AppDimensions.spaceM),

                            // Tagline
                            Text(
                              context.l10n.appTagline,
                              style: AppTextStyles.titleMedium.copyWith(
                                color: Colors.white.withValues(alpha: 0.9),
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.5,
                              ),
                              textAlign: TextAlign.center,
                            ),

                            const SizedBox(height: AppDimensions.spaceS),

                            // Subtitle
                            Text(
                              context.l10n.appSubtitle,
                              style: AppTextStyles.bodyLarge.copyWith(
                                color: Colors.white.withValues(alpha: 0.8),
                                fontWeight: FontWeight.w400,
                                letterSpacing: 2.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: AppDimensions.spaceXXL),

                // Loading Indicator
                AnimatedBuilder(
                  animation: _fadeAnimation,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _fadeAnimation,
                      child: const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 2.0,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
