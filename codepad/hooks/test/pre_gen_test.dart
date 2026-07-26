import 'package:mason/mason.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../pre_gen.dart' as pre_gen;

class MockHookContext extends Mock implements HookContext {}

void main() {
  group('pre_gen hook tests', () {
    late HookContext context;
    late Map<String, dynamic> vars;

    setUp(() {
      context = MockHookContext();
      vars = <String, dynamic>{
        'dart': true,
        'name': 'UUID',
      };
      when(() => context.vars).thenReturn(vars);
    });

    test('generates UUID name and snake_name when "UUID" is passed for Dart', () {
      pre_gen.run(context);

      expect(vars['name'], isNot(equals('UUID')));
      expect(vars['name'], startsWith('d_'));
      expect(vars['snake_name'], isNotNull);
      expect(vars['dart_sdk'], isNotNull);
    });

    test('generates UUID name starting with f_ when "UUID" is passed for Flutter', () {
      vars['dart'] = false;

      pre_gen.run(context);

      expect(vars['name'], isNot(equals('UUID')));
      expect(vars['name'], startsWith('f_'));
      expect(vars['snake_name'], isNotNull);
      expect(vars['dart_sdk'], isNotNull);
    });

    test('preserves custom project name and sets snake_name', () {
      vars['name'] = 'MyCustomApp';

      pre_gen.run(context);

      expect(vars['name'], equals('MyCustomApp'));
      expect(vars['snake_name'], equals('my_custom_app'));
      expect(vars['dart_sdk'], isNotNull);
    });

    test('preserves custom editor if provided in vars', () {
      vars['name'] = 'MyCustomApp';
      vars['editor'] = 'cursor';

      pre_gen.run(context);

      expect(vars['editor'], equals('cursor'));
    });
  });
}
