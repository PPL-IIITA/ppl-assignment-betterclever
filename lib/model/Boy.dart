/// This module contains the Class to Represent a Boy and related objects
library Boy;

import 'package:ValentinesDay/TopKPicker.dart';
import 'package:ValentinesDay/Util.dart';
import 'package:ValentinesDay/model/Gift.dart';
import 'package:ValentinesDay/model/Girl.dart';
import 'package:ValentinesDay/model/Person.dart';
/*
* Created by betterclever
* */

/// Class to represent a Boy
abstract class Boy extends Person implements TopSelectable {

  /// Budget of Boy
  double budget;

  /// min attractiveness requirement from a Girl
  int minAttractivenessRequired;

  /// Amount of Happiness. Zero Initially
  double happiness = 0.0;

  /// Total value of gifts gifted to Girlfriend
  double totalGiftedValue = 0.0;

  /// Total Amount of gifts gifted to Girlfriend
  double totalGiftedAmount = 0.0;

  /// Girlfriend of Boy if he is committed. null otherwise
  Girl girlfriend = null;

  @override
  num get primaryCriterionValue{
    return budget;
  }

  /// Getter for checking if boy is committed
  bool get isCommitted => girlfriend != null;

  /// Constructor to initialize a boy
  Boy(String name, int attractiveness, int intelligence,
      this.minAttractivenessRequired, this.budget) :
        super(name, attractiveness, intelligence);

  /// Updates the happiness of the Boy. Call after gifting basket to Girlfriend
  void updateHappiness();

  /// Sends a Gift Basket to the Girlfriend
  void sendGiftBasket(GiftList gifts);

  /// Method to assign Girlfriend to a Boy as per logic
  void assignGirlfriend(List<Girl> girlList) {
    if (girlfriend == null) {
      for (Girl g in girlList) {
        if (g.boyfriend == null) {
          if (budget >= g.maintenanceBudget &&
              g.attractiveness >= minAttractivenessRequired) {
            this.girlfriend = g;
            g.boyfriend = this;
            Log.info("Commitment", name + ' committed to ' + g.name);
            return;
          }
        }
      }
    }
  }
}

/// Class to Represent a Miser Boy
class MiserBoy extends Boy {

  /// Constructor to create a new Miser Boy
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

    totalGiftedAmount += basket.totalWorth;
    totalGiftedValue += basket.totalValue;

    Log.info("GiftBasket", "Boy: " + name + " sent giftbasket with gift amount "
        + basket.totalWorth.toString() + "to Girl: " + girlfriend.name);

    girlfriend.receiveGiftBasket(basket);
    updateHappiness();
  }

  @override
  void updateHappiness() {
    happiness = budget - totalGiftedAmount;
  }
}

/// Class to Represent a Generous Boy
class GenerousBoy extends Boy {

  /// Constructor to create a new Generous Boy
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

    totalGiftedAmount += basket.totalWorth;
    totalGiftedValue += basket.totalValue;

    Log.info("GiftBasket", "Boy: " + name + " sent giftbasket with gift amount "
        + basket.totalWorth.toString() + "to Girl: " + girlfriend.name);

    girlfriend.receiveGiftBasket(basket);
    updateHappiness();
  }

  @override
  void updateHappiness() {
    if (girlfriend != null)
      happiness = girlfriend.happiness;
  }

}

/// Class to Represent a Geek Boy
class GeekBoy extends Boy {

  /// Constructor to create a new Geek Boy
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

    totalGiftedAmount += basket.totalWorth;
    totalGiftedValue += basket.totalValue;

    Log.info("GiftBasket", "Boy: " + name + " sent giftbasket with gift amount "
        + basket.totalWorth.toString() + "to Girl: " + girlfriend.name);

    girlfriend.receiveGiftBasket(basket);
    updateHappiness();
  }

  @override
  void updateHappiness() {
    if (girlfriend != null)
      happiness = 10.00 * girlfriend.intelligence;
  }

}