library BoySearch;

import 'package:ValentinesDay/model/Boy.dart';
import 'dart:collection';

abstract class BoySearch {

  List<Boy> allBoys;

  BoySearch(this.allBoys);

  void searchForBoy(String name);
}

class LinearBoySearch extends BoySearch {

  LinearBoySearch(List<Boy> allBoys) : super(allBoys);

  @override
  void searchForBoy(String name) {
    // Linear Search
    bool found = false;
    for (Boy b in allBoys) {
      if (b.name == name) {
        found = true;
        print("Boy with name " + name + " Found");
        if (b.isCommitted) {
          print(name + " is committed to " + b.girlfriend.name);
        }
        else
          print(name + " is still single");
        break;
      }
    }
    if (!found) {
      print("Boy not found");
    }
  }
}

class BinaryBoySearch extends BoySearch {

  BinaryBoySearch(List<Boy> allBoys) : super(allBoys);

  @override
  void searchForBoy(String name) {
    allBoys.sort((a, b) => a.name.compareTo(b.name));
    bool result = _binarySearch(name, 0, allBoys.length - 1);
    if (!result) {
      print("Boy not found");
    }
  }

  bool _binarySearch(String name, int start, int end) {
    if (end < start) {
      return false;
    }
    if (start < 0 || end < 0) {
      return false;
    }
    if (start > allBoys.length - 1 || end > allBoys.length - 1) {
      return false;
    }
    int mid = (start + end) ~/ 2;
    if (allBoys[mid].name == name) {
      Boy b = allBoys[mid];
      print("Boy with name " + name + " Found");
      if (b.isCommitted) {
        print(name + " is committed to " + b.girlfriend.name);
      }
      else
        print(name + " is still single");
      return true;
    }
    else {
      if (allBoys[mid].name.compareTo(name) > 0) {
        return _binarySearch(name, start, mid - 1);
      }
      else {
        return _binarySearch(name, mid + 1, end);
      }
    }
  }

}

class HashBoySearch extends BoySearch {

  HashMap<String, Boy> _map;

  HashBoySearch(List<Boy> allBoys) : super(allBoys) {
    _map = new HashMap.fromIterable(allBoys,
        key: (item) => item.name,
        value: (item) => item);
  }

  @override
  void searchForBoy(String name) {
    if (_map.containsKey(name)) {
      Boy b = _map[name];
      print("Boy with name " + name + " Found");
      if (b.isCommitted) {
        print(name + " is committed to " + b.girlfriend.name);
      }
      else
        print(name + " is still single");
      return;
    }
    else {
      print("Boy not found");
    }
  }
}