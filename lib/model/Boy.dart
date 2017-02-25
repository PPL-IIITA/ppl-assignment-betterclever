import 'Girl.dart';
import 'package:ValentinesDay/model/Gift.dart';

class Boy{

  String name; //Name of Boy
  int attractiveness; //Attractiveness on scale of 1-10
  int intelligenceLevel; //intelligence level on scale of 1-10
  double budget; //Budget of Boy

  String type; //type of Boy

  int minAttractivenessRequired; // min attractiveness requirement from a Girl

  double happiness = 0.0; //happiness amount. Initially Zero
  double totalGiftedAmount = 0.0; //total value of gifts gifted to Girlfriend

  Boy(this.name, this.type, this.attractiveness, this.minAttractivenessRequired,
      this.intelligenceLevel, this.budget);

  Girl girlfriend = null;

  void updateHappiness(){
    if(type == "Miser"){
      // The happiness of a Miser depends on total unspent money from Budget
      happiness = budget - totalGiftedAmount;
    }

    if(type == "Generous"){
      // The happiness of Generous depends on happiness of Girlfriend
      if(Girl!=null)
        happiness = girlfriend.happiness;
    }

    if(type == "Geek"){
      // The happiness of Geek is given by intelligence of Girlfriend
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

  void sendGiftBasket(GiftList gifts) {
    GiftBasket basket = new GiftBasket();
    //print(type);
    //print(budget);
    switch(type){
      case "Miser":
        while(basket.totalGiftedAmount < girlfriend.maintenanceBudget){
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
        break;
      case "Generous":
        while(basket.totalGiftedAmount < budget){
          Gift gift = gifts.lowestAmountGift;
          //print(gift.price);
          if(gift.price + basket.totalGiftedAmount > budget){
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
        while(basket.totalGiftedAmount < girlfriend.maintenanceBudget){
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
          if(basket.totalGiftedAmount + lowestAmountLuxuryGift.price < budget){
            basket.addGift(lowestAmountLuxuryGift);
          }
        }
        break;
    }
    girlfriend.receiveGiftBasket(basket);
    updateHappiness();
  }

}