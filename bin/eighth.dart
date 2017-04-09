import 'dart:io';
import 'package:ValentinesDay/Util.dart';
import 'package:ValentinesDay/model/Boy.dart';
import 'package:ValentinesDay/model/Couple.dart';
import 'package:ValentinesDay/model/Gift.dart';
import 'package:ValentinesDay/model/GiftSelector.dart';
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

  CoupleList coupleList = Algorithm.makeCouples1(boyList, girlList);

  print("Couples Formed");

  coupleList.printCouples();

  print("Use New GiftSelector (Y/N)");
  String reply = stdin.readLineSync();

  GiftSelector giftSelector;
  if (reply.startsWith('Y')) {
    giftSelector = new DifferentGiftSelector(giftList);
  }
  else
    giftSelector = new SimpleGiftSelector(giftList);

  coupleList.performGenericGifting(giftSelector);

}
