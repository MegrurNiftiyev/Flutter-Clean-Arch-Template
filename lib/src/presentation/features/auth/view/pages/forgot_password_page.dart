import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/components/custom_snack_bar.dart';
import '../../../../../core/constants/paddings.dart';
import '../../../../../core/constants/spaces.dart';
import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/enums/status.dart';
import '../../../../../core/extensions/string_extensions.dart';
import '../../../../../core/router/app_routes.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../cubit/forgot_password/forgot_password_cubit.dart';
import '../../cubit/forgot_password/forgot_password_state.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ForgotPasswordCubit>(),
      child: const ForgotPasswordView(),
    );
  }
}

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => ForgotPasswordViewState();
}

class ForgotPasswordViewState extends State<ForgotPasswordView> {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void onSendCode() {
    if (formKey.currentState?.validate() ?? false) {
      context.read<ForgotPasswordCubit>().forgotPassword(
            emailController.text.trim(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('auth.forgot_password'.tr()),
      ),
      body: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state.status == Status.failure) {
            final errorMessage = state.errorMessage;
            if (errorMessage != null) {
              CustomSnackBar.showError(context, message: errorMessage);
            }
          } else if (state.status == Status.success) {
            context.pushNamed(
              AppRoute.verifyOtp.name,
              extra: emailController.text.trim(),
            );
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
                  CustomTextField(
                    controller: emailController,
                    labelText: 'auth.email'.tr(),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => onSendCode(),
                    validator: (value) => value.validateEmail(
                      emptyMessage: 'auth.email'.tr(),
                    ),
                  ),
                  AppSpaces.v24,
                  CustomButton(
                    text: 'auth.send_code'.tr(),
                    isLoading: isLoading,
                    onPressed: onSendCode,
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
