import 'dart:io';
import 'package:ValentinesDay/TopKPicker.dart';
import 'package:ValentinesDay/Util.dart';
import 'package:ValentinesDay/model/Boy.dart';
import 'package:ValentinesDay/model/Couple.dart';
import 'package:ValentinesDay/model/Gift.dart';
import 'package:ValentinesDay/model/Girl.dart';

main(List<String> arg) {
  if (arg.length < 2) {
    print("Enter 2 arguments: girlCount, boyCount");
    return;
  }

  List<Girl> girlList = Utils.getGirls(int.parse(arg[0]));
  List<Boy> boyList = Utils.getBoys(int.parse(arg[1]));

  CoupleList coupleList = new CoupleList();

  print("Enter m for top selection");
  int m = int.parse(stdin.readLineSync());

  List<Boy> topKBoys = TopKPicker.getTopK(boyList, m);

  for (Girl girl in girlList) {
    girl.assignBoyfriend(topKBoys);
    if (girl.isCommitted) {
      coupleList.addCouple(girl.boyfriend, girl);
    }
  }

  print("Couples Formed");

  coupleList.printCouples();

  GiftList newGiftList = new GiftList.fromList(
      TopKPicker.getTopK(Utils.getGifts(), 1000));

  coupleList.performGifting(newGiftList);

  print("Enter K");
  int k = int.parse(stdin.readLineSync());

  coupleList.printMostCompatible(k);
  coupleList.printMostHappy(k);

}