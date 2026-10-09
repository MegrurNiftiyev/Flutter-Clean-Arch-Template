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
import '../../cubit/reset_password/reset_password_cubit.dart';
import '../../cubit/reset_password/reset_password_state.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({
    super.key,
    required this.email,
    required this.resetToken,
  });

  final String email;
  final String resetToken;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ResetPasswordCubit>(),
      child: ResetPasswordView(
        email: email,
        resetToken: resetToken,
      ),
    );
  }
}

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({
    super.key,
    required this.email,
    required this.resetToken,
  });

  final String email;
  final String resetToken;

  @override
  State<ResetPasswordView> createState() => ResetPasswordViewState();
}

class ResetPasswordViewState extends State<ResetPasswordView> {
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  void onResetPassword() {
    if (formKey.currentState?.validate() ?? false) {
      context.read<ResetPasswordCubit>().resetPassword(
            widget.resetToken,
            passwordController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('auth.reset_password'.tr()),
      ),
      body: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
        listener: (context, state) {
          if (state.status == Status.failure) {
            final errorMessage = state.errorMessage;
            if (errorMessage != null) {
              CustomSnackBar.showError(context, message: errorMessage);
            }
          } else if (state.status == Status.success) {
            // Password reset & automated login successful -> redirect straight to home!
            context.goNamed(AppRoute.home.name);
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
                    controller: passwordController,
                    labelText: 'auth.new_password'.tr(),
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => onResetPassword(),
                    validator: (value) => value.validatePassword(
                      emptyMessage: 'auth.new_password'.tr(),
                    ),
                  ),
                  AppSpaces.v24,
                  CustomButton(
                    text: 'auth.reset_password'.tr(),
                    isLoading: isLoading,
                    onPressed: onResetPassword,
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
