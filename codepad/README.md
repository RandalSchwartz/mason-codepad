# codepad: like dartpad, but with a full text editor and my favorite packages

Use this brick to quickly test code snippets,
similar to dartpad, but having a full text editor (Visual Studio Code) and access to the entire pub.dev ecosystem.
It also includes all my favorite starter packages for quick prototyping.

To use this brick, you need to have Visual Studio Code installed.
You also need to create a bin directory in your PATH, and add the following shell scripts to it.

Put this in your bin directory with the name `dplay` and make it executable.

```sh
#!/bin/sh
exec mason make codepad -o "${2:-/tmp}" --dart=true --name="${1:-UUID}" </dev/null
```

And put this as `fplay`:

```sh
#!/bin/sh
exec mason make codepad -o "${2:-/tmp}" --dart=false --name="${1:-UUID}" </dev/null
```

The first argument is the app name and name of the directory it will be created in within the output directory.
If absent, a UUID will be used.
This is great because you can just invoke "dplay" or "fplay" at a shell prompt and get a new app.

The second argument is the output directory, and defaults to /tmp.

The names are immaterial.  It's just what I happen to use.

Packages included:

- riverpod, flutter_riverpod
- flutter_hooks, riverpod_hooks
- riverpod_generator, riverpod_annotation, build_runner
- riverpod_lint (provides useful lints *and* refactorings)
- fpdart (unused by any sample code, but waiting at the ready)
- very_good_analysis
