class Gift {
  double price;
  double value;

  String type ;

  int difficultyToObtain;
  int luxuryRating;

  double utilityValue;
  String utilityClass;

  Gift.newEssential(this.price,this.value):
        type = "Essential";

  Gift.newLuxury(this.price,this.value,this.difficultyToObtain,this.luxuryRating):
        type = "Luxury";

  Gift.newUtility(this.price,this.value,this.utilityValue,this.utilityClass):
        type = "Utility";

  @override
  String toString() {
    return 'Gift{price: $price, '
        'value: $value, '
        'type: $type, '
        'difficultyToObtain: $difficultyToObtain, '
        'luxuryRating: $luxuryRating, '
        'utilityValue: $utilityValue, '
        'utilityClass: $utilityClass}';
  }
}

class GiftBasket {

  List<Gift> _giftList;

  GiftBasket() : _giftList = new List<Gift>();

  void addGift(Gift gift){
    _giftList.add(gift);
  }

  double get totalGiftedAmount {
    double d = 0.0;
    for(Gift g in _giftList){
      d += g.price;
    }
    return d;
  }

  List get giftList{
    return _giftList;
  }
}

class GiftList {
  List<Gift> _giftList;

  GiftList.fromList(this._giftList);

  Gift get lowestAmountGift {
    _giftList.sort((a, b) => a.price.compareTo(b.price));
    return _giftList[0];
  }

  void removeLowest(){
    _giftList.removeAt(0);
  }

  Gift get lowestAmountLuxuryGift {
    Gift gift;
    for(Gift g in _giftList){
      if(g.type == "Luxury"){
        gift = g;
        break;
      }
    }
    return gift;
  }
}