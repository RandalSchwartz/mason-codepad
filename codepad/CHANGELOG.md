# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-09-07

- Add `mocktail` to template `dev_dependencies` (#10)
- Add verification test step in GitHub Actions publish workflow
- **Deprecation**: Mark brick as final release / mothballed in favor of AI Agent Skill

## [0.17.2] - 2026-07-26

- Fix `super(initialState: 0)` constructor invocation in `CubitSignal` starter templates
- Fix `signals_hooks` package name in template dependencies
- Alphabetize template dependencies and dev_dependencies for clean static analysis

## [0.17.1] - 2026-07-26

- Correct package dependency to `signals_hooks`
- Ensure Dart template uses `CubitSignal` starter code

## [0.17.0] - 2026-07-26

- Upgrade hooks SDK constraint to >=3.0.0 <4.0.0
- Add configurable editor variable with $CODEPAD_EDITOR and $EDITOR support
- Update dependencies to signals, bloc_signals, signals_flutter, bloc_signals_flutter, hook_signals, flutter_hooks
- Add CubitSignal Dart CLI and Flutter Counter starter apps
- Remove stale custom_lint plugin from analysis_options template
- Remove obsolete build.yaml template
- Add unit tests for hooks and root integration test suite
- Add root README.md and root .gitignore

## [0.16.1] - 2025-11-08

- [task] add signals_flutter dependency
- [task] remove build_runner and custom_lint
- [docs] update README.md

## [0.15.1] - 2025-10-21

- [docs] update README.md
- [task] remove flutter_hooks

## [0.15.0] - 2025-10-21

- [task] migrate from riverpod to signals
- [task] remove flex_color_scheme
- [task] remove fpdart

## [0.14.0] - 2024-12-08

- [task] update to latest mason

## [0.13.0] - 2024-11-07

- [task] clean up brickyard publishing automation

## [0.12.0] - 20204-08-27

- Remember to update the Changelog!

## [0.11.0] - 2024-08-27

- update mason version for flutter 3.24

## [0.9.0] - 2024-02-17

- Add executable path for `dart pub activate --source path .` for dart projects

## [0.8.0] - 2023-10-29

- Add package:flex_color_scheme

## [0.7.0] - 2023-07-07

- Add stricter analysis options.

## [0.6.0] - 2023-04-17

- Determine dartSdk in pre_gen to use in pubspec.yaml to determine dart version.

## [0.5.0] - 2023-04-04

- Default to non-riverpod template, but leave hints in comments.

## [0.4.7] - 2023-02-26

- add "any" to pubspec version numbers
- add link to video about this brick

## [0.4.6] - 2023-02-23

- Restructure how mustache is used to generate files conditionally.

## [0.4.5] - 2023-02-19

- add `functional.dart` to flutter template, enabling coexistence between riverpod and fpdart.

## [0.4.4] - 2023-02-19

- Select only web for flutter, as this is typically the only target for noodling around.

## [0.4.3] - 2023-02-16

- Add better ProviderContainer to flutter template.
- Update documentation.

## [0.4.2] - 2023-02-16

- Add spinner to flutter template.

## [0.4.1] - 2023-02-16

- Added ProviderContainer to flutter template.

## [0.4.0] - 2023-02-15

- Initial release.