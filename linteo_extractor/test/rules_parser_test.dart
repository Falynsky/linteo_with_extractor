import 'package:linteo_extractor/on_review_approved/rules_parser.dart';
import 'package:test/test.dart';

void main() {
  test('Should return list of selected rules (2nd rule)', () {
    const input = '- [ ] fake_rule_1\n- [x] fake_rule_2\n- [ ] fake_rule_3';
    const expected = ['fake_rule_2'];
    final result = RulesParser.getSelectedRules(input);

    expect(result, expected);
  });

  test('Should return list of selected rules (1st, 3rd rules)', () {
    const input = '- [x] fake_rule_1\n- [ ] fake_rule_2\n- [x] fake_rule_3';
    const expected = ['fake_rule_1', 'fake_rule_3'];
    final result = RulesParser.getSelectedRules(input);

    expect(result, expected);
  });

  test('Should return list of selected rules (1st)', () {
    const input = '- [x] rule_1\n- [ ] rule_2';
    const expected = ['rule_1'];
    final result = RulesParser.getSelectedRules(input);

    expect(result, expected);
  });

  test('Should return empty list', () {
    const input = '- [ ] fake_rule_1\n- [ ] fake_rule_2\n- [ ] fake_rule_3';
    final result = RulesParser.getSelectedRules(input);

    expect(result, <String>[]);
  });
}
