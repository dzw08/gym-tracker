# AGENTS.md

Single-package Dart repo, `main` only, remote `github.com/dzw08/gym-tracker`. No
workspace, no path deps, no CI, no pre-commit hooks, no codegen.

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

## Intended product: Flutter mobile app

The target is a **Flutter mobile app**, but the repo is still a stock
`dart create` console scaffold. Verified current state:

- `pubspec.yaml` has `dependencies: path` only — **no `flutter` dep**, no
  `flutter:` section. Same for `pubspec.lock`.
- No `android/`, `ios/`, `web/`, or any Flutter platform dir exists.
- Only real code is `lib/gym_tracker.dart` (`calculate() -> 42`),
  `bin/gym_tracker.dart` (console entrypoint), and
  `test/gym_tracker_test.dart` (placeholder assertion).

Don't assume any of the migration has happened. Converting to Flutter means
`flutter create .` for the platform dirs, moving code into `lib/`, dropping the
`bin/` console entrypoint, and switching to `flutter test` / `flutter analyze`.

## Toolchain quirk

`dart` **and** `flutter` both resolve to the Flutter SDK bundle on PATH
(`/home/dani/develop/flutter/bin/`, Flutter 3.47.5 / Dart 3.13.4). There is no
standalone Dart SDK installed. `pubspec.yaml` requires `sdk: ^3.12.2`; the
bundled Dart 3.13.4 satisfies it. A Flutter SDK being present does **not** make
this a Flutter package — check `pubspec.yaml`, not PATH.

## Commands

Verified working as of the scaffold state:

- `dart pub get`
- `dart run bin/gym_tracker.dart`
- `dart test` — run a single test with `dart test test/gym_tracker_test.dart -n '<name>'`
- `dart analyze`
- `dart format .` — nothing enforces formatting, so run it before finishing

Once the package is actually Flutter, use `flutter test` / `flutter analyze` /
`flutter run` instead; `dart test` will not see widget tests.

## Conventions

- `analysis_options.yaml` includes `package:lints/recommended.yaml`; every
  additional rule is commented out. New files are expected to be `dart format`
  clean and lint-free.
- `pubspec.lock` is committed. Only `.dart_tool/` is gitignored.
- Commit history is three `Initial commit` messages on `main`; no message
  convention has been established yet.

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

**Never commit `NEA Write-Up.odt:Zone.Identifier`.** It is a Windows/OneDrive
download artifact (NTFS alternate data stream) holding internal SharePoint
URLs and a username. It is junk; safe to delete. Watch for the same artifact
reappearing on any file copied in from Windows.
