/// This module facilitates top k selection from feasible items
library TopKPicker;

/// Interface for getting primaryCriterionValue for selection while performing
/// Top K selection using TopKPicker
abstract class TopSelectable {

  /// Getter to getter primary criterion value
  num get primaryCriterionValue;

}

/// Utility class to get Top K Items in a List of any type that implements
/// TopSelectable
class TopKPicker {

  /// Method to return top k items in a list after selection according to
  /// primaryCriterionValue
  static List<TopSelectable> getTopK(List<TopSelectable> list, int k) {
    list.sort((a, b) =>
        a.primaryCriterionValue.compareTo(b.primaryCriterionValue));
    List<TopSelectable> newList = new List();
    while (k-- > 0) {
      newList.add(list[k]);
    }
    return newList;
  }

}