/// This module contains various Algorithms to make couples
library Algorithm;

import 'model/Couple.dart';
import 'package:ValentinesDay/model/Boy.dart';
import 'package:ValentinesDay/model/Girl.dart';

/// Function to make couples by algorithm given in Question 1
CoupleList makeCouples1(List<Boy> boyList, List<Girl> girlList) {
  print("Making couples by algorithm in Question 1");

  CoupleList coupleList = new CoupleList();
  for (Girl girl in girlList) {
    girl.assignBoyfriend(boyList);
    if (girl.isCommitted) {
      coupleList.addCouple(girl.boyfriend, girl);
    }
  }

  return coupleList;
}

/// Function to make couples by algorithm given in Question 1
CoupleList makeCouples2(List<Boy> boyList, List<Girl> girlList) {
  print("Making couples by algorithm in Question 5");

  CoupleList coupleList = new CoupleList();

  // new algorithm
  boyList.sort((a, b) => b.attractiveness.compareTo(a.attractiveness));
  girlList.sort((a, b) => b.maintenanceBudget.compareTo(a.maintenanceBudget));

  int boysListSize = boyList.length;
  int girlListSize = girlList.length;

  int b_i = 0;
  int g_i = 0;

  for (int i = 0; i < boysListSize + girlListSize; i++) {
    if (g_i != girlListSize) {
      switch (i % 2) {
        case 0:
          girlList[g_i++].assignBoyfriend(boyList);
          boyList.sort((a, b) => b.attractiveness.compareTo(a.attractiveness));
          break;
        case 1:
          boyList[b_i++].assignGirlfriend(girlList);
          break;
      }
    }
    else {
      break;
    }
  }

  for (Girl g in girlList) {
    if (g.isCommitted) {
      coupleList.addCouple(g.boyfriend, g);
    }
  }

  return coupleList;
}