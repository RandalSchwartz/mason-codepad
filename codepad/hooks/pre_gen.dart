import 'dart:io';

import 'package:mason/mason.dart';
import 'package:uuid/uuid.dart';

void run(HookContext context) {
  final vars = context.vars;
  final dart = vars['dart'] as bool;

  var name = vars['name'] as String;
  if (name == 'UUID') {
    name = (dart ? 'd_' : 'f_') + Uuid().v4();
    vars['name'] = name;
    print('name is $name');
  }

  var snakeName = name.snakeCase;
  vars['snake_name'] = snakeName;
  final target = Directory(snakeName);
  if (target.existsSync()) {
    throw Exception('Directory $snakeName already exists');
  }

  // print('vars are ${context.vars}');
}
