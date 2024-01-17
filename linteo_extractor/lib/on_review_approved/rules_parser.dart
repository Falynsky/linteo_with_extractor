const _selectedTick = '- [x]';

class RulesParser {
  static List<String> getSelectedRules(String input) {
    final items = input.split('\n');

    return items
        .where(containsSelectedRule)
        .map((rule) => rule.replaceFirst('$_selectedTick ', '').trim())
        .toList();
  }

  static bool containsSelectedRule(String input) {
    return input.contains(_selectedTick);
  }
}
