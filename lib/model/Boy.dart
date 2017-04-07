/// This module contains the Class to Represent a Boy and related objects
library Boy;

import 'package:ValentinesDay/model/Gift.dart';
import 'package:ValentinesDay/model/Girl.dart';
import 'package:ValentinesDay/model/Person.dart';
/*
* Created by betterclever
* */

/// Class to represent a Boy
abstract class Boy extends Person {

  /// Budget of Boy
  double budget;

  /// min attractiveness requirement from a Girl
  int minAttractivenessRequired;

  /// Amount of Happiness. Zero Initially
  double happiness = 0.0;

  /// Total value of gifts gifted to Girlfriend
  double totalGiftedValue;

  /// Total Amount of gifts gifted to Girlfriend
  double totalGiftedAmount;

  /// Girlfriend of Boy if he is committed. null otherwise
  Girl girlfriend = null;

  /// Getter for checking if boy is committed
  bool get isCommitted => girlfriend == null;

  /// Constructor to initialize a boy
  Boy(String name, int attractiveness, int intelligence,
      this.minAttractivenessRequired, this.budget) :
        super(name, attractiveness, intelligence);

  /// Updates the happiness of the Boy. Call after gifting basket to Girlfriend
  void updateHappiness();

  /// Sends a Gift Basket to the Girlfriend
  void sendGiftBasket(GiftList gifts);
}

/// Class to Represent a Miser Boy
class MiserBoy extends Boy {

  MiserBoy(String name, int attractiveness, int intelligence,
      int minAttractivenessRequired, double budget) :
        super(name, attractiveness, intelligence, minAttractivenessRequired,
          budget);

  @override
  void sendGiftBasket(GiftList gifts) {
    GiftBasket basket = new GiftBasket();

    while (basket.totalWorth < girlfriend.maintenanceBudget) {
      Gift gift = gifts.lowestAmountGift;
      if (gift.price <= budget) {
        basket.addGift(gift);
        gifts.removeLowest();
      }
      else
        break;
    }
  }

  @override
  void updateHappiness() {
    happiness = budget - totalGiftedAmount;
  }
}

class GenerousBoy extends Boy {

  GenerousBoy(String name, int attractiveness, int intelligence,
      int minAttractivenessRequired, double budget) :
        super(name, attractiveness, intelligence, minAttractivenessRequired,
          budget);

  @override
  void sendGiftBasket(GiftList gifts) {
    GiftBasket basket = new GiftBasket();
    while (basket.totalWorth < budget) {
      Gift gift = gifts.lowestAmountGift;
      //print(gift.price);
      if (gift.price + basket.totalWorth > budget)
        break;
      if (gift.price <= budget) {
        basket.addGift(gift);
        gifts.removeLowest();
      }
      else
        break;
    }
  }

  @override
  void updateHappiness() {
    if (girlfriend != null)
      happiness = girlfriend.happiness;
  }

}

class GeekBoy extends Boy {

  GeekBoy(String name, int attractiveness, int intelligence,
      int minAttractivenessRequired, double budget) :
        super(name, attractiveness, intelligence, minAttractivenessRequired,
          budget);

  @override
  void sendGiftBasket(GiftList gifts) {
    GiftBasket basket = new GiftBasket();
    while (basket.totalWorth < girlfriend.maintenanceBudget) {
      Gift gift = gifts.lowestAmountGift;
      if (gift.price <= budget) {
        basket.addGift(gift);
        gifts.removeLowest();
      }
      else
        break;
    }
    Gift lowestAmountLuxuryGift = gifts.lowestAmountLuxuryGift;
    if (lowestAmountLuxuryGift != null) {
      if (basket.totalWorth + lowestAmountLuxuryGift.price < budget) {
        basket.addGift(lowestAmountLuxuryGift);
        gifts.removeGift(lowestAmountLuxuryGift);
      }
    }
  }

  @override
  void updateHappiness() {
    if (girlfriend != null)
      happiness = 10.00 * girlfriend.intelligence;
  }

}