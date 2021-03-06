/// This library contains the Class to Represent a Girl and related objects
library Girl;
/*
* Created by betterclever
* */

import 'Boy.dart';
import 'dart:math' as Math;

import 'package:ValentinesDay/Util.dart';
import 'package:ValentinesDay/model/Gift.dart';

/// Class to Represent a Girl
class Girl {

  /// Name of Girl
  String name;

  /// Attractiveness on scale of 1-10
  int attractiveness;

  /// intelligence level on scale of 1-10
  int intelligenceLevel;

  /// Maintenance budget of Girl
  double maintenanceBudget;

  /// Type of Girl. Allowed values: "Choosy, Normal, Desperate"
  String type;

  /// Happiness amount. Initially Zero
  double happiness = 0.0;

  /// List of total Received Gift Amount from the Boyfriends
  ///
  /// * index 0: Essential Gift Amount
  /// * index 1: Luxury Gift Amount
  /// * index 2: Utility Gift Amount
  List<double> totalReceivedGiftAmount = [0.0, 0.0, 0.0];

  ///  List of total Received Gift Value from the Boyfriends
  ///
  /// * index 0: Essential Gift Value
  /// * index 1: Luxury Gift Value
  /// * index 2: Utility Gift Value
  List<double> totalReceivedGiftValue = [0.0, 0.0, 0.0];

  /// Boyfriend of Girl. `null` initially
  Boy boyfriend = null;

  /// Constructor to initialize a Girl
  Girl(this.name, this.type, this.attractiveness, this.intelligenceLevel,
      this.maintenanceBudget);

  /// Method to update happiness of a Girl according to logic
  void updateHappiness() {
    if (type == "Choosy") {
      /// The netGiftAmount for Choosy depends on cost of gifts but luxury gifts count double
      double netGiftAmount = totalReceivedGiftAmount[0] +
          totalReceivedGiftAmount[1] +
          2 * totalReceivedGiftAmount[2];

      /// The happiness of a Choosy Girl depends Logarithmically on totalReceivedGiftAmount
      happiness = 10 * Math.log(netGiftAmount + 10);
    }

    if (type == "Normal") {
      double netGiftAmount = totalReceivedGiftAmount[0] +
          totalReceivedGiftAmount[1] +
          totalReceivedGiftAmount[2];

      double netGiftValue = totalReceivedGiftValue[0] +
          totalReceivedGiftValue[1] +
          totalReceivedGiftValue[2];

      /// The happiness of Normal Girl depends linearly on total received gift amount + value
      happiness = netGiftAmount + netGiftValue;
    }

    if (type == "Desperate") {
      double netGiftAmount = totalReceivedGiftAmount[0] +
          totalReceivedGiftAmount[1] +
          totalReceivedGiftAmount[2];

      /// The happiness of Desperate depends exponentially on Amount of Gifts
      happiness = Math.exp(netGiftAmount / 10000);
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
        'boyfriend: ' +
        (boyfriend != null ? boyfriend.name : 'null') +
        '}';
  }

  /// Method to Assign Boyfriend to a Girl as per logic
  void assignBoyfriend(List<Boy> boyList) {
    for (Boy b in boyList) {
      if (b.girlfriend == null) {
        if (maintenanceBudget <= b.budget &&
            attractiveness >= b.minAttractivenessRequired) {
          b.girlfriend = this;
          this.boyfriend = b;
          Log.info("Commitment", b.name + ' committed to ' + name);
          return;
        }
      }
    }
  }

  /// returns the commitment status of a Girl
  bool isCommitted() {
    return boyfriend != null;
  }

  /// Method to Receive a GiftBasket from Boyfriend
  void receiveGiftBasket(GiftBasket basket) {
    for (Gift g in basket.giftList) {
      Log.info("Gift Receipt ", "Gift with price " + g.price.toString() +
          " and type " + g.type
          + " receieved by Girl " + name);

      switch (g.type) {
        case "Essential":
          totalReceivedGiftAmount[0] += g.price;
          totalReceivedGiftValue[0] += g.value;
          break;
        case "Luxury":
          totalReceivedGiftAmount[1] += g.price;
          totalReceivedGiftValue[1] += g.value;
          break;
        case "Utility":
          totalReceivedGiftAmount[2] += g.price;
          totalReceivedGiftValue[2] += g.value;
      }
    }
    updateHappiness();
  }
}
