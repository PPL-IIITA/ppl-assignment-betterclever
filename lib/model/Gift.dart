class Gift {
  double price;
  double value;

  String type ;

  int difficultyToObtain;
  int luxuryRating;

  double utilityValue;
  String utilityClass;

  Gift.newEssential(this.price,this.value):
        type = "Essential";

  Gift.newLuxury(this.price,this.value,this.difficultyToObtain,this.luxuryRating):
        type = "Luxury";

  Gift.newUtility(this.price,this.value,this.utilityValue,this.utilityClass):
        type = "Utility";
}