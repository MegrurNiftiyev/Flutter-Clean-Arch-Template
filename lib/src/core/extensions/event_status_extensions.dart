import 'package:flutter/material.dart';

import '../enums/event_status.dart';
import '../theme/colors.dart';

extension EventStatusX on EventStatus {
  IconData get icon => switch (this) {
        EventStatus.info => Icons.info_outline_rounded,
        EventStatus.success => Icons.check_circle_outline_rounded,
        EventStatus.warning => Icons.warning_amber_rounded,
        EventStatus.error => Icons.error_outline_rounded,
      };

  Color get color => switch (this) {
        EventStatus.info => AppColors.primary,
        EventStatus.success => AppColors.success,
        EventStatus.warning => AppColors.warning,
        EventStatus.error => AppColors.error,
      };
}
