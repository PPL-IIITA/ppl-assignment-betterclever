/// This module contains class to represent a person
library Person;

/// Class to represent a Person
abstract class Person {

  /// Name of Person
  String name;
  /// Attractiveness of Person on scale of 1-10
  int attractiveness;
  /// Intelligence of Person on scale of 1-10
  int intelligence;

  /// Constructor to initialize a Person
  Person(this.name, this.attractiveness, this.intelligence);

}