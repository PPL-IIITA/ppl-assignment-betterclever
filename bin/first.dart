import 'package:ValentinesDay/Util.dart';
import 'package:ValentinesDay/model/Boy.dart';
import 'package:ValentinesDay/model/Couple.dart';
import 'package:ValentinesDay/model/Girl.dart';

main(List<String> arg){

  if(arg.length < 2){
    print("Enter 2 arguments: girlCount, boyCount");
    return;
  }
  
  List<Girl> girlList = Utils.getGirls(int.parse(arg[0]));
  List<Boy> boyList = Utils.getBoys(int.parse(arg[1]));

  CoupleList coupleList = new CoupleList();

  for(Girl girl in girlList){
    girl.assignBoyfriend(boyList);
    if(girl.isCommitted()){
      coupleList.addCouple(girl.boyfriend,girl);
    }
  }

  print("Couples Formed");
  coupleList.printCouples();

}