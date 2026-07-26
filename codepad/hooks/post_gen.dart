import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final vars = context.vars;
  final snake_name = vars['snake_name'] as String;
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
      workingDirectory: snake_name,
    );
  } else {
    await Process.run(
      'flutter',
      ['pub', 'get'],
      workingDirectory: snake_name,
    );
  }
  if (editor.isNotEmpty) {
    await Process.run(
      editor,
      ['-n', '.'],
      workingDirectory: snake_name,
    );
    await Process.run(
      editor,
      [dart ? 'bin/$snake_name.dart' : 'lib/main.dart'],
      workingDirectory: snake_name,
    );
  }
}