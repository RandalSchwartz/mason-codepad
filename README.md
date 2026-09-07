# Mason Codepad

> [!NOTE]
> **Project Status: Sunsetted / Mothballed**
> Version 1.0.0 is the final published release of the `codepad` Mason brick. This project is now in maintenance/archive mode as its playground creation capabilities are being transitioned to an AI Agent Skill for enhanced flexibility and autonomous workflow integration.

> Like DartPad, but with a full IDE (Visual Studio Code, Cursor, or custom editor) and access to the entire pub.dev ecosystem.

`codepad` is a [Mason](https://pub.dev/packages/mason) brick created by [Randal Schwartz](https://github.com/RandalSchwartz) to quickly scaffold Dart and Flutter playgrounds for testing code snippets and prototyping ideas.

Check out the [demo video](https://youtu.be/Bq0WhHciqFY) to see it in action.

---

## 🚀 Prerequisites

1. **Dart / Flutter SDK** installed and available in your `PATH`.
2. **Mason CLI**: Install via Pub:
   ```sh
   dart pub global activate mason_cli
   ```
3. **Editor**: Visual Studio Code (`code`), Cursor, or another editor launcher in your `PATH`.

---

## 📦 Installation

### From Brickhub (Recommended)

Install `codepad` globally from [Brickhub](https://brickhub.dev):

```sh
mason add -g codepad
```

### From GitHub Source

To install directly from the GitHub repository:

```sh
mason add -g codepad --git-url https://github.com/RandalSchwartz/mason-codepad.git --git-path codepad
```

### Local Development / Repository Usage

If working within this repository, initialize the brick locally:

```sh
mason get
```

---

## 🛠️ Usage & Helper Scripts (`dplay` & `fplay`)

Add helper scripts to a directory in your `PATH` (e.g., `~/bin` or `/usr/local/bin`):

#### `dplay` (Dart Playground)
Create executable script named `dplay`:
```sh
#!/bin/sh
exec mason make codepad -o "${2:-/tmp}" --dart=true --name="${1:-UUID}" --editor="${3:-${CODEPAD_EDITOR:-code}}" </dev/null
```

#### `fplay` (Flutter Playground)
Create executable script named `fplay`:
```sh
#!/bin/sh
exec mason make codepad -o "${2:-/tmp}" --dart=false --name="${1:-UUID}" --editor="${3:-${CODEPAD_EDITOR:-code}}" </dev/null
```

#### Editor Environment Configuration
You can set `export CODEPAD_EDITOR=cursor` in your shell profile (`~/.zshrc` / `~/.bashrc`), and `dplay` and `fplay` will automatically default to opening your playgrounds in your preferred editor!

#### Examples
- `dplay` — Spawns a new Dart playground in `/tmp/<uuid>` using `$CODEPAD_EDITOR` or `code`.
- `fplay` — Spawns a new Flutter playground in `/tmp/<uuid>` using `$CODEPAD_EDITOR` or `code`.
- `dplay my_test` — Spawns a Dart playground named `my_test` in `/tmp/my_test`.
- `fplay my_widget ~/Projects cursor` — Spawns a Flutter playground in `~/Projects/my_widget` explicitly opened with `cursor`.

---

## 🗂️ Project Structure

```
.
├── mason.yaml             # Mason configuration linking the local brick
├── analysis_options.yaml  # Analyzer config excluding generated brick templates
├── pubspec.yaml           # Root test suite manifest
├── test/                  # Integration tests for brick generation
└── codepad/               # The Codepad Mason brick package
    ├── brick.yaml         # Brick manifest and variable definitions (v0.17.0)
    ├── README.md          # Brick-specific documentation
    ├── hooks/             # Pre-gen & post-gen lifecycle hooks (tested)
    │   ├── pre_gen.dart   # Auto-generates UUID names, checks CODEPAD_EDITOR, validates path
    │   └── post_gen.dart  # Runs pub get and launches configured editor
    └── __brick__/         # Template files for generated Dart/Flutter projects
```

---

## 📄 License

MIT
