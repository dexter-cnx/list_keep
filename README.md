# List Keep

List Keep is an offline-first Flutter app for smart lists and personal records.
It aims to be simpler than Airtable or Notion, but more structured than plain notes.

## Stack

- Flutter
- Riverpod
- go_router
- Isar
- easy_localization
- Material 3
- CSV-first localization

## Project Setup

This repository expects the toolkit to be available as a git submodule at:

- `toolkit/codex-claude-mobile-toolkit`

If the submodule has not been added yet, run:

```bash
git submodule add https://github.com/dexter-cnx/codex-claude-mobile-toolkit.git toolkit/codex-claude-mobile-toolkit
```

Then initialize and fetch submodule contents:

```bash
git submodule update --init --recursive
```

## Run The App

```bash
flutter pub get
dart run scripts/generate_i18n.dart
dart run build_runner build --delete-conflicting-outputs
flutter run
```

## Localization Workflow

List Keep uses one CSV file as the translation source of truth:

- `assets/i18n/translations.csv`

Generate runtime locale files with:

```bash
dart run scripts/generate_i18n.dart
```

Generated files are written to:

- `assets/i18n/generated/en.json`
- `assets/i18n/generated/th.json`

## Verification

```bash
flutter analyze
flutter test
```

## Android Build Note

If Android build fails with a `Namespace not specified` error from
`isar_flutter_libs`, this project already includes a Gradle-side workaround in
`android/build.gradle.kts`.

The workaround:

- detects Android subprojects that do not define `namespace`
- reads the package name from `src/main/AndroidManifest.xml`
- applies that value as the fallback namespace

This avoids editing files inside `.pub-cache` directly and keeps the fix inside
the app repository.

## Current MVP Scope

- Home
- Create List
- Template Picker
- List Detail
- Manage Fields
- Create/Edit Record
- Search
- Settings

Built-in templates:

- Expense Tracker
- Inventory
- Checklist
- Collection Tracker
- Warranty Tracker
- Maintenance Log
