import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class InputsScreen extends StatefulWidget {
  const InputsScreen({super.key});
  @override
  State<InputsScreen> createState() => _InputsScreenState();
}

class _InputsScreenState extends State<InputsScreen> {
  bool _notifications = true;
  bool _darkMode = false;
  bool _analytics = true;
  bool _twoFactor = false;
  String? _selectedRole;
  String? _selectedCountry;
  final _nameCtrl = TextEditingController();
  final _bioCtrl = TextEditingController();
  String _otpValue = '';

  @override
  void dispose() {
    _nameCtrl.dispose();
    _bioCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppTopBar(title: 'Forms & Inputs', showBack: true),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [

          _section('Floating Label Text Fields', isDark),
          AppTextField(
            label: 'Full Name',
            hint: 'Enter your full name',
            prefixIcon: const Icon(Icons.person_outline_rounded),
            controller: _nameCtrl,
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            label: 'Email Address',
            hint: 'you@example.com',
            prefixIcon: const Icon(Icons.email_outlined),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            label: 'Password',
            hint: 'At least 8 characters',
            prefixIcon: const Icon(Icons.lock_outline_rounded),
            obscureText: true,
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            label: 'Phone Number',
            hint: '+1 (555) 000-0000',
            prefixIcon: const Icon(Icons.phone_outlined),
            keyboardType: TextInputType.phone,
            helper: 'We\'ll only use this for account recovery',
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            label: 'Website URL (error state)',
            hint: 'https://yoursite.com',
            prefixIcon: const Icon(Icons.link_rounded),
            errorText: 'Please enter a valid URL',
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            label: 'Username',
            hint: 'Choose a unique username',
            prefixIcon: const Icon(Icons.alternate_email_rounded),
            maxLength: 20,
            showCharCount: true,
          ),

          _section('Search Bar', isDark),
          AppSearchBar(
            hint: 'Search products, orders...',
            onFilterTap: () {},
          ),
          const SizedBox(height: AppSpacing.sm),
          AppSearchBar(hint: 'Read-only search bar', readOnly: true, onTap: () {}),

          _section('Textarea with Character Counter', isDark),
          AppTextArea(
            label: 'Bio',
            hint: 'Tell the world about yourself...',
            maxLength: 250,
            minLines: 4,
            controller: _bioCtrl,
          ),

          _section('OTP / Verification Code', isDark),
          AppCard(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Enter the 6-digit code sent to your phone', style: AppTextStyles.bodyMedium(isDark)),
              const SizedBox(height: AppSpacing.md),
              OtpInput(
                length: 6,
                onCompleted: (v) => setState(() => _otpValue = v),
                onChanged: (v) => setState(() => _otpValue = v),
              ),
              if (_otpValue.length == 6) ...[
                const SizedBox(height: AppSpacing.md),
                Row(children: [
                  const Icon(Icons.check_circle_rounded, color: AppColors.success, size: 16),
                  const SizedBox(width: 6),
                  Text('Code entered: $_otpValue',
                      style: const TextStyle(
                        fontFamily: 'Sora', fontSize: 13,
                        color: AppColors.success, fontWeight: FontWeight.w600,
                      )),
                ]),
              ],
            ]),
          ),

          _section('Dropdowns', isDark),
          AppDropdownField<String>(
            label: 'Role',
            value: _selectedRole,
            hint: 'Select your role',
            prefixIcon: const Icon(Icons.work_outline_rounded),
            items: const [
              DropdownMenuItem(value: 'designer', child: Text('Designer')),
              DropdownMenuItem(value: 'developer', child: Text('Developer')),
              DropdownMenuItem(value: 'manager', child: Text('Manager')),
              DropdownMenuItem(value: 'other', child: Text('Other')),
            ],
            onChanged: (v) => setState(() => _selectedRole = v),
          ),
          const SizedBox(height: AppSpacing.md),
          AppDropdownField<String>(
            label: 'Country',
            value: _selectedCountry,
            hint: 'Select your country',
            prefixIcon: const Icon(Icons.flag_outlined),
            items: const [
              DropdownMenuItem(value: 'ma', child: Text('🇲🇦 Morocco')),
              DropdownMenuItem(value: 'us', child: Text('🇺🇸 United States')),
              DropdownMenuItem(value: 'fr', child: Text('🇫🇷 France')),
              DropdownMenuItem(value: 'de', child: Text('🇩🇪 Germany')),
            ],
            onChanged: (v) => setState(() => _selectedCountry = v),
          ),

          _section('Custom Toggle Switches', isDark),
          AppCard(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
            child: Column(children: [
              _switchTile(
                isDark, Icons.notifications_outlined, AppColors.orange500,
                'Push Notifications', 'Receive alerts and updates',
                _notifications, (v) => setState(() => _notifications = v),
              ),
              _divider(isDark),
              _switchTile(
                isDark, Icons.dark_mode_outlined, AppColors.info,
                'Dark Mode', 'Switch between themes',
                _darkMode, (v) => setState(() => _darkMode = v),
              ),
              _divider(isDark),
              _switchTile(
                isDark, Icons.bar_chart_rounded, AppColors.success,
                'Analytics', 'Help improve the app',
                _analytics, (v) => setState(() => _analytics = v),
              ),
              _divider(isDark),
              _switchTile(
                isDark, Icons.security_rounded, AppColors.warning,
                'Two-Factor Auth', 'Add an extra security layer',
                _twoFactor, (v) => setState(() => _twoFactor = v),
              ),
            ]),
          ),

          const SizedBox(height: 60),
        ],
      ),
    );
  }

  Widget _switchTile(bool isDark, IconData icon, Color color, String title, String subtitle,
      bool value, ValueChanged<bool> onChange) {
    return AppSwitchTile(
      title: title,
      subtitle: subtitle,
      value: value,
      onChanged: onChange,
      leading: Container(
        width: 38, height: 38,
        decoration: BoxDecoration(color: color.withOpacity(0.13), borderRadius: AppRadius.sm),
        child: Icon(icon, color: color, size: 19),
      ),
    );
  }

  Widget _divider(bool isDark) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Divider(
      color: isDark ? AppColors.dark400 : AppColors.light400,
      thickness: 0.5, height: 1,
    ),
  );
}

Widget _section(String title, bool isDark) => Padding(
  padding: const EdgeInsets.only(top: AppSpacing.lg, bottom: AppSpacing.sm),
  child: Row(children: [
    Container(width: 3, height: 16,
        decoration: BoxDecoration(gradient: AppGradients.orangePrimary, borderRadius: AppRadius.full)),
    const SizedBox(width: 8),
    Text(title, style: AppTextStyles.h3(isDark)),
  ]),
);