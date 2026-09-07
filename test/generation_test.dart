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

    test('generates and analyzes Dart playground successfully', () async {
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
      final pubspecFile = File(p.join(generatedDir.path, 'pubspec.yaml'));
      expect(
        pubspecFile.existsSync(),
        isTrue,
      );
      expect(
        pubspecFile.readAsStringSync(),
        contains('mocktail: any'),
      );
      expect(
        File(
          p.join(generatedDir.path, 'bin', 'test_dart_app.dart'),
        ).existsSync(),
        isTrue,
      );
      expect(
        File(p.join(generatedDir.path, 'analysis_options.yaml')).existsSync(),
        isTrue,
      );
      expect(
        File(p.join(generatedDir.path, 'build.yaml')).existsSync(),
        isFalse,
      );

      final pubGetRes = await Process.run(
        'dart',
        ['pub', 'get'],
        workingDirectory: generatedDir.path,
      );
      expect(
        pubGetRes.exitCode,
        equals(0),
        reason: 'dart pub get failed: ${pubGetRes.stderr}',
      );

      final analyzeRes = await Process.run(
        'dart',
        ['analyze', '--fatal-infos'],
        workingDirectory: generatedDir.path,
      );
      expect(
        analyzeRes.exitCode,
        equals(0),
        reason: 'dart analyze failed:\n${analyzeRes.stdout}',
      );
    });

    test('generates and analyzes Flutter playground successfully', () async {
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
      final pubspecFile = File(p.join(generatedDir.path, 'pubspec.yaml'));
      expect(
        pubspecFile.existsSync(),
        isTrue,
      );
      expect(
        pubspecFile.readAsStringSync(),
        contains('mocktail: any'),
      );
      expect(
        File(p.join(generatedDir.path, 'lib', 'main.dart')).existsSync(),
        isTrue,
      );
      expect(
        File(p.join(generatedDir.path, 'analysis_options.yaml')).existsSync(),
        isTrue,
      );
      expect(
        File(p.join(generatedDir.path, 'build.yaml')).existsSync(),
        isFalse,
      );

      final pubGetRes = await Process.run(
        'flutter',
        ['pub', 'get'],
        workingDirectory: generatedDir.path,
      );
      expect(
        pubGetRes.exitCode,
        equals(0),
        reason: 'flutter pub get failed: ${pubGetRes.stderr}',
      );

      final analyzeRes = await Process.run(
        'flutter',
        ['analyze', '--fatal-infos'],
        workingDirectory: generatedDir.path,
      );
      expect(
        analyzeRes.exitCode,
        equals(0),
        reason: 'flutter analyze failed:\n${analyzeRes.stdout}',
      );
    });
  });
}
