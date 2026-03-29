# List Keep Project Rules

This repository contains the product app for List Keep.

Priority rules:

- keep the app offline-first and mobile-first
- prefer pragmatic clean architecture over ceremony
- keep routing centralized under `lib/app/router/`
- keep persistence in repositories, not widgets
- keep localization CSV-first with generated runtime JSON files
- prefer simple Riverpod providers that are easy to trace
- ship compile-friendly code before adding polish

Product guardrails:

- no auth
- no cloud sync
- no premium logic
- no backend assumptions
- built-in templates should help users start fast
