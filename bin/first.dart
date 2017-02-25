import 'package:ValentinesDay/Util.dart';
import 'package:ValentinesDay/model/Boy.dart';
import 'package:ValentinesDay/model/Girl.dart';

main(List<String> arg){

  if(arg.length < 2){
    print("Enter 2 arguments: girlCount, boyCount");
    return;
  }
  
  List<Girl> girlList = Utils.getGirls(int.parse(arg[0]));
  List<Boy> boyList = Utils.getBoys(int.parse(arg[1]));

  for(Girl girl in girlList){
    girl.assignBoyfriend(boyList);
  }

  print("Couples Formed");

  for(Girl girl in girlList){
    if(girl.isCommitted()){
      print("Girl: " + girl.name + " Boy: " + girl.boyfriend.name );
    }
  }
}