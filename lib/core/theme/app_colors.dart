import 'package:flutter/material.dart';

/// The single source of truth for every color used by the application.
///
/// Names describe the color's role in the UI, so changing a design token here
/// updates every widget that consumes it.
abstract final class AppColors {
  // Brand
  static const Color primary = Color(0xFFBFA054);
  static const Color primaryAction = Color(0xFFC7A84B);
  static const Color primaryFocused = Color(0xFFC49E47);

  // Surfaces
  static const Color background = Color(0xFFF9F5FA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color inputBackground = Color(0xFFF7F8F9);
  static const Color searchBackground = Color(0xFFF5F5F5);
  static const Color productBackground = Color(0xFFF5EFE1);

  // Text and icons
  static const Color textPrimary = Color(0xFF1E1E1E);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color hint = Color(0xFF8391A1);
  static const Color iconPrimary = Color(0xFF000000);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Borders and disabled states
  static const Color border = Color(0xFFE8ECF4);
  static const Color borderLight = Color(0xFFEEEEEE);
  static const Color borderMedium = Color(0xFFE0E0E0);
  static const Color disabled = Color(0xFFE0E0E0);

  // Feedback
  static const Color success = Color(0xFF1FC16B);
  static const Color successAlt = Color(0xFF22C55E);
  static const Color error = Color(0xFFF44336);
  static const Color errorBackground = Color(0xFFFFEBEE);
  static const Color warning = Color(0xFFFFA000);

  // Compatibility aliases. Remove them after all features use semantic names.
  @Deprecated('Use primary instead')
  static const Color mainColor = primary;
  @Deprecated('Use border instead')
  static const Color borderColor = border;
  @Deprecated('Use inputBackground instead')
  static const Color grayColor = inputBackground;
  @Deprecated('Use hint instead')
  static const Color darkGrayColor = hint;
  @Deprecated('Use textSecondary instead')
  static const Color subTitleColor = textSecondary;
  @Deprecated('Use textPrimary instead')
  static const Color titleColor = textPrimary;
  @Deprecated('Use productBackground instead')
  static const Color productBackgroundColor = productBackground;
}
