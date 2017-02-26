/// This module contains the Class to Represent a Boy and related objects
library Boy;
/*
* Created by betterclever
* */

import 'Girl.dart';
import 'package:ValentinesDay/Util.dart';
import 'package:ValentinesDay/model/Gift.dart';

/// Class to represent a Boy
class Boy{

  /// Name of Boy
  String name;
  ///Attractiveness on scale of 1-10
  int attractiveness;
  ///intelligence level on scale of 1-10
  int intelligenceLevel;
  ///Budget of Boy
  double budget;
  ///Type of Boy: Miser, Generous, Geek
  String type;
  ///min attractiveness requirement from a Girl
  int minAttractivenessRequired;
  ///Happiness amount. Initially Zero
  double happiness = 0.0;
  ///Total value of gifts gifted to Girlfriend
  double totalGiftedAmount = 0.0;

  /// Constructor to initialize a Boy
  Boy(this.name, this.type, this.attractiveness, this.minAttractivenessRequired,
      this.intelligenceLevel, this.budget);

  Girl girlfriend = null;

  /// Updates the happiness of the Boy. Call after gifting basket to Girlfriend
  void updateHappiness(){
    /// The happiness of a Miser depends on total unspent money from Budget
    if(type == "Miser"){
      happiness = budget - totalGiftedAmount;
    }
    /// The happiness of Generous depends on happiness of Girlfriend
    if(type == "Generous"){
      if(Girl!=null)
        happiness = girlfriend.happiness;
    }
    /// The happiness of Geek is given by intelligence of Girlfriend
    if(type == "Geek"){
      if(Girl!=null)
        happiness = 10.00 * girlfriend.intelligenceLevel;
    }
  }


  @override
  String toString() {
    return 'Boy{name: $name, '
        'attractiveness: $attractiveness, '
        'intelligenceLevel: $intelligenceLevel, '
        'minAttractivenessRequired: $minAttractivenessRequired, '
        'budget: $budget, '
        'type: $type, '
        'happiness: $happiness, '
        'totalGiftedAmount: $totalGiftedAmount, '
        'girlfriend: ' + (girlfriend != null ? girlfriend.name : 'null' )+ '}';
  }

  /// Sends a Gift Basket to the Girlfriend
  void sendGiftBasket(GiftList gifts) {
    GiftBasket basket = new GiftBasket();
    switch(type){
      case "Miser":
        while(basket.totalWorth < girlfriend.maintenanceBudget){
          Gift gift = gifts.lowestAmountGift;
          if(gift.price <= budget){
            basket.addGift(gift);
            gifts.removeLowest();
          }
          else{
            break;
          }
        }
        break;
      case "Generous":
        while(basket.totalWorth < budget){
          Gift gift = gifts.lowestAmountGift;
          //print(gift.price);
          if(gift.price + basket.totalWorth > budget){
            break;
          }
          if(gift.price <= budget){
            basket.addGift(gift);
            gifts.removeLowest();
          }
          else{
            break;
          }
        }
        break;
      case "Geek":
        //print("I am geek");
        while(basket.totalWorth < girlfriend.maintenanceBudget){
          //print(basket.totalGiftedAmount);
          Gift gift = gifts.lowestAmountGift;
          //print(gift.price);
          if(gift.price <= budget){
            basket.addGift(gift);
            gifts.removeLowest();
          }
          else{
            break;
          }
        }
        Gift lowestAmountLuxuryGift = gifts.lowestAmountLuxuryGift;
        if(lowestAmountLuxuryGift!=null){
          if(basket.totalWorth + lowestAmountLuxuryGift.price < budget){
            basket.addGift(lowestAmountLuxuryGift);
            gifts.removeGift(lowestAmountLuxuryGift);
          }
        }
        break;
    }

    Log.info("GiftBasket","Boy: "+ name + " sent giftbasket with gift amount "
        + basket.totalWorth.toString() + "to Girl: " + girlfriend.name);

    girlfriend.receiveGiftBasket(basket);
    updateHappiness();
  }

}