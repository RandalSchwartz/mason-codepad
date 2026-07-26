import 'dart:io';

import 'package:mason/mason.dart';
import 'package:uuid/uuid.dart';

void run(HookContext context) {
  final vars = context.vars;
  final dart = vars['dart'] as bool;

  var name = vars['name'] as String;
  if (name == 'UUID') {
    name = (dart ? 'd_' : 'f_') + const Uuid().v4();
    vars['name'] = name;
    print('name is $name');
  }

  final snakeName = name.snakeCase;
  vars['snake_name'] = snakeName;
  final target = Directory(snakeName);
  if (target.existsSync()) {
    throw Exception('Directory $snakeName already exists');
  }
  final dartSdk = Platform.version.split(' ').first;
  vars['dart_sdk'] = dartSdk;

  final editor = vars['editor'] as String?;
  if (editor == null || editor == 'code') {
    final envEditor = Platform.environment['CODEPAD_EDITOR'] ??
        Platform.environment['EDITOR'];
    if (envEditor != null && envEditor.isNotEmpty) {
      vars['editor'] = envEditor;
    }
  }
}
