# Zhuchka System (Flutter web)

Internal / admin UI (**staff console**). This repo targets **web only** (no mobile/desktop platforms in the tree).

**Where this lives:** in the monorepo clone this package is at `frontend/system` (`ZhuchkaKeyboards`).

**UI / UX requirements:** [`docs/frontend-requirements.md`](https://github.com/ZhuchkaTriplesix/ZhuchkaKeyboards/blob/dev/docs/frontend-requirements.md) in the monorepo (Material 3, OLED `#000000` scaffold, System vs Market differences).

**Theme:** `lib/theme/system_theme.dart` — `buildZhuchkaSystemTheme()`, `ZhuchkaSystemTokens` (`oledBlack` for scaffold).

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

There is **no** required `dart-define` or `.env` file in the bootstrap app yet. When the HTTP client and auth base URL are wired in, prefer:

- **`--dart-define=API_BASE_URL=...`** (and similar keys) for build-time configuration, **or**
- documented runtime configuration if your deployment requires it.

Document new variables in this README when they are introduced.

---

## CI

Flutter checks for this package are also run from the **monorepo** GitHub Actions when the `frontend/system` submodule pointer is updated (see root `.github/workflows` in `ZhuchkaKeyboards`).
