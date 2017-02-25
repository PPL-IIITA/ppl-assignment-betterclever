import 'package:ValentinesDay/model/Boy.dart';
import 'package:ValentinesDay/model/Gift.dart';
import 'package:ValentinesDay/model/Girl.dart';

class _Couple {
  Boy boy;
  Girl girl;

  _Couple(this.boy, this.girl);

  double get happiness {
    return boy.happiness + girl.happiness;
  }

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

class CoupleList {

  List<_Couple> _coupleList;

  CoupleList() : _coupleList = new List<_Couple>();

  void addCouple(Boy b, Girl g) {
    _coupleList.add(new _Couple(b, g));
  }

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

  void printCouples() {
    for (_Couple c in _coupleList) {
      print("Girl:" + c.girl.name + " -- Boy:" + c.boy.name);
    }
  }

  void performGifting(GiftList list) {
    for (_Couple c in _coupleList) {
      c.boy.sendGiftBasket(list);
    }
  }
}