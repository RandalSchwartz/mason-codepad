import 'dart:io';

import 'package:mason/mason.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  group('Codepad Brick Generation Integration Tests', () {
    late Directory tempDir;

    setUp(() {
      tempDir = Directory.systemTemp.createTempSync('codepad_gen_test_');
    });

    tearDown(() {
      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true);
      }
    });

    test('generates Dart playground successfully', () async {
      final brick = Brick.path(p.join(Directory.current.path, 'codepad'));
      final generator = await MasonGenerator.fromBrick(brick);

      final target = DirectoryGeneratorTarget(tempDir);
      final vars = <String, dynamic>{
        'name': 'test_dart_app',
        'snake_name': 'test_dart_app',
        'dart': true,
        'dart_sdk': '3.0.0',
        'editor': '',
      };

      final files = await generator.generate(target, vars: vars);
      expect(files, isNotEmpty);

      final generatedDir = Directory(p.join(tempDir.path, 'test_dart_app'));
      expect(generatedDir.existsSync(), isTrue);
      expect(File(p.join(generatedDir.path, 'pubspec.yaml')).existsSync(), isTrue);
      expect(File(p.join(generatedDir.path, 'bin', 'test_dart_app.dart')).existsSync(), isTrue);
      expect(File(p.join(generatedDir.path, 'analysis_options.yaml')).existsSync(), isTrue);
      expect(File(p.join(generatedDir.path, 'build.yaml')).existsSync(), isFalse);
    });

    test('generates Flutter playground successfully', () async {
      final brick = Brick.path(p.join(Directory.current.path, 'codepad'));
      final generator = await MasonGenerator.fromBrick(brick);

      final target = DirectoryGeneratorTarget(tempDir);
      final vars = <String, dynamic>{
        'name': 'test_flutter_app',
        'snake_name': 'test_flutter_app',
        'dart': false,
        'dart_sdk': '3.0.0',
        'editor': '',
      };

      final files = await generator.generate(target, vars: vars);
      expect(files, isNotEmpty);

      final generatedDir = Directory(p.join(tempDir.path, 'test_flutter_app'));
      expect(generatedDir.existsSync(), isTrue);
      expect(File(p.join(generatedDir.path, 'pubspec.yaml')).existsSync(), isTrue);
      expect(File(p.join(generatedDir.path, 'lib', 'main.dart')).existsSync(), isTrue);
      expect(File(p.join(generatedDir.path, 'analysis_options.yaml')).existsSync(), isTrue);
      expect(File(p.join(generatedDir.path, 'build.yaml')).existsSync(), isFalse);
    });
  });
}
