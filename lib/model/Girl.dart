import 'Boy.dart';
import 'dart:math' as Math;

class Girl {
  String name; //Name of Girl
  int attractiveness; //Attractiveness on scale of 1-10
  int intelligenceLevel; //intelligence level on scale of 1-10
  double maintenanceBudget; //Maintenance budget of Girl

  String type; //type of Girl. Allowed values: "Choosy, Normal, Desperate"

  double happiness = 0.0; //happiness amount. Initially Zero

  /*
    List of total Received Gift Amount from the Boyfriends
    index 0: Essential Gift Amount
    index 1: Luxury Gift Amount
    index 2: Utility Gift Amount
  */
  List<double> totalReceivedGiftAmount = [0.0,0.0,0.0];

  /*
    List of total Received Gift Value from the Boyfriends
    index 0: Essential Gift Value
    index 1: Luxury Gift Value
    index 2: Utility Gift Value
  */
  List<double> totalReceivedGiftValue = [0.0,0.0,0.0];

  Boy boyfriend = null; //Boyfriend of Girl. `null` initially

  Girl(this.name, this.type, this.attractiveness, this.intelligenceLevel, this.maintenanceBudget);

  void updateHappiness(){
    if(type == "Choosy"){
      // The netGiftAmount for Choosy depends on cost of gifts but luxury gifts count double
      double netGiftAmount = totalReceivedGiftAmount[0] +
          totalReceivedGiftAmount[1] +
          2*totalReceivedGiftAmount[2];

      // The happiness of a Choosy Girl depends Logarithmically on totalReceivedGiftAmount
      happiness = 10*Math.log(netGiftAmount + 10);
    }

    if(type == "Normal"){

      double netGiftAmount = totalReceivedGiftAmount[0]+
          totalReceivedGiftAmount[1]+
          totalReceivedGiftAmount[2];

      double netGiftValue = totalReceivedGiftValue[0]+
          totalReceivedGiftValue[1]+
          totalReceivedGiftValue[2];

      // The happiness of Normal Girl depends linearly on total received gift amount + value
      happiness = netGiftAmount + netGiftValue;
    }

    if(type == "Desperate"){

      double netGiftAmount = totalReceivedGiftAmount[0]+
          totalReceivedGiftAmount[1]+
          totalReceivedGiftAmount[2];

      // The happiness of Desperate depends exponentially on Amount of Gifts
      happiness = Math.exp(netGiftAmount);
    }
  }


  @override
  String toString() {
    return 'Girl{name: $name, '
        'attractiveness: $attractiveness, '
        'intelligenceLevel: $intelligenceLevel, '
        'maintenanceBudget: $maintenanceBudget, '
        'type: $type, '
        'happiness: $happiness, '
        'totalReceivedGiftAmount: $totalReceivedGiftAmount, '
        'totalReceivedGiftValue: $totalReceivedGiftValue, '
        'boyfriend: ' + (boyfriend != null ? boyfriend.name : 'null' )+ '}' ;
  }

  void assignBoyfriend(List<Boy> boyList) {
    for (Boy b in boyList) {
      if (b.girlfriend == null) {
        if (maintenanceBudget <= b.budget
            && attractiveness >= b.minAttractivenessRequired) {
          b.girlfriend = this;
          this.boyfriend = b;
          return;
        }
      }
    }
  }

  bool isCommitted(){
    return boyfriend != null;
  }
}