import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final vars = context.vars;
  final snakeName = vars['snake_name'] as String;
  final dart = vars['dart'] as bool;
  var editor = vars['editor'] as String?;
  if (editor == null || editor.isEmpty || editor == 'code') {
    final envEditor = Platform.environment['CODEPAD_EDITOR'] ??
        Platform.environment['EDITOR'];
    if (envEditor != null && envEditor.isNotEmpty) {
      editor = envEditor;
    } else {
      editor = editor ?? 'code';
    }
  }

  if (dart) {
    await Process.run(
      'dart',
      ['pub', 'get'],
      workingDirectory: snakeName,
    );
  } else {
    await Process.run(
      'flutter',
      ['pub', 'get'],
      workingDirectory: snakeName,
    );
  }
  if (editor.isNotEmpty) {
    await Process.run(
      editor,
      ['-n', '.'],
      workingDirectory: snakeName,
    );
    await Process.run(
      editor,
      [if (dart) 'bin/$snakeName.dart' else 'lib/main.dart'],
      workingDirectory: snakeName,
    );
  }
}
