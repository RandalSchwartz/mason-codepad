# Agent Guide (`AGENTS.md`) — Mason Codepad

> [!NOTE]
> **Project Status: Sunsetted / Mothballed (v1.0.0 Final Release)**
> Version 1.0.0 is the final published release of the `codepad` Mason brick. This repository is in maintenance/archive mode as playground generation capabilities are being migrated to a dedicated AI Agent Skill.

## Architecture & Structure

This repository maintains the `codepad` [Mason](https://pub.dev/packages/mason) brick:
- `codepad/brick.yaml`: Brick specification, metadata, and variables (`name`, `dart`, `editor`).
- `codepad/hooks/`: Lifecycle hooks (`pre_gen.dart` for name/editor normalization, `post_gen.dart` for `pub get` and editor launching).
- `codepad/__brick__/`: The template files rendered by Mason. Notice file-level mustache conditionals such as `{{#dart}}{{snake_name}}.dart{{\dart}}` and `{{^dart}}main.dart{{\dart}}`.
- `test/generation_test.dart`: Root end-to-end integration test harness that generates both Dart and Flutter playgrounds, executes `pub get`, and verifies static analysis with `--fatal-infos`.

## Core Invariants & Failure Vaccines

### 1. Conditional Mustache Dependency Sorting (`sort_pub_dependencies`)
In `codepad/__brick__/{{snake_name}}/pubspec.yaml{{X}}`, dependencies must remain strictly alphabetical in **both** generated permutations:
- **Dart CLI**: `mocktail` $\rightarrow$ `test` $\rightarrow$ `very_good_analysis`
- **Flutter**: `flutter_test` $\rightarrow$ `mocktail` $\rightarrow$ `very_good_analysis`
Never insert common dependencies before conditionally bracketed dependencies without verifying the resulting alphabetical sort order for every target branch.

### 2. Fatal Diagnostics on Generation Verification
Always run `dart analyze --fatal-infos` and `flutter analyze --fatal-infos` in integration test verification to prevent informational lints from silently slipping past CI.

### 3. CI Gated Publishing
`.github/workflows/publish_to_brickyard.yaml` must always execute `dart test` (at root) and `dart test` in `codepad/hooks` before `mason publish` is invoked.

## Verification Commands

```sh
# Root integration test (generates Dart & Flutter playgrounds and analyzes them)
dart test

# Hook unit tests
cd codepad/hooks && dart test

# Repository static analysis and formatting
dart analyze .
dart format --output=none --set-exit-if-changed .
```
