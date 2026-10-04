import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/components/custom_snack_bar.dart';
import '../../../../../core/constants/paddings.dart';
import '../../../../../core/constants/spaces.dart';
import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/enums/status.dart';
import '../../../../../core/exceptions/network_exceptions.dart';
import '../../../../../core/extensions/string_extensions.dart';
import '../../../../../core/router/app_routes.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_rich_text.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../cubit/register/register_cubit.dart';
import '../../cubit/register/register_state.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<RegisterCubit>(),
      child: const RegisterView(),
    );
  }
}

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => RegisterViewState();
}

class RegisterViewState extends State<RegisterView> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void onRegister() {
    if (formKey.currentState?.validate() ?? false) {
      context.read<RegisterCubit>().register(
            emailController.text.trim(),
            passwordController.text,
            name: nameController.text.trim(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('auth.register'.tr()),
      ),
      body: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state.status == Status.failure) {
            final exception = state.exception;
            if (exception == null) return;

            if (exception is NoInternetException ||
                exception is RequestTimeoutException) {
              CustomSnackBar.showError(context,
                  message: exception.message, onRetry: onRegister);
            } else if (exception is! UnauthorizedException) {
              CustomSnackBar.showError(context, message: exception.message);
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
                  CustomTextField(
                    controller: nameController,
                    labelText: 'auth.name'.tr(),
                    textInputAction: TextInputAction.next,
                    validator: (value) =>
                        value.validateRequired('auth.name'.tr()),
                  ),
                  AppSpaces.v16,
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
                    onFieldSubmitted: (_) => onRegister(),
                    validator: (value) => value.validatePassword(
                      emptyMessage: 'auth.password'.tr(),
                    ),
                  ),
                  AppSpaces.v24,
                  CustomButton(
                    text: 'auth.register'.tr(),
                    isLoading: isLoading,
                    onPressed: onRegister,
                  ),
                  AppSpaces.v16,
                  CustomRichText(
                    texts: [
                      'auth.already_have_account'.tr(),
                      'auth.login'.tr(),
                    ],
                    onTap: () {
                      context.pop();
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
