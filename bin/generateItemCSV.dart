import 'package:ValentinesDay/Util.dart';

main(List<String> arguments){

  if(arguments.length < 3){
    print('Error 3 arguments expected');
    print('Enter 3 arguments: boysCount, girlsCount, giftsCount');
    return;
  }

  TestingUtils.storeBoysInCSV(int.parse(arguments[0]));
  TestingUtils.storeGirlsInCSV(int.parse(arguments[1]));
  TestingUtils.storeGiftsInCSV(int.parse(arguments[2]));

  print('csv files generated successfully');
}
