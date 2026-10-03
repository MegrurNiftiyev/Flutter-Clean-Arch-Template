import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/components/custom_snackbar.dart';
import '../../../../../core/constants/durations.dart';
import '../../../../../core/constants/paddings.dart';
import '../../../../../core/constants/spaces.dart';
import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/enums/status.dart';
import '../../../../../core/extensions/string_extensions.dart';
import '../../../../../core/router/app_routes.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_text_field.dart';
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

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  void onVerify() {
    if (formKey.currentState?.validate() ?? false) {
      context.read<VerifyOtpCubit>().verifyOtp(
            email: widget.email,
            otpCode: otpController.text.trim(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('auth.verify_otp'.tr()),
      ),
      body: BlocConsumer<VerifyOtpCubit, VerifyOtpState>(
        listener: (context, state) async {
          if (state.status == Status.Failure) {
            AppSnackBar.showDanger(
              context: context,
              message: state.errorMessage ?? 'general.error'.tr(),
            );
          } else if (state.status == Status.Success && state.resetToken != null) {
            AppSnackBar.showSuccess(
              context: context,
              message: 'auth.otp_verified_success'.tr(),
            );
            // Wait 2 seconds before automatically proceeding to reset password page
            await Future.delayed(AppDurations.snackBar);
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
          final isLoading = state.status == Status.Loading;

          return Padding(
            padding: AppPaddings.page,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    controller: otpController,
                    labelText: 'auth.otp_code'.tr(),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => onVerify(),
                    validator: (value) => value.validateRequired(
                      'auth.otp_code'.tr(),
                    ),
                  ),
                  AppSpaces.v24,
                  CustomButton(
                    text: 'auth.verify'.tr(),
                    isLoading: isLoading,
                    onPressed: onVerify,
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
