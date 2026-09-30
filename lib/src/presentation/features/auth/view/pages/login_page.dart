import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('auth.login'.tr()),
      ),
      body: Center(
        child: Text('auth.login_page'.tr()),
      ),
    );
  }
}
