# PPL Assignment
PPL Assignment by Pranjal Paliwal (RIT2015015)

## Setting up dartlang on your system

* ArchLinux : Install using AUR
      `yaourt dart`
* Ubuntu linux: Follow Guide here: https://www.dartlang.org/install/linux
* Windows: Install using Chocolatey Package Manager: `cinst dart-sdk`
* macOS: Install using Homebrew: 
  ```
  $ brew tap dart-lang/dart
  $ brew install dart
  ```
  
## Tested on
1. Windows 10. 
2. macOS El Capitan
3. Arch Linux (Bleeding Edge)
4. Ubuntu 16.10

## Documentation
Documentation is generated using dartdoc (https://github.com/dart-lang/dartdoc)

It is live on Github Pages and can be viewed here:
https://ppl-iiita.github.io/ppl-assignment-betterclever/

To generate documentation for project
- navigate to project root
- run `dartdoc`
- documentation will be available in `doc` folder in the project root

## Class Diagram
Class Diagram is available in the root of the project as `ClassDiagram.png`

## Running the Project
  
### Setting Up
1. Clone the project.
2. Navigate to project root.
3. Run `pub get`

### Generating Random Input in csv Files
1. Run `dart bin/generateItemCSV.dart <boycount> <girlcount> <giftcount>`

### Third Question
1. Run `dart bin/third.dart <girlcount> <boycount>`

### Fourth Question
1. Run `dart bin/fourth.dart <girlcount> <boycount>`

### Fifth Question
1. Run `dart bin/fifth.dart <girlcount> <boycount>`

### Sixth Question
1. Run `dart bin/sixth.dart <girlcount> <boycount>`

### Seventh Question
1. Run `dart bin/seventh.dart <girlcount> <boycount>`

### Eighth Question
1. Run `dart bin/eighth.dart <girlcount> <boycount>`

### Ninth Question
1. Run `dart bin/ninth.dart <girlcount> <boycount>`

### Tenth Question
1. Run `dart bin/tenth.dart <girlcount> <boycount>`

## External Libraries Used
* dart-sdk standard libraries
* CSV parsing library:  https://pub.dartlang.org/packages/csv

