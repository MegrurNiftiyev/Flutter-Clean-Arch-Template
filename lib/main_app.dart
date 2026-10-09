import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'src/core/constants/app_configs.dart';
import 'src/core/di/dependency_injection.dart';
import 'src/core/router/app_routes.dart';
import 'src/core/router/app_router.dart';
import 'src/core/theme/theme.dart';
import 'src/presentation/global_cubits/settings/settings_cubit.dart';
import 'src/presentation/global_cubits/settings/settings_state.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SettingsCubit>(
          create: (_) => sl<SettingsCubit>()..load(),
        ),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: AppConfigs.designSize,
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                title: 'general.app_title'.tr(),
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                routerConfig: AppRouter.router,
                builder: (context, child) {
                  return BlocListener<SettingsCubit, SettingsState>(
                    listenWhen: (previous, current) =>
                        !previous.loggedOut && current.loggedOut,
                    listener: (context, state) {
                      AppRouter.router.go(AppRoute.login.path);
                    },
                    child: child!,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
