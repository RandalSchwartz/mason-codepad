# Codepad: like Dartpad, but with a full text editor and my favorite packages

> [!NOTE]
> **Project Status: Sunsetted / Mothballed**
> Version 1.0.0 is the final published release of the `codepad` Mason brick. This project is now in maintenance/archive mode as its playground creation capabilities are being transitioned to an AI Agent Skill for enhanced flexibility and autonomous workflow integration.

Use this brick to quickly test code snippets, similar to Dartpad, but having a full text editor (Visual Studio Code, Cursor, or custom editor) and access to the entire pub.dev ecosystem. It also includes all of my favorite starter packages for quick prototyping. Check out the [video](https://youtu.be/Bq0WhHciqFY) for a demo.

## 📦 Installation

Install globally from [Brickhub](https://brickhub.dev):

```sh
mason add -g codepad
```

Or install directly from GitHub source:

```sh
mason add -g codepad --git-url https://github.com/RandalSchwartz/mason-codepad.git --git-path codepad
```

---

## 🛠️ Usage

To use this brick, you need to have Visual Studio Code (or your preferred editor command) installed. You also need to create a bin directory in your PATH, and add the following shell scripts to it.

Put this in your bin directory with the name `dplay` and make it executable:

```sh
#!/bin/sh
exec mason make codepad -o "${2:-/tmp}" --dart=true --name="${1:-UUID}" --editor="${3:-${CODEPAD_EDITOR:-code}}" </dev/null
```

And put this as `fplay`:

```sh
#!/bin/sh
exec mason make codepad -o "${2:-/tmp}" --dart=false --name="${1:-UUID}" --editor="${3:-${CODEPAD_EDITOR:-code}}" </dev/null
```

The first argument is the app name and name of the directory it will be created in within the output directory. If absent, a UUID will be used. This is great because you can just invoke `dplay` or `fplay` at a shell prompt and get a new app.

The second argument is the output directory, and defaults to `/tmp`.

The third argument is the editor launch command, defaulting to `$CODEPAD_EDITOR`, `$EDITOR`, or `code`.

You can set `export CODEPAD_EDITOR=cursor` in your shell environment to automatically open all playgrounds in Cursor (or any preferred editor).

You can always use `mason make codepad` directly to be prompted for the arguments.

Packages included:

- `signals` / `signals_flutter` (for reactive primitives & state management)
- `bloc_signals` / `bloc_signals_flutter` (for Bloc/Cubit reactive state management)
- `hook_signals` / `flutter_hooks` (for reactive hooks integration)
- `very_good_analysis`

Note that a flutter repo is built with support *only* for the web. This is to speed up the time-to-first-edit. You can always use `flutter create .` to add support for other platforms later.