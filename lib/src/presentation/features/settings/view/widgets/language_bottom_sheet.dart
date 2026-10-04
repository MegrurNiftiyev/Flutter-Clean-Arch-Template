import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../core/components/custom_bottom_sheet.dart';
import '../../../../../core/enums/app_language.dart';
import 'language_tile.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({
    super.key,
    required this.currentLanguageCode,
    required this.onLanguageSelected,
  });

  final String currentLanguageCode;
  final ValueChanged<String> onLanguageSelected;

  static Future<void> show({
    required BuildContext context,
    required String currentLanguageCode,
    required ValueChanged<String> onLanguageSelected,
  }) {
    return CustomBottomSheet.show(
      context: context,
      title: 'settings.language'.tr(),
      child: LanguageBottomSheet(
        currentLanguageCode: currentLanguageCode,
        onLanguageSelected: onLanguageSelected,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: AppLanguage.values.length,
      itemBuilder: (context, index) {
        final lang = AppLanguage.values[index];
        final isSelected = lang.code == currentLanguageCode;

        return LanguageTile(
          text: 'settings.lang_${lang.code}'.tr(),
          selected: isSelected,
          icon: Icons.language_outlined,
          onTap: () {
            Navigator.of(context).pop();
            onLanguageSelected(lang.code);
          },
        );
      },
    );
  }
}
