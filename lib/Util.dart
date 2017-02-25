import 'dart:io';
import 'dart:math' as Math;
import 'package:ValentinesDay/model/Boy.dart';
import 'package:ValentinesDay/model/Gift.dart';
import 'package:ValentinesDay/model/Girl.dart';
import 'package:csv/csv.dart';

String _boysFileName = "../generated_csv/boys.csv";
String _girlsFileName = "../generated_csv/girls.csv";
String _giftsFileName = "../generated_csv/gifts.csv";

class TestingUtils {

  static storeBoysInCSV(int num){

    var rand = new Math.Random();
    List<List<dynamic>> list = new List<List<dynamic>>();

    while(num-- > 0) {

      String name = _randomString(10);
      String type;
      int attractiveness = 1+rand.nextInt(10);
      int intelligenceLevel = 1+rand.nextInt(10);
      int minAttractivenesReq = 1+rand.nextInt(3);
      double budget = 100 + rand.nextDouble()*9000;

      switch (rand.nextInt(3)) {
        case 0:
          type = "Miser";
          break;
        case 1:
          type = "Generous";
          break;
        case 2:
          type = "Geek";
          break;
      }

      //Boy b = new Boy(name,type,attractiveness,intelligenceLevel,budget);
      list.add([name,type,attractiveness,minAttractivenesReq,intelligenceLevel,budget]);
    }

    String csv = const ListToCsvConverter().convert(list);

    File file = new File(_boysFileName);
    file.writeAsStringSync(csv);

  }

  static storeGirlsInCSV(int num){
    var rand = new Math.Random();
    List<List<dynamic>> list = new List<List<dynamic>>();

    while(num-- > 0) {

      String name = _randomString(10);
      String type;
      int attractiveness = 1+rand.nextInt(10);
      int intelligenceLevel = 1+rand.nextInt(10);
      double maintenanceBudget = 100 + rand.nextDouble()*9000;

      switch (rand.nextInt(3)) {
        case 0:
          type = "Choosy";
          break;
        case 1:
          type = "Normal";
          break;
        case 2:
          type = "Desperate";
          break;
      }

      list.add([name,type,attractiveness,intelligenceLevel,maintenanceBudget]);
    }

    String csv = const ListToCsvConverter().convert(list);

    File file = new File(_girlsFileName);
    file.writeAsStringSync(csv);
  }

  static storeGiftsInCSV(int num){
    var rand = new Math.Random();
    List<List<dynamic>> list = new List<List<dynamic>>();

    while(num-- > 0) {

      double price = 10 + rand.nextDouble()*900;
      double value = 10 + rand.nextDouble()*900;

      String type;

      switch (rand.nextInt(3)) {
        case 0:
          type = "Essential";
          break;
        case 1:
          type = "Luxury";
          break;
        case 2:
          type = "Utility";
          break;
      }

      if(type == "Essential"){
        list.add([type,price,value]);
      }
      else if(type == "Luxury"){
        int difficultyToObtain = 1 + rand.nextInt(10);
        int luxuryRating = 1 + rand.nextInt(10);
        list.add([type,price,value,difficultyToObtain,luxuryRating]);
      }
      else {
        double utilityValue = rand.nextDouble()*100;
        String utilityClass = rand.nextInt(2) == 1 ? "Extreme" : "Somewhat";
        list.add([type,price,value,utilityValue,utilityClass]);
      }

    }

    String csv = const ListToCsvConverter().convert(list);

    File file = new File(_giftsFileName);
    file.writeAsStringSync(csv);
  }

  static String _randomString(int length) {
    var rand = new Math.Random();
    var codeUnits = new List.generate(
        length,
            (index){
          return rand.nextInt(26)+97;
        }
    );

    return new String.fromCharCodes(codeUnits);
  }

}

class Utils{

  static List<Girl> getGirls(int count){

    List<Girl> girlList = new List<Girl>();
    File girlsCsvFile = new File(_girlsFileName);

    String csvString = girlsCsvFile.readAsStringSync();
    List<List<dynamic>> rowsAsListOfValues = const CsvToListConverter().convert(csvString);

    assert (rowsAsListOfValues.length >= count);

    for(int i=0;i<count;i++){
      List<dynamic> values = rowsAsListOfValues[i];
      Girl girl = new Girl(values[0],values[1],values[2],values[3],values[4]);
      girlList.add(girl);
    }

    return girlList;
  }

  static List<Boy> getBoys(int count){

    List<Boy> boyList = new List<Boy>();
    File BoysCsvFile = new File(_boysFileName);

    String csvString = BoysCsvFile.readAsStringSync();
    List<List> rowsAsListOfValues = const CsvToListConverter().convert(csvString);

    assert (rowsAsListOfValues.length >= count);

    for(int i=0;i<count;i++){
      List values = rowsAsListOfValues[i];
      Boy boy = new Boy(values[0],values[1],values[2],values[3],values[4],values[5]);
      boyList.add(boy);
    }

    return boyList;
  }

  static List<Gift> getGifts(){

    List giftList = new List<Gift>();
    File giftCSVFile = new File(_giftsFileName);

    String csvString = giftCSVFile.readAsStringSync();
    List<List> rowsAsListOfValues = const CsvToListConverter().convert(csvString);

    for(List values in rowsAsListOfValues ){

      Gift gift ;

      /// Decides the type: Essential, Luxury, Utility
      switch(values[0]){
        case "Utility": gift = new Gift.newUtility(values[1],values[2],values[3],values[4]);
        break;
        case "Essential": gift = new Gift.newEssential(values[1],values[2]);
        break;
        case "Luxury": gift = new Gift.newLuxury(values[1],values[2],values[3],values[4]);
        break;
      }

      giftList.add(gift);
    }
    return giftList;
  }

  static List<Boy> getCommittedBoys(List<Boy> boyList){
    List<Boy> committedBoys = new List<Boy>();
    for(Boy boy in boyList){
      if(boy.girlfriend!=null){
        committedBoys.add(boy);
      }
    }
    return committedBoys;
  }



}