library GiftSelector;

import 'package:ValentinesDay/Util.dart';
import 'package:ValentinesDay/model/Boy.dart';
import 'package:ValentinesDay/model/Gift.dart';

abstract class GiftSelector {
  GiftList _giftList;

  GiftSelector(this._giftList);

  void sendGiftBasket(Boy b);
}

class SimpleGiftSelector extends GiftSelector {

  SimpleGiftSelector(GiftList giftList) : super(giftList);

  @override
  void sendGiftBasket(Boy b) {
    // send gift by generic behaviour of Gifting for that boy
    b.sendGiftBasket(_giftList);
  }
}

class DifferentGiftSelector extends GiftSelector {

  DifferentGiftSelector(GiftList giftList) : super(giftList);

  @override
  void sendGiftBasket(Boy b) {

    GiftBasket basket = new GiftBasket();
    Gift essentialGift = _giftList.lowestAmountEssentialGift;
    Gift luxuryGift = _giftList.lowestAmountLuxuryGift;
    Gift utilityGift = _giftList.lowestAmountUtilityGift;
    basket.addGift(essentialGift);
    basket.addGift(luxuryGift);
    basket.addGift(utilityGift);

    b.totalGiftedAmount += basket.totalWorth;
    b.totalGiftedValue += basket.totalValue;

    Log.info("GiftBasket", "Boy: " + b.name + " sent giftbasket with gift amount "
        + basket.totalWorth.toString() + "to Girl: " + b.girlfriend.name);

    b.girlfriend.receiveGiftBasket(basket);
    b.updateHappiness();

  }
}

class RandomGiftSelector extends GiftSelector{

  RandomGiftSelector(GiftList giftList) : super(giftList);

  @override
  void sendGiftBasket(Boy b) {
    GiftBasket basket = new GiftBasket();
    while(basket.totalWorth > b.girlfriend.maintenanceBudget){
      Gift g = _giftList.getRandomGift();
      basket.addGift(g);
      _giftList.removeGift(g);
    }

    b.totalGiftedAmount += basket.totalWorth;
    b.totalGiftedValue += basket.totalValue;

    Log.info("GiftBasket", "Boy: " + b.name + " sent giftbasket with gift amount "
        + basket.totalWorth.toString() + "to Girl: " + b.girlfriend.name);

    b.girlfriend.receiveGiftBasket(basket);
    b.updateHappiness();

  }

}