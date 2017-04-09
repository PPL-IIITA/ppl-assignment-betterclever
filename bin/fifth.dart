import 'dart:io';
import 'package:ValentinesDay/Util.dart';
import 'package:ValentinesDay/model/Boy.dart';
import 'package:ValentinesDay/model/Couple.dart';
import 'package:ValentinesDay/model/Gift.dart';
import 'package:ValentinesDay/model/Girl.dart';
import 'package:ValentinesDay/Algorithm.dart' as Algorithm;

main(List<String> arg) {
  if (arg.length < 2) {
    print("Enter 2 arguments: girlCount, boyCount");
    return;
  }

  List<Girl> girlList = Utils.getGirls(int.parse(arg[0]));
  List<Boy> boyList = Utils.getBoys(int.parse(arg[1]));
  GiftList giftList = new GiftList.fromList(Utils.getGifts());

  print("Enter Algorithm Choice: 1/5");
  int choice = int.parse(stdin.readLineSync());

  CoupleList coupleList;

  switch (choice) {
    case 1:
      coupleList = Algorithm.makeCouples1(boyList, girlList);
      break;
    case 5:
      coupleList = Algorithm.makeCouples2(boyList, girlList);
      break;
    default:
      coupleList = Algorithm.makeCouples1(boyList, girlList);
  }

  print("Couples Formed");

  coupleList.printCouples();
  coupleList.performGifting(giftList);

  print("Gifting Complete");
  print("Enter K");
  int k = int.parse(stdin.readLineSync());

  coupleList.printMostCompatible(k);
  coupleList.printMostHappy(k);
}
