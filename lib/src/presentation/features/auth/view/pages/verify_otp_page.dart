import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/components/custom_snack_bar.dart';
import '../../../../../core/constants/durations.dart';
import '../../../../../core/constants/paddings.dart';
import '../../../../../core/constants/spaces.dart';
import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/enums/event_status.dart';
import '../../../../../core/enums/status.dart';
import '../../../../../core/router/app_routes.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_icon_header.dart';
import '../../../../widgets/custom_otp_field.dart';
import '../../../../widgets/custom_rich_text.dart';
import '../../cubit/verify_otp/verify_otp_cubit.dart';
import '../../cubit/verify_otp/verify_otp_state.dart';

class VerifyOtpPage extends StatelessWidget {
  const VerifyOtpPage({
    super.key,
    required this.email,
  });

  final String email;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<VerifyOtpCubit>(),
      child: VerifyOtpView(email: email),
    );
  }
}

class VerifyOtpView extends StatefulWidget {
  const VerifyOtpView({
    super.key,
    required this.email,
  });

  final String email;

  @override
  State<VerifyOtpView> createState() => VerifyOtpViewState();
}

class VerifyOtpViewState extends State<VerifyOtpView> {
  final otpController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  Timer? _timer;
  int _countdown = 30;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    setState(() {
      _countdown = 30;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        setState(() {
          _countdown--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void onResend() {
    context.read<VerifyOtpCubit>().resendOtp(widget.email);
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    otpController.dispose();
    super.dispose();
  }

  void onVerify() {
    if (formKey.currentState?.validate() ?? false) {
      if (otpController.text.length == 6) {
        setState(() {
          hasError = false;
        });
        context.read<VerifyOtpCubit>().verifyOtp(
              widget.email,
              otpController.text.trim(),
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<VerifyOtpCubit, VerifyOtpState>(
        listener: (context, state) async {
          if (state.status == Status.failure) {
            setState(() {
              hasError = true;
            });
            final errorMessage = state.errorMessage;
            if (errorMessage != null) {
              CustomSnackBar.showError(context, message: errorMessage);
            }
          } else if (state.status == Status.success &&
              state.resetToken != null) {
            CustomSnackBar.show(
              context,
              message: 'auth.otp_verified_success'.tr(),
              type: EventStatus.success,
            );
            // Wait 2 seconds before automatically proceeding to reset password page
            await Future.delayed(AppDurations.s2);
            if (context.mounted) {
              context.pushReplacementNamed(
                AppRoute.resetPassword.name,
                extra: {
                  'email': widget.email,
                  'resetToken': state.resetToken!,
                },
              );
            }
          }
        },
        builder: (context, state) {
          final isLoading = state.status == Status.loading;

          return Padding(
            padding: AppPaddings.a16,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconHeader(
                    icon: Icons.domain_verification_outlined,
                    title: 'auth.verify_otp'.tr(),
                    subtitle: 'auth.otp_desc'.tr(),
                  ),
                  AppSpaces.v32,
                  CustomOtpField(
                    controller: otpController,
                    hasError: hasError,
                    onCompleted: (_) => onVerify(),
                  ),
                  AppSpaces.v32,
                  CustomButton(
                    text: 'auth.verify'.tr(),
                    isLoading: isLoading,
                    onPressed: onVerify,
                  ),
                  AppSpaces.v24,
                  _countdown > 0
                      ? CustomRichText(
                          texts: [
                            'auth.didnt_receive_code'.tr(),
                            'auth.resend_code_in'.tr(args: ['$_countdown']),
                          ],
                          onTap: () {},
                          clickableStyle: AppTextStyles.bodyMedium.copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                            fontWeight: FontWeight.normal,
                          ),
                        )
                      : CustomRichText(
                          texts: [
                            'auth.didnt_receive_code'.tr(),
                            'auth.resend_code'.tr(),
                          ],
                          onTap: () {
                            if (!isLoading) onResend();
                          },
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
