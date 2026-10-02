# AGENTS.md

Single-package **Flutter** repo, `main` only, remote
`github.com/dzw08/gym-tracker`. No workspace, no path deps, no CI, no pre-commit
hooks, no codegen.

## This is A-Level coursework (OCR)

This repo is the artefact for the **OCR A Level Computer Science Unit 3/4
Programming Project** (the NEA), not a production codebase. The department
template at `project/NEA Write-Up.odt` is the grading spec — read it before
starting a feature.

Marked sections, per the template's table of contents: analysis 10, design 15,
developing 25, evaluation 20.

**Deadlines (template "KEY DATES").** Software "nearly completed by Christmas";
hand-in "towards the end of the Easter Term". The code must therefore be
demonstrable well before hand-in, not finished at it.

**The code is the evidence.** The developing and evaluation sections demand
*annotated evidence*: screenshots of code being written, test tables of test
data → predicted outcome → actual outcome → pass/fail, three user scenarios
(valid / borderline / invalid), a user acceptance questionnaire, and working
screenshots. In practice:

- Commit in small, working increments with meaningful messages. Annotated
  evidence of each stage of iteration is required, so the git history is
  itself evidence — don't squash it into one commit at the end. No convention
  exists yet, so the early commits set the pattern.
- Keep planned test tables in step with `test/`. Each test should be traceable
  to a test data row, and the write-up tables are reused verbatim in the
  evaluation.
- Don't hide failure. The template explicitly asks to "show me failures" and
  "show me how you fixed them", so don't rewrite history to look clean.
- Success criteria are written once in the analysis and re-evaluated later.
  Know which criterion any given feature satisfies, and keep the list realistic.
- Work module by module (per screen): wireframe, user interaction, key
  variables/functions, pseudo code, validation, test table.

**Usability and maintenance are separately marked** — variable naming,
modularisation, comments, indentation, and honest limitations/future
development are all assessment points. Keep the code clean and the scope
realistic; overscoping is penalised under limitations.

## It is a Flutter app now

`flutter create .` has been run and the result is **staged but not committed** —
`git status` shows the whole migration as `A`/`M`/`D` against a still-pure-Dart
history. Don't re-run `flutter create`; check what already exists first.

Verified current state:

- `pubspec.yaml` is a Flutter package: `flutter` + `flutter_test` sdk deps,
  `flutter_lints: ^6.0.0`, `sdk: ^3.13.4`, and a `flutter:` section with
  `uses-material-design: true`. The `path` dep is gone.
- Platform dirs exist and are staged: `ios/`, `linux/`, `web/`. All generated
  boilerplate — don't mine them for design intent, and don't hand-edit them
  outside `flutter create` / `flutter build`.
- `android/`, `macos/` and `windows/` were **deliberately deleted** (staged as
  `D`, not yet committed). iOS is the intended deployment target, `linux/` is
  the only target that can actually be run here, `web/` was left because it
  costs nothing. Don't regenerate the deleted ones with a bare `flutter create .`
  — if a platform needs adding back, add that one platform on purpose.
- `bin/gym_tracker.dart`, `lib/gym_tracker.dart` and
  `test/gym_tracker_test.dart` are deleted. The `bin/` console entrypoint is
  gone for good.
- `lib/main.dart` is 16 lines: `main()` → `MainApp`, a `StatelessWidget`
  returning a `MaterialApp` with a centred "Hello World!". Still a placeholder,
  not app code.
- **There is no `test/` directory at all.** `flutter test` exits 1 with
  `Test directory "test" not found.`, and `dart test` fails outright because
  `package:test` is no longer a dev dependency. This is the first thing to fix —
  the write-up's test tables are unbacked without it.

`README.md` and `CHANGELOG.md` are still the stock `dart create` text describing
a `bin/` entrypoint. Update or delete them rather than leaving them misleading.

## Toolchain quirk

`dart` **and** `flutter` both resolve to the Flutter SDK bundle on PATH
(`/home/dani/develop/flutter/bin/`, Flutter 3.47.5 / Dart 3.13.4). There is no
standalone Dart SDK installed and no separate system Flutter to fall back on.
`pubspec.lock` now pins `dart: >=3.13.4 <4.0.0` and
`flutter: >=3.18.0-18.0.pre.54`.

**No Android SDK and no Chrome are installed** — `flutter doctor` fails both the
Android toolchain and the Chrome category. `flutter devices` reports exactly one
target: Linux desktop, under WSL2. That matters, because the write-up wants
working mobile screenshots; desktop-only means the mobile evidence has to come
from somewhere else. Don't claim a mobile screenshot you can't actually take.

### iOS cannot be built or run on this machine at all

Flutter's iOS toolchain requires **macOS + Xcode**, and there is no way around
it: no remote or emulated path exists, unlike Android. Verified here — no
`xcodebuild`, no `xcrun`, no CocoaPods `pod`, and `flutter doctor` doesn't even
print an Xcode category (it only appears on macOS hosts). WSL2 and `/mnt/c`
give access to Windows files, not to Apple's build tools.

Consequences:

- The `ios/` directory is a **source-of-truth artifact and the deployment
  target**, but it is unbuildable and unverifiable from this environment. Commit
  it; never hand-edit it beyond what `flutter create` / a real Mac produces.
- The write-up needs iOS-looking screenshots. They have to come from a real Mac
  (borrow one, use a college/shared lab machine, or a paid cloud Mac). Don't
  dress up a Linux desktop screenshot as a phone screenshot — the write-up
  explicitly asks for honesty about what was and wasn't achieved.
- Everything that *can* be verified without a Mac is: `flutter analyze`,
  `flutter test`, `dart format`, and a Linux desktop build. Widget tests are
  where most of the write-up's test-table evidence should come from, since they
  run anywhere.

## Commands

Verified working:

- `flutter pub get`
- `flutter analyze` — currently clean
- `dart format .` — nothing enforces formatting, so run it before finishing
- `flutter build linux` — builds clean (~1 min cold) to
  `build/linux/x64/release/bundle/gym_tracker`
- `flutter run -d linux` — the only runnable target today
- `flutter devices` / `flutter doctor` — re-check the above before assuming any
  target exists. `flutter doctor` lists no Xcode category here, which is the
  quickest confirmation that iOS is unavailable.

iOS commands exist but all require a Mac: `flutter build ios`,
`flutter build ipa`, `flutter run -d <ios-device>`, `pod install` (CocoaPods,
driven automatically by Flutter). None of them work on this host.

`flutter test` currently **fails** for want of a `test/` directory. Once tests
exist, filter one with
`flutter test test/<file>_test.dart --plain-name '<name>'`. `dart test` and
`dart run bin/gym_tracker.dart` no longer apply.

## Conventions

- `analysis_options.yaml` includes `package:flutter_lints/flutter.yaml` (not
  the old `package:lints/recommended.yaml`) and excludes the platform dirs from
  analysis (`build/**`, `ios/**`, `web/**`, `linux/**`), which is part of why
  `flutter analyze` passes over them. New files are expected to be `dart format`
  clean and lint-free. Keep the exclude list in step with the dirs that exist —
  it currently no longer mentions `android/**`/`macos/**`/`windows/**` because
  those are gone.
- `.gitignore` is the stock Flutter one plus a hand-added tail: `/project`,
  `*.PNG`, `*.odt`, `*.txt`. The `project/` brief and mockups are deliberately
  untracked, but the five `project/IMG_*.PNG` files and `project/todo.txt` were
  committed *before* that rule and are still tracked — `.gitignore` doesn't
  untrack anything. Note `*.txt` is broad: any new `.txt` anywhere in the repo
  is silently ignored.
- `pubspec.lock` is committed; `.dart_tool/`, `build/`, `.idea/` and `*.iml`
  are not.
- Commit history is still three `Initial commit` messages on `main`, and the
  whole Flutter migration is sitting staged and uncommitted. No message
  convention has been established yet. Given the brief treats git history as
  evidence, commit the migration before starting on features.

## `project/`

- `NEA Write-Up.odt` — the OCR department template and grading spec, described
  above. Its advice prose is game-flavoured boilerplate (shoot 'em ups, racing
  games, multi-channel sound as the "concurrent" example). Follow the
  *structure*; the example content does not apply to a gym app. The
  top-down-decomposition vs class/ER diagram advice splits on procedural vs
  OOP — Dart/Flutter is OOP, so class diagrams.
- Five iOS-style mobile UI mockups (`IMG_1981..1985.PNG`) — **reference only**.
  Not wired into the build, no code imports them, and they do not define
  behavior. Read the relevant PNG before building a screen.
- `todo.txt` — empty.

The whole dir is now gitignored (`/project`, plus `*.PNG` / `*.odt` / `*.txt`),
so none of this belongs in a commit — except that the five `IMG_*.PNG` and
`todo.txt` were already tracked and stayed that way.

**Never commit `NEA Write-Up.odt:Zone.Identifier`.** It is a Windows/OneDrive
download artifact (NTFS alternate data stream) holding internal SharePoint
URLs and a username. It is junk; safe to delete. The `*.odt` ignore rule now
covers it by luck, but watch for the same artifact on any file copied in from
Windows — e.g. an `AGENTS.md:Zone.Identifier` would be untracked and easy to
`git add .` by accident.
