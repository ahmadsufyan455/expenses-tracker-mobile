import 'package:shared_preferences/shared_preferences.dart';

/// Utility class for managing app preferences
class PreferenceUtils {
  PreferenceUtils._();

  static const String _keyDefaultDashboardFilter = 'default_dashboard_filter';

  /// Save default dashboard filter preference
  static Future<bool> saveDefaultDashboardFilter(String filter) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(_keyDefaultDashboardFilter, filter);
  }

  /// Get saved default dashboard filter preference
  /// Returns null if no preference is saved
  static Future<String?> getDefaultDashboardFilter() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyDefaultDashboardFilter);
  }

  /// Clear default dashboard filter preference
  static Future<bool> clearDefaultDashboardFilter() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.remove(_keyDefaultDashboardFilter);
  }
}
