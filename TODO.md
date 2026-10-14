# Project TODO List



## 2. Onboarding & Logo Assets
- [ ] Source and add high-resolution image assets for Onboarding screens (`assets/images/onboarding/`).
- [ ] Source and add official App Logo assets (`assets/images/logo.png`).
- [ ] Re-run `dart run build_runner build --delete-conflicting-outputs` to regenerate assets.

## 3. Enhanced Navigation Bar & Shell Architecture
- [ ] Implement a full `ShellRoute` / `StatefulShellRoute` in GoRouter for persistent bottom navigation.
- [ ] Integrate a middle action/transfer screen with tab switching logic and custom tab bar container.

## 4. Comprehensive Testing Suite
- [ ] Add Unit Tests for Repositories and Data Sources.
- [ ] Add Unit Tests for Use Cases and Cubits.
- [ ] Add Widget/UI Tests for core pages and components (excluding complex third-party OTP SMS verification flows).

## 5. Auth Gate & Guest Mode Integration
- [ ] Implement Guest Mode state in Auth logic.
- [ ] Automatically prompt/redirect guest users to `LoginPage` when attempting to perform actions requiring authenticated credentials.

## 6. API Response Schema Alignment
- [ ] Align API Response generic handling (`ApiResponse<T>`) and error handling schema directly with the Kotlin project reference implementation. Ensure the structure perfectly matches the backend envelope parsing strategy used in the Android/Kotlin architecture.

## 7. Authentication Flow, Theming & UI Improvements
- [ ] Onboarding Page: Remove default AppBar, eliminate background elevation mismatch with Scaffold, and position a dedicated 'Skip' button at the top-right corner inside SafeArea.
- [ ] Forgot Password Navigation: Replace slide transition with a smooth `FadeTransition` in GoRouter (`AppRouter`).
- [ ] Theme Context & Dynamic Typography Adaptation:
  - Discontinue hardcoded static colors (`AppColors.textPrimary`) in typography tokens (`AppTextStyles`) so texts dynamically respect dark/light theme context.
  - Implement comprehensive `AppBarTheme` and `DialogTheme` in `AppTheme.lightTheme` and `AppTheme.darkTheme` to guarantee title, icons, and dialog texts automatically switch between dark and light modes.
  - Update `CustomRichText` to inherit ambient theme styles (`Theme.of(context).textTheme.bodyMedium` and `onSurface`) ensuring high contrast in dark mode.
  - Ensure headers (Login/Register welcome texts, `CustomIconHeader`, dialog titles, and OTP fields) derive styles directly from `Theme.of(context)`.
- [ ] Comprehensive Localization & Auth Keys Alignment:
  - Add missing translation keys (`forgot_password_desc`, `otp_desc`, `didnt_receive_code`, `resend_code_in`, `resend_code`) to all 8 supported language files (`az.json`, `tr.json`, `ru.json`, `de.json`, `es.json`, `fr.json`, `ar.json`, `en.json`).
  - Replace English placeholder values in non-English translation files (specifically Azerbaijani and Turkish) for fields such as `name`, `password`, `send_code`, `verify_otp`, `new_password`, and `reset_password`.
  - Fix language fallback issue on the Forgot Password screen where missing description keys caused English fallback beside localized bottom action buttons.