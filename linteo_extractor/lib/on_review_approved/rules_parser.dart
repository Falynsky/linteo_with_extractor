const _unselectedTick = '- [ ]';

class RulesParser {
  static List<String> getUnselectedRules(String input) => input
      .split('\n')
      .where(containsUnselectedRule)
      .map((rule) => rule.replaceFirst('$_unselectedTick ', '').trim())
      .toList();

  static bool containsUnselectedRule(String input) => input.contains(_unselectedTick);
}
