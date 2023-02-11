# codepad: like dartpad, but with a full text editor and my favorite packages

Use this brick to quickly test code snippets,
similar to dartpad, but having a full text editor and access to the entire pub.dev ecosystem.
It also includes all my favorite starter packages for quick prototyping.

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

The first argument is the app name and name of the directory it will be created in.
If absent, a UUID will be used.

The second argument is the output directory, and defaults to /tmp.

Packages included:

- riverpod, flutter_riverpod
- flutter_hooks, riverpod_hooks
- riverpod_generator, riverpod_annotation, build_runner
- riverpod_lint
- fpdart
- very_good_analysis
