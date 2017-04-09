import 'dart:io';
import 'package:ValentinesDay/BoySearch.dart';
import 'package:ValentinesDay/Util.dart';
import 'package:ValentinesDay/model/Boy.dart';
import 'package:ValentinesDay/model/Couple.dart';
import 'package:ValentinesDay/model/Girl.dart';
import 'package:ValentinesDay/Algorithm.dart' as Algorithm;

main(List<String> arg) {
  if (arg.length < 2) {
    print("Enter 2 arguments: girlCount, boyCount");
    return;
  }

  List<Girl> girlList = Utils.getGirls(int.parse(arg[0]));
  List<Boy> boyList = Utils.getBoys(int.parse(arg[1]));

  CoupleList coupleList = Algorithm.makeCouples1(boyList, girlList);

  print("Couples Formed");
  coupleList.printCouples();

  List<String> boysToSearch = Utils.getRandomBoyNames(30);

  print("Interested in making algorithm choice: (Y/N)");
  String reply = stdin.readLineSync();
  int choice = 1;
  if (reply.startsWith('Y')) {
    print("Enter Choice: 1: LinearSearch 2: BinarySearch 3: Hash Table");
    choice = int.parse(stdin.readLineSync());
  }
  BoySearch boySearch;
  switch (choice) {
    case 1:
      boySearch = new LinearBoySearch(boyList);
      break;
    case 2:
      boySearch = new BinaryBoySearch(boyList);
      break;
    case 3:
      boySearch = new HashBoySearch(boyList);
      break;
    default:
      boySearch = new LinearBoySearch(boyList);
  }

  for (String boyName in boysToSearch) {
    boySearch.searchForBoy(boyName);
  }
}
