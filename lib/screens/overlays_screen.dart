import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class OverlaysScreen extends StatelessWidget {
  const OverlaysScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppTopBar(title: 'Dialogs & Overlays', showBack: true),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [

          _section('Snack Bars / Toasts', isDark),
          AppCard(
            child: Column(children: [
              _toastRow(context, 'Success', SnackBarType.success, 'Changes saved successfully!', isDark),
              const SizedBox(height: AppSpacing.sm),
              _toastRow(context, 'Error', SnackBarType.error, 'Something went wrong. Try again.', isDark),
              const SizedBox(height: AppSpacing.sm),
              _toastRow(context, 'Warning', SnackBarType.warning, 'Your session is about to expire.', isDark),
              const SizedBox(height: AppSpacing.sm),
              _toastRow(context, 'Info', SnackBarType.info, 'A new update is available.', isDark),
            ]),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppButton(
            label: 'Toast with Action Button',
            fullWidth: true,
            variant: AppButtonVariant.ghost,
            onPressed: () => AppSnackBar.show(context,
              message: 'Message deleted',
              type: SnackBarType.info,
              actionLabel: 'Undo',
              onAction: () {},
              duration: const Duration(seconds: 5),
            ),
          ),

          _section('Confirmation Dialogs', isDark),
          Row(children: [
            Expanded(child: AppButton(
              label: 'Confirm Action',
              onPressed: () async {
                final result = await AppDialog.showConfirm(context,
                  title: 'Submit Report?',
                  message: 'Once submitted, this report will be sent to your manager for review.',
                  confirmLabel: 'Submit',
                  cancelLabel: 'Cancel',
                );
                if (result == true && context.mounted) {
                  AppSnackBar.show(context, message: 'Report submitted!', type: SnackBarType.success);
                }
              },
            )),
            const SizedBox(width: AppSpacing.sm),
            Expanded(child: AppButton(
              label: 'Danger Dialog',
              variant: AppButtonVariant.danger,
              onPressed: () async {
                final result = await AppDialog.showConfirm(context,
                  title: 'Delete Account?',
                  message: 'This will permanently delete all your data and cannot be undone.',
                  confirmLabel: 'Delete',
                  cancelLabel: 'Cancel',
                  isDangerous: true,
                );
                if (result == true && context.mounted) {
                  AppSnackBar.show(context, message: 'Account deleted', type: SnackBarType.error);
                }
              },
            )),
          ]),

          _section('Bottom Sheets', isDark),
          AppButton(
            label: 'Action Sheet',
            fullWidth: true,
            onPressed: () => AppBottomSheet.show(context,
              title: 'Post Options',
              child: Padding(
                padding: const EdgeInsets.fromLTRB(AppSpacing.md, 0, AppSpacing.md, AppSpacing.md),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  ListItemCard(
                    title: 'Edit Post',
                    leading: Container(width: 36, height: 36,
                      decoration: BoxDecoration(color: AppColors.orange500.withOpacity(0.12), borderRadius: AppRadius.sm),
                      child: const Icon(Icons.edit_rounded, color: AppColors.orange500, size: 18)),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  ListItemCard(
                    title: 'Share',
                    leading: Container(width: 36, height: 36,
                      decoration: BoxDecoration(color: AppColors.info.withOpacity(0.12), borderRadius: AppRadius.sm),
                      child: const Icon(Icons.share_rounded, color: AppColors.info, size: 18)),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  ListItemCard(
                    title: 'Archive',
                    leading: Container(width: 36, height: 36,
                      decoration: BoxDecoration(color: AppColors.warning.withOpacity(0.12), borderRadius: AppRadius.sm),
                      child: const Icon(Icons.archive_rounded, color: AppColors.warning, size: 18)),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  ListItemCard(
                    title: 'Delete Post',
                    leading: Container(width: 36, height: 36,
                      decoration: BoxDecoration(color: AppColors.error.withOpacity(0.12), borderRadius: AppRadius.sm),
                      child: const Icon(Icons.delete_rounded, color: AppColors.error, size: 18)),
                  ),
                ]),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppButton(
            label: 'Filter Bottom Sheet',
            fullWidth: true,
            variant: AppButtonVariant.secondary,
            onPressed: () => AppBottomSheet.show(context,
              title: 'Filter & Sort',
              child: Padding(
                padding: const EdgeInsets.fromLTRB(AppSpacing.md, 0, AppSpacing.md, AppSpacing.md),
                child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Category', style: AppTextStyles.h3(isDark)),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(spacing: 8, runSpacing: 8, children:
                    ['All', 'Design', 'Dev', 'Marketing', 'Finance'].map((l) =>
                      AppChip(label: l, selected: l == 'Design', onTap: () {})).toList()),
                  const SizedBox(height: AppSpacing.md),
                  const AppDivider(),
                  const SizedBox(height: AppSpacing.md),
                  Text('Sort By', style: AppTextStyles.h3(isDark)),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(spacing: 8, runSpacing: 8, children:
                    ['Newest', 'Popular', 'Rating'].map((l) =>
                      AppChip(label: l, selected: l == 'Newest', onTap: () {})).toList()),
                  const SizedBox(height: AppSpacing.lg),
                  AppButton(label: 'Apply Filters', fullWidth: true, onPressed: () => Navigator.pop(context)),
                ]),
              ),
            ),
          ),

          _section('Dividers', isDark),
          AppCard(
            child: Column(children: [
              Text('Content above', style: AppTextStyles.bodyMedium(isDark)),
              const SizedBox(height: AppSpacing.sm),
              const AppDivider(),
              const SizedBox(height: AppSpacing.sm),
              Text('Standard divider', style: AppTextStyles.bodySmall(isDark)),
              const SizedBox(height: AppSpacing.md),
              const AppDivider(label: 'OR'),
              const SizedBox(height: AppSpacing.sm),
              Text('Divider with label', style: AppTextStyles.bodySmall(isDark)),
              const SizedBox(height: AppSpacing.md),
              const AppDivider(label: 'Continue with'),
            ]),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _toastRow(BuildContext ctx, String label, SnackBarType type, String msg, bool isDark) {
    return Row(children: [
      Expanded(child: Text(label, style: AppTextStyles.bodyMedium(isDark))),
      AppButton(
        label: 'Show',
        size: AppButtonSize.small,
        variant: AppButtonVariant.ghost,
        onPressed: () => AppSnackBar.show(ctx, message: msg, type: type),
      ),
    ]);
  }
}

Widget _section(String title, bool isDark) => Padding(
  padding: const EdgeInsets.only(top: AppSpacing.lg, bottom: AppSpacing.sm),
  child: Row(children: [
    Container(width: 3, height: 16, decoration: BoxDecoration(gradient: AppGradients.orangePrimary, borderRadius: AppRadius.full)),
    const SizedBox(width: 8),
    Text(title, style: AppTextStyles.h3(isDark)),
  ]),
);