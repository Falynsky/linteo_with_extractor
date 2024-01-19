import 'dart:io';

import 'package:linteo_extractor/action_runner.dart';
// import 'package:linteo_extractor/on_lints_changed/faker.dart';
import 'package:linteo_extractor/on_lints_changed/lints_manager.dart';

class OnLintsChangedRunner extends ActionRunner {
  OnLintsChangedRunner._({
    required super.workspace,
    required this.manager,
  });

  final LintsManager manager;

  static Future<OnLintsChangedRunner> create(String workspace) async {
    final manager = await LintsManager.create(workspace: workspace);

    return OnLintsChangedRunner._(
      manager: manager,
      workspace: workspace,
    );
  }

  @override
  void runAction() {
    final haveLintsChanged = manager.haveLintsChanged();
    if (haveLintsChanged) {
      _onLintsChanged();
    } /* else {
      // Only for testing purposes
       Faker.fake(manager, workspace, _createTmpFile);
    } */
  }

  void _onLintsChanged() {
    final lints = manager.getNewLints();
    manager.updateAllLintsFile();
    _createNewLintsTmpFile(lints);
    final deletedLints = manager.getDeletedLints();
    _createDeletedLintsTmpFile(deletedLints);
  }

  void _createNewLintsTmpFile(List<String> lints) {
    final file = File('$workspace/new_lints.tmp');
    final buffer = StringBuffer();
    for (final lint in lints) {
      buffer.writeln('- [x] $lint');
    }

    final text = buffer.toString();
    file.writeAsStringSync(text);
  }

  void _createDeletedLintsTmpFile(List<String> lints) {
    final file = File('$workspace/deleted_lints.tmp');
    final buffer = StringBuffer();
    for (final lint in lints) {
      buffer.writeln('- $lint');
    }

    final text = buffer.toString();
    file.writeAsStringSync(text);
  }
}
