import 'dart:io';
import 'package:ValentinesDay/Util.dart';
import 'package:ValentinesDay/model/Boy.dart';
import 'package:ValentinesDay/model/Couple.dart';
import 'package:ValentinesDay/model/Gift.dart';
import 'package:ValentinesDay/model/Girl.dart';

main(List<String> arg){

  if(arg.length < 2){
    print("Enter 2 arguments: girlCount, boyCount");
    return;
  }

  List<Girl> girlList = Utils.getGirls(int.parse(arg[0]));
  List<Boy> boyList = Utils.getBoys(int.parse(arg[1]));
  GiftList giftList = new GiftList.fromList(Utils.getGifts());

  CoupleList coupleList = new CoupleList();

  for(Girl girl in girlList){
    girl.assignBoyfriend(boyList);
    if(girl.isCommitted){
      coupleList.addCouple(girl.boyfriend,girl);
    }
  }

  print("Couples Formed");

  coupleList.printCouples();
  coupleList.performGifting(giftList);

  print("Gifting Complete");
  print("Enter K");
  int k = int.parse(stdin.readLineSync());

  coupleList.printMostCompatible(k);
  coupleList.printMostHappy(k);

  print("Performing Breakup");

  coupleList.performBreakup(k,boyList);
  
  coupleList.printMostCompatible(k);
  coupleList.printMostCompatible(k);

}