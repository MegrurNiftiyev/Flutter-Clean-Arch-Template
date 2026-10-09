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
import '../../../../../core/theme/colors.dart';
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
  bool rememberMe = false;

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
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status == Status.failure) {
            final errorMessage = state.errorMessage;
            if (errorMessage != null) {
              CustomSnackBar.showError(context, message: errorMessage);
            }
          } else if (state.status == Status.success) {
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'auth.welcome_login'.tr(),
                      style: AppTextStyles.displayLarge,
                    ),
                  ),
                  AppSpaces.v32,
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
                    validator: (value) => value.validatePassword(
                      emptyMessage: 'auth.password'.tr(),
                    ),
                  ),
                  AppSpaces.v8,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            rememberMe = !rememberMe;
                          });
                          // TODO: Implement remember me logic later
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Checkbox(
                                value: rememberMe,
                                activeColor: AppColors.primary,
                                onChanged: (value) {
                                  setState(() {
                                    rememberMe = value ?? false;
                                  });
                                  // TODO: Implement remember me logic later
                                },
                              ),
                            ),
                            AppSpaces.h8,
                            Text(
                              'auth.remember_me'.tr(),
                              style: AppTextStyles.bodySmall.copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          context.pushNamed(AppRoute.forgotPassword.name);
                        },
                        child: Text(
                          'auth.forgot_password'.tr(),
                          style: AppTextStyles.bodySmall,
                        ),
                      ),
                    ],
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
