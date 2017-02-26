///This library contains Class for Couple and wrapper for ListOfCouples
library Couple;
/*
* Created by betterclever
* */

import 'package:ValentinesDay/model/Boy.dart';
import 'package:ValentinesDay/model/Gift.dart';
import 'package:ValentinesDay/model/Girl.dart';

/// Internal Class to Represent a couple
class _Couple {
  Boy boy;
  Girl girl;

  _Couple(this.boy, this.girl);

  /// dart style Getter to get happiness of a Couple
  double get happiness {
    return boy.happiness + girl.happiness;
  }

  /// dart style Getter to get compatibility of a Couple
  double get compatibility {
    double compatibility = boy.budget - girl.maintenanceBudget;
    compatibility += (boy.attractiveness - girl.attractiveness).abs() * 100;
    compatibility +=
        (boy.intelligenceLevel - girl.intelligenceLevel).abs() * 100;
    return compatibility;
  }

  @override
  String toString() {
    return 'Couple { boy: ' + boy.name + ', girl: ' + girl.name + ' }';
  }

}

/// Custom wrapper to store couples
class CoupleList {

  /// Couple List
  List<_Couple> _coupleList;

  /// Constructor to initialize an empty list of couples.
  CoupleList() : _coupleList = new List<_Couple>();

  /// Method to add new Couple
  void addCouple(Boy b, Girl g) {
    _coupleList.add(new _Couple(b, g));
  }

  /// Method to print k most compatible Couples
  void printMostCompatible(int k) {

    print('\n' + k.toString() + ' most compatible couples\n');

    _coupleList.sort((a, b) => b.compatibility.compareTo(a.compatibility));
    if (k > _coupleList.length) {
      k = _coupleList.length;
    }
    for (int i = 0; i < k; i++) {
      print(_coupleList[i]);
      print("Compatibility: " + _coupleList[i].compatibility.toString());
    }
  }

  /// Method to print k most happy Couples
  void printMostHappy(int k) {

    print('\n' + k.toString() + ' most happy couples\n');

    _coupleList.sort((a, b) => b.happiness.compareTo(a.happiness));
    if (k > _coupleList.length) {
      k = _coupleList.length;
    }
    for (int i = 0; i < k; i++) {
      print(_coupleList[i]);
      print("Happiness: " + _coupleList[i].happiness.toString());
    }
  }

  /// Method to print all the Couples
  void printCouples() {
    for (_Couple c in _coupleList) {
      print("Girl:" + c.girl.name + " -- Boy:" + c.boy.name);
    }
  }

  /// Method to perform gifting in the couple i.e. from Boy to Girl
  void performGifting(GiftList list) {
    for (_Couple c in _coupleList) {
      c.boy.sendGiftBasket(list);
    }
  }
}