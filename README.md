<h1 align="center" id="header">
  Dev Metrics - Flutter Multi-Platform Developer Analytics
</h1>

<p align="center">
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter">
  <img src="https://img.shields.io/badge/Supabase-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white" alt="Supabase">
  <img src="https://img.shields.io/badge/PostgreSQL-4169E1?style=for-the-badge&logo=postgresql&logoColor=white" alt="PostgreSQL">
  <img src="https://img.shields.io/badge/Material_Design_3-757575?style=for-the-badge&logo=material-design&logoColor=white" alt="Material Design 3">
  <img src="https://img.shields.io/badge/MVVM-Architecture-blueviolet?style=for-the-badge" alt="MVVM">
  <img src="https://img.shields.io/badge/Provider-State_Management-orange?style=for-the-badge" alt="Provider">
</p>

<p align="center">
  A multi-platform Flutter app for tracking and visualizing developer productivity metrics. Built with MVVM architecture, Supabase (PostgreSQL + Auth), FL Chart, PDF export, i18n, Dark Mode, GoRouter, Provider, Responsive Layout, Sentry, Google Fonts, and Material Design 3.
</p>

---

<h2 id="stack">Tech Stack</h2>

<p>
  <img src="https://github.com/tandpfun/skill-icons/blob/main/icons/Dart-Dark.svg" width="48" title="Dart">
  <img src="https://github.com/tandpfun/skill-icons/blob/main/icons/Flutter-Dark.svg" width="48" title="Flutter">
  <img src="https://github.com/tandpfun/skill-icons/blob/main/icons/Supabase-Dark.svg" width="48" title="Supabase">
  <img src="https://github.com/tandpfun/skill-icons/blob/main/icons/PostgreSQL-Dark.svg" width="48" title="PostgreSQL">
  <img src="https://github.com/tandpfun/skill-icons/blob/main/icons/AndroidStudio-Dark.svg" width="48" title="Android Studio">
  <img src="https://github.com/tandpfun/skill-icons/blob/main/icons/Sentry.svg" width="48" title="Sentry">
  <img src="https://github.com/tandpfun/skill-icons/blob/main/icons/Figma-Dark.svg" width="48" title="Figma">
</p>

### Core Technologies

- **Dart** - Programming language
- **Flutter** - Cross-platform UI framework
- **Material Design 3** - Modern design system
- **MVVM** - Architecture pattern (Model - View - ViewModel)
- **Provider** - State management solution

### Backend & Data

- **Supabase** - Backend-as-a-Service (BaaS)
- **PostgreSQL** - Relational database via Supabase
- **Supabase Auth** - Authentication (email/password, OAuth, magic link)
- **Supabase Realtime** - Live data sync across devices

### Features & Integrations

- **Multi-Platform Support** - Android & iOS
- **FL Chart** - Rich, animated charts and graphs for metrics visualization
- **PDF Export** - Generate and download metric reports as PDF
- **Printing** - Print reports and dashboards directly from the app
- **Google Fonts** - Beautiful typography
- **i18n** - Multi-language support (EN / PT-BR / ES)
- **Dark Mode Provider** - Theme switching
- **GoRouter** - Declarative routing with adaptive navigation (mobile/web)
- **Flutter Local Notifications** - Push notifications
- **Responsive Layout** - Adaptive UI
- **Sentry Logs** - Error tracking and monitoring

---

<h2 id="prerequisites">Prerequisites</h2>

Before starting, ensure you have the following installed:

- [FVM (Flutter Version Management)](https://fvm.app/documentation/getting-started/installation) - Required for managing Flutter versions
- [Git](https://git-scm.com/)
- [Supabase Account](https://supabase.com/) - For backend, database, and auth
- [Xcode](https://developer.apple.com/xcode/) (for iOS development on macOS)
- [Android Studio](https://developer.android.com/studio) (for Android development)

> **Note**: This project uses FVM for Flutter version management. You don't need to install Flutter globally.

> Optional: [VS Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio) with Flutter plugins for IDE support.

---

<h2 id="installation">Installation & Setup</h2>

### 1. Clone the Repository

```bash
git clone https://github.com/Victor-Zarzar/flutter-dev-metrics
cd flutter-dev-metrics
```

### 2. Open in your editor (example: Zed Editor)

```bash
zed .
```

### 3. Install Dependencies

```bash
make install
```

### 4. Configure Supabase

Pass the variables via `--dart-define` when running or building the app:

```bash
flutter run -d "iPhone 17" \
  --dart-define=SUPABASE_URL=https://your-project.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=your-anon-key \
  --dart-define=SENTRY_DSN=your-sentry-dsn \
  --dart-define=SENTRY_ENV=development
```

Then initialize Supabase in your app entry point:

```dart
import 'package:dev_metrics/app/config/app_config.dart';

await AppConfig.init();
```

> **Note**: For release builds, `--dart-define` flags are already included via the `Makefile` targets. Make sure to pass them when invoking `make`.

### 5. Run Database Migrations

Apply the provided SQL migrations to your Supabase project via the Supabase dashboard or CLI:

```bash
supabase db push
```

---

<h2 id="usage">Usage</h2>

### Local Development

#### Mobile (iOS Simulator)

```bash
make run-ios
```

### Inspect Devtools

```bash
dart devtools
```

---

<h2 id="development">Development</h2>

### Code Analysis

Check for code issues:

```bash
flutter analyze
```

### Testing

Run all tests:

```bash
flutter test
```

### Format Code

Format all files:

```bash
dart format .
```

### Clean Build Artifacts

```bash
make clean
```

---

<h2 id="deployment">Deployment</h2>

All release builds are handled via the `Makefile` and include `--obfuscate` and `--split-debug-info` automatically. Make sure your environment variables are set before building.

### Android (Google Play Store)

Build release APK:

```bash
make build-apk-release
```

Build release AppBundle:

```bash
make build-appbundle-release
```

The generated files will be at:

- APK: `build/app/outputs/flutter-apk/app-release.apk`
- AppBundle: `build/app/outputs/bundle/release/app-release.aab`
- Debug symbols: `build/debug-info/`

### iOS (App Store)

```bash
make build-ios-release
```

The generated files will be at:

- IPA: `build/ios/ipa/`
- Debug symbols: `build/debug-info/`

### Sentry Configuration

All production builds include:

- **Error tracking** with Sentry DSN
- **Code obfuscation** for security
- **Debug symbols** upload for crash symbolication

Make sure to:

1. Set your `SENTRY_DSN` and `SENTRY_ENV` in your environment or `.env` file
2. Upload debug symbols to Sentry after each release for proper stack traces
3. Keep `build/debug-info/` directory for symbolication

---

<h2 id="contributing">
  Contributing
</h2>

1. Fork the project
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Open a Pull Request

Report issues at: https://github.com/Victor-Zarzar/flutter-dev-metrics/issues

---

<h2 id="license">License</h2>

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

<h2 id="contact">Contact</h2>

Victor Zarzar - [@Victor-Zarzar](https://github.com/Victor-Zarzar)

Project Link: [https://github.com/Victor-Zarzar/flutter-dev-metrics](https://github.com/Victor-Zarzar/flutter-dev-metrics)

---
