/// This module contains the Class to Represent a Girl and related objects
library Girl;

import 'package:ValentinesDay/Util.dart';
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

  /// Amount of Happiness. Zero Initially
  double happiness = 0.0;

  /// criterion of selection: Attractiveness, Richness, Intelligence
  String criterion;

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
  bool get isCommitted => boyfriend != null;

  /// Constructor to initialize a Girl
  Girl(String name, int attractiveness, int intelligence,
      this.maintenanceBudget,
      this.criterion) : super(name, attractiveness, intelligence);

  /// Updates the happiness of the Girl according to Logic
  void updateHappiness();

  /// Receives a gift basket from Boyfriend
  void receiveGiftBasket(GiftBasket basket) {
    for (Gift g in basket.giftList) {
      Log.info("Gift Receipt ", "Gift with price " + g.price.toString() +
          " and type " + g.runtimeType.toString()
          + " receieved by Girl " + name);

      switch (g.runtimeType) {
        case EssentialGift:
          totalReceivedGiftAmount[0] += g.price;
          totalReceivedGiftValue[0] += g.value;
          break;
        case UtilityGift:
          totalReceivedGiftAmount[1] += g.price;
          totalReceivedGiftValue[1] += g.value;
          break;
        case LuxuryGift:
          totalReceivedGiftAmount[2] += g.price;
          totalReceivedGiftValue[2] += g.value;
      }
    }
    updateHappiness();
  }

  /// Method to Assign Boyfriend to a Girl as per logic
  void assignBoyfriend(List<Boy> boyList) {
    if (boyfriend == null) {
      switch (criterion) {
        case "Richness":
          boyList.sort((a, b) => a.budget.compareTo(b.budget));
          break;
        case "Attractiveness":
          boyList.sort((a, b) => a.attractiveness.compareTo(b.attractiveness));
          break;
        case "Intelligence":
          boyList.sort((a, b) => a.intelligence.compareTo(b.intelligence));
          break;
      }

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
  }

  /// Method to Assign New Boyfriend to a Girl as per logic
  void assignNewBoyfriend(Boy exBoyfriend, List<Boy> boyList) {
    switch (criterion) {
      case "Richness":
        boyList.sort((a, b) => a.budget.compareTo(b.budget));
        break;
      case "Attractiveness":
        boyList.sort((a, b) => a.attractiveness.compareTo(b.attractiveness));
        break;
      case "Intelligence":
        boyList.sort((a, b) => a.intelligence.compareTo(b.intelligence));
        break;
    }

    for (Boy b in boyList) {
      if (b.girlfriend == null) {
        if (b == exBoyfriend) {
          continue;
        }
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


}

class ChoosyGirl extends Girl {

  ChoosyGirl(String name, int attractiveness, int intelligence,
      double maintenanceBudget,
      String criterion)
      : super(name, attractiveness, intelligence, maintenanceBudget, criterion);


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
      double maintenanceBudget,
      String criterion)
      : super(name, attractiveness, intelligence, maintenanceBudget, criterion);

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
      double maintenanceBudget,
      String criterion)
      : super(name, attractiveness, intelligence, maintenanceBudget, criterion);

  @override
  void updateHappiness() {
    double netGiftAmount = totalReceivedGiftAmount[0] +
        totalReceivedGiftAmount[1] +
        totalReceivedGiftAmount[2];

    /// The happiness of Desperate depends exponentially on Amount of Gifts
    happiness = Math.exp(netGiftAmount / 10000);
  }
}


