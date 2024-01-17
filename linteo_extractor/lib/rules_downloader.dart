import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:linteo_extractor/version_helper.dart';

class RulesDownloader {
  const RulesDownloader(this.workspace);

  final String workspace;

  Future<String> downloadRulesFromDartLang() async {
    const url = 'https://dart-lang.github.io/linter/lints/options/options.html';
    return await _download(url);
  }

  String readAllLintRulesFromLinteo() {
    final file = File('$workspace/lib/all_lint_rules.yaml');
    final rules = file.readAsStringSync();

    return rules.trim();
  }

  String readLatestVersionedFile(String version) {
    final helper = VersionHelper(workspace);
    final version = helper.getAnalysisOptionsVersion();

    final path = '$workspace/lib/analysis_options.$version.yaml';
    final file = File(path);
    final result = file.readAsStringSync();

    return result.trim();
  }

  String readAnalysisOptions() {
    final file = File('$workspace/lib/analysis_options.yaml');
    final result = file.readAsStringSync();

    return result.trim();
  }

  Future<String> _download(String url) async {
    final uri = Uri.parse(url);
    final result = await http.get(uri);

    return result.body;
  }
}
