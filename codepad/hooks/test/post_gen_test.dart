import 'dart:io';

import 'package:mason/mason.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../post_gen.dart' as post_gen;

class MockHookContext extends Mock implements HookContext {}

void main() {
  group('post_gen hook tests', () {
    late HookContext context;
    late Map<String, dynamic> vars;
    late Directory tempDir;

    setUp(() {
      tempDir = Directory.systemTemp.createTempSync('post_gen_test_');
      context = MockHookContext();
      vars = <String, dynamic>{
        'snake_name': tempDir.path,
        'dart': true,
        'editor': '', // Empty string skips launching editor processes during unit tests
      };
      when(() => context.vars).thenReturn(vars);
    });

    tearDown(() {
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
    });

    test('accepts editor variable and executes pub get gracefully when editor is empty', () async {
      await expectLater(post_gen.run(context), completes);
    });
  });
}
