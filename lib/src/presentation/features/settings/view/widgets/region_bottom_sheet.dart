import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../core/components/custom_bottom_sheet.dart';
import '../../../../../core/enums/app_region.dart';
import 'language_tile.dart';

class RegionBottomSheet extends StatelessWidget {
  const RegionBottomSheet({
    super.key,
    required this.currentRegionCode,
    required this.onRegionSelected,
  });

  final String currentRegionCode;
  final ValueChanged<String> onRegionSelected;

  static Future<void> show({
    required BuildContext context,
    required String currentRegionCode,
    required ValueChanged<String> onRegionSelected,
  }) {
    return CustomBottomSheet.show(
      context: context,
      title: 'settings.region'.tr(),
      child: RegionBottomSheet(
        currentRegionCode: currentRegionCode,
        onRegionSelected: onRegionSelected,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: AppRegion.values.length,
      itemBuilder: (context, index) {
        final region = AppRegion.values[index];
        final isSelected =
            region.code.toUpperCase() == currentRegionCode.toUpperCase();

        return LanguageTile(
          text: 'settings.region_${region.code.toLowerCase()}'.tr(),
          selected: isSelected,
          icon: Icons.public_outlined,
          onTap: () {
            Navigator.of(context).pop();
            onRegionSelected(region.code);
          },
        );
      },
    );
  }
}
