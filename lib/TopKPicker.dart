library TopKPicker;

abstract class TopSelectable {
  num get primaryCriterionValue;
}

class TopKPicker {

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