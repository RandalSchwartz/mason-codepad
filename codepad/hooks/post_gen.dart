import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final vars = context.vars;
  final snake_name = vars['snake_name'] as String;
  final dart = vars['dart'] as bool;

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
  await Process.run(
    'code',
    ['-n', '.'],
    workingDirectory: snake_name,
  );
  await Process.run(
    'code',
    [dart ? 'bin/$snake_name.dart' : 'lib/main.dart'],
    workingDirectory: snake_name,
  );
}