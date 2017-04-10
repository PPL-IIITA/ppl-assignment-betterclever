/// This module facilitates Random Selection from a List
library RandomReturn;

import 'dart:math';

/// Class to Randomly Return a value from a list of given values.
/// Class accepts list of any type.
class RandomReturn {

  /// Internal Math.Random object to get random integers
  static Random _random = new Random();

  /// Utility Method to get random item from a list of items
  static dynamic getRandom(List items){
    int q = _random.nextInt(items.length-1);
    return items[q];
  }

}