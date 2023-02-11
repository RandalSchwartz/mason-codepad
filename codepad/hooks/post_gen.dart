import 'dart:io';

import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final vars = context.vars;
  final snake_name = vars['snake_name'] as String;
  final dart = vars['dart'] as bool;

  if (dart) {
    final result = await Process.runSync('dart', ['pub', 'get'],
        workingDirectory: snake_name);
    print('stdout is ${result.stdout}');
    print('stderr is ${result.stderr}');
  } else {
    final result = await Process.runSync('flutter', ['create', '.'],
        workingDirectory: snake_name);
    print('stdout is ${result.stdout}');
    print('stderr is ${result.stderr}');
  }
  await Process.runSync(
    'code',
    ['-n', '.'],
    workingDirectory: snake_name,
  );
  await Process.runSync(
    'code',
    [dart ? 'bin/$snake_name.dart' : 'lib/main.dart'],
    workingDirectory: snake_name,
  );
}
