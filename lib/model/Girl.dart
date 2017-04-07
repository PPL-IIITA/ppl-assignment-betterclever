/// This module contains the Class to Represent a Girl and related objects
library Girl;

import 'package:ValentinesDay/model/Boy.dart';
import 'package:ValentinesDay/model/Gift.dart';
import 'package:ValentinesDay/model/Person.dart';
import 'dart:math' as Math;

/*
* Created by betterclever
* */

/// Class to represent a Girl
abstract class Girl extends Person {

  /// Maintenance budget of Girl
  double maintenanceBudget;

  /// min attractiveness requirement from a Boy
  int minAttractivenessRequired;

  /// Amount of Happiness. Zero Initially
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

  /// Boyfriend of Girl if she is committed. null otherwise
  Boy boyfriend = null;

  /// Getter for checking if Girl is committed
  bool get isCommitted => boyfriend == null;

  /// Constructor to initialize a Girl
  Girl(String name, int attractiveness, int intelligence,
      this.minAttractivenessRequired, this.maintenanceBudget) :
        super(name, attractiveness, intelligence);

  /// Updates the happiness of the Girl according to Logic
  void updateHappiness();

  /// Receives a gift basket from Boyfriend
  void receiveGiftBasket(GiftBasket giftBasket){

  }

}

class ChoosyGirl extends Girl {

  ChoosyGirl(String name, int attractiveness, int intelligence,
      int minAttractivenessRequired, double maintenanceBudget) :
        super(name, attractiveness, intelligence, minAttractivenessRequired,
          maintenanceBudget);

  @override
  void updateHappiness() {
    /// The netGiftAmount for Choosy depends on cost of gifts but luxury gifts count double
    double netGiftAmount = totalReceivedGiftAmount[0] +
        totalReceivedGiftAmount[1] +
        2 * totalReceivedGiftAmount[2];

    /// The happiness of a Choosy Girl depends Logarithmically on totalReceivedGiftAmount
    happiness = 10 * Math.log(netGiftAmount + 10);
  }
}

class NormalGirl extends Girl {

  NormalGirl(String name, int attractiveness, int intelligence,
      int minAttractivenessRequired, double maintenanceBudget) :
        super(name, attractiveness, intelligence, minAttractivenessRequired,
          maintenanceBudget);

  @override
  void updateHappiness() {
    double netGiftAmount = totalReceivedGiftAmount[0] +
        totalReceivedGiftAmount[1] +
        totalReceivedGiftAmount[2];

    double netGiftValue = totalReceivedGiftValue[0] +
        totalReceivedGiftValue[1] +
        totalReceivedGiftValue[2];

    /// The happiness of Normal Girl depends linearly on total received gift amount + value
    happiness = netGiftAmount + netGiftValue;
  }
}

class DesperateGirl extends Girl {

  DesperateGirl(String name, int attractiveness, int intelligence,
      int minAttractivenessRequired, double maintenanceBudget) :
        super(name, attractiveness, intelligence, minAttractivenessRequired, maintenanceBudget);

  @override
  void updateHappiness() {
    double netGiftAmount = totalReceivedGiftAmount[0] +
        totalReceivedGiftAmount[1] +
        totalReceivedGiftAmount[2];

    /// The happiness of Desperate depends exponentially on Amount of Gifts
    happiness = Math.exp(netGiftAmount / 10000);
  }
}


