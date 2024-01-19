const _unselectedTick = '- [ ]';

class RulesParser {
  static List<String> getUnselectedRules(String input) {
    final items = input.split('\n');

    return items
        .where(containsUnselectedRule)
        .map((rule) => rule.replaceFirst('$_unselectedTick ', '').trim())
        .toList();
  }

  static bool containsUnselectedRule(String input) {
    return input.contains(_unselectedTick);
  }
}
