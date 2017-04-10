/// This module contains various implementations for selection of Gifts
library GiftSelector;

import 'package:ValentinesDay/Util.dart';
import 'package:ValentinesDay/model/Boy.dart';
import 'package:ValentinesDay/model/Gift.dart';

/// Base class for Gift Selection
abstract class GiftSelector {
  /// private giftList to manage gifts internally
  GiftList _giftList;

  /// Constructor to create a new GiftSelector
  GiftSelector(this._giftList);

  /// method to perform gift selection and send a basket to girlfriend
  void sendGiftBasket(Boy b);
}

/// Class to represent a Simple Gift Selector which performs gifting based on
/// Generic choice of Boy
class SimpleGiftSelector extends GiftSelector {

  SimpleGiftSelector(GiftList giftList) : super(giftList);

  @override
  void sendGiftBasket(Boy b) {
    // send gift by generic behaviour of Gifting for that boy
    b.sendGiftBasket(_giftList);
  }
}

/// Class to represent a Different Gift Selector which selects at least one
/// gift of every type
class DifferentGiftSelector extends GiftSelector {

  /// Constructor to initialize Different Gift Selector
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

/// Class to represent a Gift Selector that randomly fetches gifts using
/// Custom Random Class and perform Gifting
class RandomGiftSelector extends GiftSelector{

  /// Constructor to initialize a Random Gift Selector
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