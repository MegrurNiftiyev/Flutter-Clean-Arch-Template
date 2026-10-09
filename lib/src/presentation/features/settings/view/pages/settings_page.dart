import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_arch_template/src/presentation/global_cubits/settings/settings_cubit.dart';
import 'package:flutter_clean_arch_template/src/presentation/global_cubits/settings/settings_state.dart';
import '../../../../../core/enums/language_code.dart';

import '../../../../../core/components/custom_dialog.dart';
import '../../../../../core/components/custom_snack_bar.dart';
import '../../../../../core/constants/icon_sizes.dart';
import '../../../../../core/constants/paddings.dart';
import '../../../../../core/constants/spaces.dart';
import '../../../../../core/enums/status.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/text_styles.dart';
import '../widgets/language_bottom_sheet.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsView();
  }
}

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  void onLanguageTap(BuildContext context, String currentLangCode) {
    LanguageBottomSheet.show(
      context: context,
      currentLanguageCode: currentLangCode,
      onLanguageSelected: (newLangCode) {
        final newLang = LanguageCode.fromCode(newLangCode);
        context.read<SettingsCubit>().changeLanguage(newLang.code);
        context.setLocale(Locale(newLang.code));
      },
    );
  }

  void onLogoutTap(BuildContext context) {
    CustomAlertDialog.show(
      context: context,
      title: 'settings.logout'.tr(),
      subtitle: 'settings.logout_confirm'.tr(),
      icon: Icons.logout_rounded,
      isDanger: true,
      confirmText: 'general.yes'.tr(),
      cancelText: 'general.no'.tr(),
      onConfirm: () {
        context.read<SettingsCubit>().logout();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsCubit, SettingsState>(
      listener: (context, state) {
        if (state.status == Status.failure) {
          CustomSnackBar.showError(context, message: 'An error occurred');
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'settings.title'.tr(),
              style: AppTextStyles.titleLarge,
            ),
          ),
          body: Padding(
            padding: AppPaddings.a16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: Icon(
                    Icons.dark_mode_outlined,
                    size: AppIconSizes.s24,
                    color: AppColors.primary,
                  ),
                  title: Text(
                    'settings.dark_mode'.tr(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  trailing: Switch(
                    value: state.isDarkMode,
                    onChanged: (val) =>
                        context.read<SettingsCubit>().toggleTheme(val),
                    activeThumbColor: AppColors.primary,
                  ),
                ),
                AppSpaces.v8,
                ListTile(
                  leading: Icon(
                    Icons.language_outlined,
                    size: AppIconSizes.s24,
                    color: AppColors.primary,
                  ),
                  title: Text(
                    'settings.language'.tr(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'settings.lang_${state.language.code}'.tr(),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      AppSpaces.h4,
                      Icon(
                        Icons.chevron_right_rounded,
                        size: AppIconSizes.s24,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ],
                  ),
                  onTap: () => onLanguageTap(context, state.language.code),
                ),
                AppSpaces.v8,
                ListTile(
                  leading: Icon(
                    Icons.logout_rounded,
                    size: AppIconSizes.s24,
                    color: AppColors.error,
                  ),
                  title: Text(
                    'settings.logout'.tr(),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.error,
                    ),
                  ),
                  trailing: state.status == Status.loading 
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : null,
                  onTap: () => onLogoutTap(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
