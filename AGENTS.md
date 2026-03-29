# AGENTS.md

## Project Identity
This repository is a Flutter application project that uses the shared toolkit in:

`toolkit/codex-claude-mobile-toolkit/`

Project-specific rules override toolkit defaults when they conflict.

## Inheritance Order
When working in this repo, use rules in this order:
1. this file (`./AGENTS.md`)
2. relevant project prompt under `./prompts/`
3. toolkit `AGENTS.md`
4. relevant toolkit skill under `toolkit/codex-claude-mobile-toolkit/skills/`

## Default Stack
Use:
- Flutter
- Riverpod
- go_router
- Isar
- easy_localization
- CSV-first localization workflow
- Material 3

Do not replace these choices unless explicitly requested.

## Localization
Source of truth:
- `assets/i18n/translations.csv`

Generated runtime files:
- `assets/i18n/generated/*.json`

Workflow:
1. edit CSV
2. run generator
3. app uses generated locale files

## Architecture
Use pragmatic simple clean architecture.
Prefer readable modules over excessive abstraction.

## Agent Behavior
Before coding:
- read this file
- read the relevant prompt in `./prompts/`
- read toolkit `AGENTS.md`
- read the most relevant toolkit skill

Keep code compile-friendly and avoid over-engineering.

