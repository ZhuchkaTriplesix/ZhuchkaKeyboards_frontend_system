# Zhuchka System (Flutter web)

Internal / admin UI (**staff console**). This repo targets **web only** (no mobile/desktop platforms in the tree).

**Where this lives:** in the monorepo clone this package is at `frontend/system` (`ZhuchkaKeyboards`).

**UI / UX requirements:** [`docs/frontend-requirements.md`](https://github.com/ZhuchkaTriplesix/ZhuchkaKeyboards/blob/dev/docs/frontend-requirements.md) in the monorepo (Material 3, OLED `#000000` scaffold, System vs Market differences).

**Theme:** `lib/theme/system_theme.dart` — `buildZhuchkaSystemTheme()`, `ZhuchkaSystemTokens` (`oledBlack` for scaffold).

**Routing:** [`go_router`](https://pub.dev/packages/go_router) + shell (`lib/widgets/system_shell.dart`): `NavigationRail` — `/` (dashboard), `/lists` (placeholder), `/settings` (placeholder). Router factory: `lib/app/system_router.dart` (`createSystemRouter()`).

**HTTP:** [`dio`](https://pub.dev/packages/dio) — `createSystemDio()` (`lib/http/system_dio.dart`): timeouts, retry for **GET** on transient failures (`RetryInterceptor`); API errors → `SystemApiException` via `systemApiExceptionFromDio()` (`lib/http/dio_error_mapper.dart`).

**Workflow:** one issue → one branch from `dev` → PR into `dev` (Git workflow for the monorepo: [`docs/git-workflow.md`](https://github.com/ZhuchkaTriplesix/ZhuchkaKeyboards/blob/dev/docs/git-workflow.md)).

---

## Prerequisites

- **Flutter** (stable channel) with a **Dart SDK** that satisfies `pubspec.yaml` (`environment.sdk`, currently `^3.11.3`). Run `flutter --version` and `dart --version` after install.
- **Chrome** (recommended target for `flutter run -d chrome`).

From the repo root:

```bash
flutter pub get
```

---

## Run (development)

```bash
flutter run -d chrome
```

Useful flags:

- `--web-port=8080` — fixed port (adjust if busy).
- `flutter run -d web-server` — serve without launching a browser (CI / headless debugging).

---

## Build (static site)

```bash
flutter build web
```

Output: `build/web/` — deploy this folder to any static host or behind a reverse proxy.

Release-ish build:

```bash
flutter build web --release
```

---

## Tests

```bash
flutter test
```

Static analysis (run before PRs):

```bash
dart analyze
```

---

## Environment and configuration

Build-time values use `--dart-define` (and `flutter build web --dart-define=...`):

| Variable | Purpose | Default |
|----------|---------|---------|
| `API_BASE_URL` | Base URL for `createSystemDio()` (gateway / auth / future BFF) | `http://127.0.0.1:8000` |

Example:

```bash
flutter run -d chrome --dart-define=API_BASE_URL=https://api.example.com
```

---

## CI

On push/PR to `dev`, `main`, or `master`, `.github/workflows/flutter_ci.yml` runs `flutter analyze`, `flutter test`, and `flutter build web --release` on Ubuntu (stable SDK).

The **monorepo** `ZhuchkaKeyboards` also runs analyze + test for `frontend/system` when the submodule pointer is updated (see `.github/workflows/flutter-apps-reusable.yml`).
