library RandomReturn;

import 'dart:math';

class RandomReturn {

  static Random _random = new Random();

  static dynamic getRandom(List items){
    int q = _random.nextInt(items.length-1);
    return items[q];
  }

}