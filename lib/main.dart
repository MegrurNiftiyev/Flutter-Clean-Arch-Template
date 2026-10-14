import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'main_app.dart';
import 'src/core/constants/app_configs.dart';
import 'src/core/di/dependency_injection.dart';
import 'src/core/managers/env_manager.dart';
import 'src/presentation/global_cubits/settings/settings_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await EnvManager.init();
  await initializeDependencies();
  await sl<SettingsCubit>().load();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    EasyLocalization(
      supportedLocales: AppConfigs.supportedLocales,
      path: AppConfigs.langPath,
      fallbackLocale: AppConfigs.fallbackLocale,
      child: const MainApp(),
    ),
  );
}
