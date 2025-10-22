# Codepad: like Dartpad, but with a full text editor and my favorite packages

Use this brick to quickly test code snippets, similar to Dartpad, but having a full text editor (Visual Studio Code) and access to the entire pub.dev ecosystem. It also includes all of my favorite starter packages for quick prototyping. Check out the [video](https://youtu.be/Bq0WhHciqFY) for a demo.

To use this brick, you need to have Visual Studio Code installed. You also need to create a bin directory in your PATH, and add the following shell scripts to it.

Put this in your bin directory with the name `dplay` and make it executable:

```sh
#!/bin/sh
exec mason make codepad -o "${2:-/tmp}" --dart=true --name="${1:-UUID}" </dev/null
```

And put this as `fplay`:

```sh
#!/bin/sh
exec mason make codepad -o "${2:-/tmp}" --dart=false --name="${1:-UUID}" </dev/null
```

The first argument is the app name and name of the directory it will be created in within the output directory. If absent, a UUID will be used. This is great because you can just invoke `dplay` or `fplay` at a shell prompt and get a new app.

The second argument is the output directory, and defaults to `/tmp`.

The names are immaterial.  It's just what I happen to use.

You can always use `mason make codepad` directly to be prompted for the arguments. However, unless you want it in a subdirectory of the current directory, you'll need to use the `-o` option manually. (I find it easier to just use the shell scripts.)

Packages included:

- signals (for reactive state management)
- very_good_analysis

These aren't selectable.  Just ignore or delete the ones you don't want, but it's a good starting point for quick experiments.

Note that a flutter repo is built with support *only* for the web. This is to speed up the time-to-first-edit. You can always use `flutter create .` to add support for other platforms later.