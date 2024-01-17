import 'package:linteo_extractor/on_lints_changed/lints_manager.dart';

class Faker {
  static void fake(
    LintsManager manager,
    String workspace,
    void Function(List<String>) createTmpFile,
  ) {
    final fakeRules = [
      'fake_rule_1',
      'fake_rule_2',
      'fake_rule_3',
    ].map((e) => '${e}_${DateTime.now().microsecondsSinceEpoch}').toList();

    manager.updateAllLintsFileWithFakes(fakeRules);
    createTmpFile(fakeRules);
  }
}
