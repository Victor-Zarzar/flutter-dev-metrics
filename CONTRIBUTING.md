<h1 align="center">Contributing to Flutter Dev Metrics</h1>
<p align="center">
  Thanks for your interest in contributing to this project!
</p>

---

## Ways to Contribute

- Report bugs
- Propose new features or improvements
- Improve UI components and accessibility
- Improve docs (README / examples / translations)
- Add or improve i18n translations (EN / PT-BR / ES)

---

## Before You Start

- Check existing issues and pull requests first.
- Keep changes focused and small.
- For behavior changes, include clear reproduction/verification steps.
- Follow the existing code style (Dart, Flutter, MVVM, Provider conventions).

---

## Development Setup

1. Fork and clone the repository.
2. Follow the [Installation & Setup](README.md#installation) steps in the README.
3. Create a branch:
   - `feat/<short-name>` for features
   - `fix/<short-name>` for bug fixes
   - `docs/<short-name>` for documentation
4. Make your changes.
5. Run lint and format before committing:

```bash
flutter analyze
dart format .
```

---

## Pull Request Checklist

- [ ] Scope is focused and related to one topic.
- [ ] Code passes `flutter analyze` without errors.
- [ ] Code is formatted with `dart format .`.
- [ ] Documentation is updated if behavior/commands changed.
- [ ] No unrelated refactors or formatting-only changes.
- [ ] PR description includes: what changed, why, and how it was verified.
- [ ] Tests added or updated if applicable (`flutter test`).

---

## Commit Message Examples

- `feat: add dark mode toggle to settings screen`
- `fix: handle missing supabase connection gracefully`
- `docs: update environment setup instructions`
- `chore: bump dependencies`
- `i18n: add missing PT-BR translations`

---

## Coding Guidelines

- Prefer simple, readable, and type-safe Dart.
- Follow MVVM — keep Views free of business logic (use ViewModels via Provider).
- Keep widgets small and focused; extract into separate files when they grow.
- Use Material Design 3 components and tokens — avoid raw hardcoded colors or styles.
- Follow GoRouter patterns for new routes (no direct `Navigator.push` unless justified).
- Avoid breaking changes to existing Supabase schemas or auth flows without prior discussion.
- New screens must support responsive layout (mobile and web).

---

## Reporting Bugs

Please include:

- OS and device/emulator info
- Flutter and Dart version (`flutter --version`)
- Exact steps to reproduce
- Expected vs actual behavior
- Relevant terminal output or screenshots

Report issues at: https://github.com/Victor-Zarzar/flutter-dev-metrics

---

## Need Help?

Open an issue and provide context. We appreciate all contributions.
