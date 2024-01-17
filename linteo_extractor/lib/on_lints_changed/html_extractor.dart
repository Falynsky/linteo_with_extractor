import 'package:linteo_extractor/on_lints_changed/rules_extractor.dart';

class HtmlExtractor extends RulesExtractor {
  HtmlExtractor(super.input);

  @override
  String getBody() {
    return getRawBody()
        .replaceAll('linter:', '')
        .replaceAll('rules:', '')
        .trim();
  }

  String getRawBody() {
    const startCodeTag = '<code>';
    const endCodeTag = '</code>';

    print(input);
    final startIndex = input.indexOf(startCodeTag) + startCodeTag.length;
    final endIndex = input.indexOf(endCodeTag);

    return input.substring(startIndex, endIndex);
  }
}
