import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/components/custom_dialog.dart';
import '../../../../../core/components/custom_snackbar.dart';
import '../../../../../core/constants/icon_sizes.dart';
import '../../../../../core/constants/paddings.dart';
import '../../../../../core/constants/spaces.dart';
import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/enums/app_language.dart';
import '../../../../../core/enums/status.dart';
import '../../../../../core/router/app_routes.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../widgets/custom_button.dart';
import '../../cubit/settings_cubit.dart';
import '../../cubit/settings_state.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SettingsCubit>()..loadSettings(),
      child: const SettingsView(),
    );
  }
}

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsCubit, SettingsState>(
      listener: (context, state) {
        if (state.isLoggedOut) {
          context.goNamed(AppRoute.login.name);
        } else if (state.status == Status.Failure && state.errorMessage != null) {
          AppSnackBar.showDanger(
            context: context,
            message: state.errorMessage!,
          );
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
            padding: AppPaddings.all16,
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
                    style: AppTextStyles.bodyMedium,
                  ),
                  trailing: Switch(
                    value: state.isDarkMode,
                    onChanged: (val) => context.read<SettingsCubit>().toggleTheme(val),
                    activeThumbColor: AppColors.primary,
                  ),
                ),
                AppSpaces.v16,
                ListTile(
                  leading: Icon(
                    Icons.language_outlined,
                    size: AppIconSizes.s24,
                    color: AppColors.primary,
                  ),
                  title: Text(
                    'settings.language'.tr(),
                    style: AppTextStyles.bodyMedium,
                  ),
                  trailing: DropdownButton<String>(
                    value: state.languageCode,
                    items: AppLanguage.values.map((lang) {
                      return DropdownMenuItem<String>(
                        value: lang.code,
                        child: Text('settings.lang_${lang.code}'.tr()),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        context.read<SettingsCubit>().changeLanguage(val);
                        context.setLocale(Locale(val));
                      }
                    },
                  ),
                ),
                const Spacer(),
                CustomButton(
                  text: 'settings.logout'.tr(),
                  color: AppColors.error,
                  isLoading: state.status == Status.Loading,
                  onPressed: () {
                    CustomAlertDialog.show(
                      context: context,
                      title: 'settings.logout'.tr(),
                      subtitle: 'settings.logout_confirm'.tr(),
                      icon: Icons.logout_rounded,
                      isDanger: true,
                      onConfirm: () {
                        context.read<SettingsCubit>().logout();
                      },
                    );
                  },
                ),
                AppSpaces.v24,
              ],
            ),
          ),
        );
      },
    );
  }
}
