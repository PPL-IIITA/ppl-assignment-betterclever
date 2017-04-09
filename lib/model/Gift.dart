/// This library contains Gift Class and related wrappers for List implementation
library Gift;
/*
* Created by betterclever
* */

/// Class to represent a Gift
abstract class Gift {

  /// Cost of a Gift
  double price;
  /// Value of a Gift
  double value;

  Gift(this.price, this.value);

}

class EssentialGift extends Gift{

  EssentialGift(double price, double value) : super(price, value);

}

class UtilityGift extends Gift {

  /// Utility Value of Utility Gift. 0 for others.
  double utilityValue;
  /// Utility Class of a Utility Gift. null for others.
  String utilityClass;

  UtilityGift(double price, double value, this.utilityValue,
      this.utilityClass) : super(price, value);

}

class LuxuryGift extends Gift {

  /// Difficulty rating of a Luxury Gift on a scale of 1-10.
  int difficultyToObtain;
  /// Luxury rating of a Luxury Gift on a scale of 1-10.
  int luxuryRating;

  LuxuryGift(double price, double value, this.difficultyToObtain,
      this.luxuryRating) :super(price, value);

}



/// Custom Wrapper class to represent a GiftBasket sent by Boy to Girl. Wrapped
/// around List of Gift.
class GiftBasket {

  /// Internal List of Gifts. Private. Read Only
  List<Gift> _giftList;

  /// Constructor to Initialize a GiftBasket
  GiftBasket() : _giftList = new List<Gift>();

  /// Method to add a Gift to GiftBasket
  void addGift(Gift gift) {
    _giftList.add(gift);
  }

  /// dart style getter to get Total Worth of the Basket
  double get totalWorth {
    double d = 0.0;
    for (Gift g in _giftList) {
      d += g.price;
    }
    return d;
  }

  double get totalValue {
    double d = 0.0;
    for (Gift g in _giftList) {
      d += g.value;
    }
    return d;
  }

  /// dart style getter to get list of Gifts.
  List get giftList {
    return _giftList;
  }
}

/// Custom wrapper class to represent a List of Gifts
class GiftList {

  /// Internal List of Gifts. Private.
  List<Gift> _giftList;

  /// Named constructor to initialize GiftList object from list from Gifts
  GiftList.fromList(this._giftList);

  /// dart style getter to get lowest value gift
  Gift get lowestAmountGift {
    _giftList.sort((a, b) => a.price.compareTo(b.price));
    return _giftList[0];
  }

  /// method to remove the least cost gift from GiftList
  void removeLowest() {
    _giftList.removeAt(0);
  }

  /// dart style getter to get lowest cost luxury gift
  Gift get lowestAmountLuxuryGift {
    Gift gift;
    for (Gift g in _giftList) {
      if (g is LuxuryGift) {
        gift = g;
        break;
      }
    }
    return gift;
  }

  /// dart style getter to get lowest cost luxury gift
  Gift get lowestAmountUtilityGift {
    Gift gift;
    for (Gift g in _giftList) {
      if (g is UtilityGift) {
        gift = g;
        break;
      }
    }
    return gift;
  }

  /// dart style getter to get lowest cost Essential gift
  Gift get lowestAmountEssentialGift {
    Gift gift;
    for (Gift g in _giftList) {
      if (g is EssentialGift) {
        gift = g;
        break;
      }
    }
    return gift;
  }

  /// method to remove a gift
  void removeGift(Gift gift) {
    _giftList.remove(gift);
  }

}


