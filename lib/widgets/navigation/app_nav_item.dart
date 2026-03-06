import 'package:flutter/material.dart';

// ─────────────────────────────────────────────
//  BOTTOM NAV ITEM (data class)
// ─────────────────────────────────────────────
class AppNavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const AppNavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}
