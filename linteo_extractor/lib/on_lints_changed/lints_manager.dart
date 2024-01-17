import 'dart:io';

import 'package:linteo_extractor/on_lints_changed/html_extractor.dart';
import 'package:linteo_extractor/on_lints_changed/yaml_extractor.dart';
import 'package:linteo_extractor/rules_downloader.dart';

class LintsManager {
  LintsManager._(
    this._htmlExtractor,
    this._yamlExtractor,
    this._workspace,
  );

  final HtmlExtractor _htmlExtractor;
  final YamlExtractor _yamlExtractor;
  final String _workspace;

  List<String> get savedLints => _yamlExtractor.lints;
  List<String> get fetchedLints => _htmlExtractor.lints;

  static Future<LintsManager> create({
    required String workspace,
    RulesDownloader? downloader,
  }) async {
    downloader ??= RulesDownloader(workspace);

    final htmlInput = await downloader.downloadRulesFromDartLang();
    final yamlInput = downloader.readAllLintRulesFromLinteo();

    final htmlExtractor = HtmlExtractor(htmlInput);
    final yamlExtractor = YamlExtractor(yamlInput);

    return LintsManager._(htmlExtractor, yamlExtractor, workspace);
  }

  List<String> getNewLints() {
    try {
      final lints = List<String>.from(fetchedLints);
      lints.removeWhere((lint) => savedLints.contains(lint));

      return lints;
    } catch (e) {
      return [];
    }
  }

  bool haveLintsChanged() {
    final htmlHash = _htmlExtractor.getLintsHash();
    final yamlHash = _yamlExtractor.getLintsHash();

    return htmlHash != yamlHash;
  }

  void updateAllLintsFile() {
    final file = File('$_workspace/lib/all_lint_rules.yaml');
    final newLints = _htmlExtractor.getRawBody();

    file.writeAsStringSync(newLints);
  }

  void updateAllLintsFileWithFakes(List<String> fakeLints) {
    final file = File('$_workspace/lib/all_lint_rules.yaml');

    var newLints = _htmlExtractor.getRawBody();
    for (final fakeLint in fakeLints) {
      // ignore: use_string_buffers
      newLints += '    - $fakeLint\n';
    }

    file.writeAsStringSync(newLints);
  }
}
