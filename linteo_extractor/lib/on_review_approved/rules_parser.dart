const _unselectedTick = '- [ ]';
const _selectedTick = '- [x]';
final _deletedLinkMark = RegExp(r'\d+\.');
final _deletedLinkMarkWithSpacebar = RegExp(r'\d+\.\s');

class RulesParser {
  static List<String> getUnselectedRules(String input) => input
      .split('\n')
      .where(containsUnselectedRule)
      .map((rule) => rule.replaceFirst('$_unselectedTick ', '').trim())
      .toList();

  static List<String> getSelectedRules(String input) => input
      .split('\n')
      .where(containsUnselectedRule)
      .map((rule) => rule.replaceFirst('$_selectedTick ', '').trim())
      .toList();

  static List<String> getDeletedRules(String input) => input
      .split('\n')
      .where(containsDeletedRule)
      .map((rule) => rule.replaceFirst(_deletedLinkMarkWithSpacebar, '').trim())
      .toList();

  static bool containsDeletedRule(String input) => _deletedLinkMark.hasMatch(input);

  static bool containsUnselectedRule(String input) => input.contains(_unselectedTick);
}
