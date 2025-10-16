# Plan: Migrate from Riverpod to Signals

This document outlines the steps to migrate the `codepad` Mason brick from using `riverpod` for state management to using `signals` and `signals_hooks`.

## 1. Update Dependencies

The first step is to update the `pubspec.yaml{{X}}` template to remove the `riverpod` dependencies and add the `signals` dependencies.

- **File to modify:** `codepad/__brick__/{{snake_name}}/pubspec.yaml{{X}}`
- **Action:**
  - Remove `riverpod`, `flutter_riverpod`, `hooks_riverpod`, `riverpod_annotation`, `riverpod_generator`, and `riverpod_lint`.
  - Add `signals` and `signals_hooks`.
  - Restore `fpdart`.
  - Use specific version constraints for all dependencies instead of `any`.

## 2. Update Template Code

Next, the template code in the `__brick__` directory needs to be updated to use `signals` instead of `riverpod`.

### Dart-Only Template

- **File to modify:** `codepad/__brick__/{{snake_name}}/bin/{{#dart}}{{snake_name}}.dart{{\dart}}`
- **Action:** Replace the existing code with a simple `signals` example.

### Flutter Template

- **File to modify:** `codepad/__brick__/{{snake_name}}/lib/{{^dart}}main.dart{{\dart}}`
- **Action:** Replace the existing `riverpod` code with a `signals` and `signals_hooks` example.

### Functional Programming Utilities

- **File to modify:** `codepad/__brick__/{{snake_name}}/lib/{{^dart}}functional.dart{{\dart}}`
- **Action:** Update the file with a simple `fpdart` example.

## 3. Fix the `post_gen` Hook

The `post_gen.dart` hook has a bug where it runs `flutter create .`, which overwrites the generated template files. This needs to be fixed to run `flutter pub get` instead.

- **File to modify:** `codepad/hooks/post_gen.dart`
- **Action:**
  - For Flutter projects, replace the `flutter create .` command with `flutter pub get`.
  - Remove the debugging `print` statements.

## 4. Testing

To test the changes, we need to use the local version of the brick, not the globally installed one.

- **Command:** `mason make codepad --path codepad -o output`
- **Action:**
  - Run the command from the root of the project.
  - This will generate a new project in the `output` directory using the local brick.
  - Inspect the generated files in the `output` directory to confirm the changes.
