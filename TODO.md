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
