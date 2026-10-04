import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/components/custom_dialog.dart';
import '../../../../../core/components/custom_snack_bar.dart';
import '../../../../../core/constants/paddings.dart';
import '../../../../../core/constants/spaces.dart';
import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/enums/status.dart';
import '../../../../../core/exceptions/auth_exception.dart';
import '../../../../../core/exceptions/network_exceptions.dart';
import '../../../../../core/extensions/string_extensions.dart';
import '../../../../../core/router/app_routes.dart';
import '../../../../../core/theme/text_styles.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_rich_text.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../cubit/login/login_cubit.dart';
import '../../cubit/login/login_state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LoginCubit>(),
      child: const LoginView(),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void onLogin() {
    if (formKey.currentState?.validate() ?? false) {
      context.read<LoginCubit>().login(
            emailController.text.trim(),
            passwordController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('auth.login'.tr()),
      ),
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status == Status.failure) {
            final exception = state.exception;
            if (exception == null) return;

            if (exception is NoInternetException ||
                exception is RequestTimeoutException) {
              CustomSnackBar.showError(context,
                  message: exception.message, onRetry: onLogin);
            } else if (exception is AuthEmailNotConfirmed) {
              CustomAlertDialog.show(
                context: context,
                title: exception.message,
                confirmText: 'general.ok'.tr(),
                onConfirm: () {
                  context.pushNamed(AppRoute.verifyOtp.name);
                },
              );
            } else if (exception is! AuthInvalidCredentials &&
                exception is! UnauthorizedException) {
              CustomSnackBar.showError(context, message: exception.message);
            }
          } else if (state.status == Status.success) {
            context.goNamed(AppRoute.home.name);
          }
        },
        builder: (context, state) {
          final isLoading = state.status == Status.loading;
          final isInvalid = state.exception is AuthInvalidCredentials;
          final inlineError = isInvalid ? state.exception!.message : null;

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
                    textInputAction: TextInputAction.next,
                    validator: (value) => value.validateEmail(
                      emptyMessage: 'auth.email'.tr(),
                    ),
                  ),
                  AppSpaces.v16,
                  CustomTextField(
                    controller: passwordController,
                    labelText: 'auth.password'.tr(),
                    obscureText: true,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => onLogin(),
                    errorText: inlineError,
                    validator: (value) => value.validatePassword(
                      emptyMessage: 'auth.password'.tr(),
                    ),
                  ),
                  AppSpaces.v8,
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        context.pushNamed(AppRoute.forgotPassword.name);
                      },
                      child: Text(
                        'auth.forgot_password'.tr(),
                        style: AppTextStyles.bodySmall,
                      ),
                    ),
                  ),
                  AppSpaces.v16,
                  CustomButton(
                    text: 'auth.login'.tr(),
                    isLoading: isLoading,
                    onPressed: onLogin,
                  ),
                  AppSpaces.v16,
                  CustomRichText(
                    texts: [
                      'auth.dont_have_account'.tr(),
                      'auth.register'.tr(),
                    ],
                    onTap: () {
                      context.pushNamed(AppRoute.register.name);
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
