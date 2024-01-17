import 'package:linteo_extractor/on_lints_changed/html_extractor.dart';
import 'package:linteo_extractor/on_lints_changed/rules_extractor.dart';
import 'package:linteo_extractor/on_lints_changed/yaml_extractor.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import 'fixtures/fixture_reader.dart';

void main() {
  late String input;
  late RulesExtractor extractor;

  group('HTML extractor tests', () {
    setUpAll(() {
      input = fixture('options_response.html');
      extractor = HtmlExtractor(input);
    });

    test('Should return correct lints count', () {
      final result = extractor.lintsCount;
      expect(result, 214);
    });

    test('Should return correct lints md5', () {
      final result = extractor.getLintsHash();
      expect(result, '41e4a210a40d5aa3f8364cf33b19ef67');
    });
  });

  group('YAML extractor tests', () {
    setUpAll(() {
      input = fixture('linteo_response.yaml');
      extractor = YamlExtractor(input);
    });

    test('Should return correct lints count', () {
      final result = extractor.lintsCount;
      expect(result, 214);
    });

    test('Should return correct lints md5', () {
      final result = extractor.getLintsHash();
      expect(result, '41e4a210a40d5aa3f8364cf33b19ef67');
    });
  });

  group('HTML & YAML integration tests', () {
    test('HTML & YAML md5 hashes should be equal', () {
      final html = fixture('options_response.html');
      final yaml = fixture('linteo_response.yaml');

      final htmlExtractor = HtmlExtractor(html);
      final yamlExtractor = YamlExtractor(yaml);

      final htmlHash = htmlExtractor.getLintsHash();
      final yamlHash = yamlExtractor.getLintsHash();

      expect(htmlHash, yamlHash);
    });
  });
}
