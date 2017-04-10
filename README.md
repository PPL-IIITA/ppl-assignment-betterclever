# PPL Assignment
PPL Assignment by Pranjal Paliwal (RIT2015015)

## Documentation
Documnetation is generated using dartdoc (https://github.com/dart-lang/dartdoc)

It is live on Github Pages and can be viewed here: 
https://ppl-iiita.github.io/ppl-assignment-betterclever/

## Setting up dartlang on your system

* ArchLinux : Install using AUR
      `yaourt dart`
* Ubuntu linux: Follow Guide here: https://www.dartlang.org/install/linux
* Windows: Install using Chocolatey Package Manager: `cinst dart-sdk`
* macOS: Install using Homebrew: 
  ```
  $ brew tap dart-lang/dart`  
  $ brew install dart
  ```
  
## Tested on
1. Windows 10. 
2. macOS El Capitan
3. Arch Linux (Bleeding Edge)
4. Ubuntu 16.10
  
## Running the Project
  
### Setting Up
1. Clone the project.
2. Navigate to project root.
3. Run `pub get`

### Generating Random Input in csv Files
1. Navigate to bin directory.
2. Run `dart generateItemCSV.dart <boycount> <girlcount> <giftcount>`

### First Question
1. Navigate to bin directory.
2. Run `dart first.dart <girlcount> <boycount>`

### Second Question
1. Navigate to bin directory.
2. Run `dart second.dart <girlcount> <boycount>` 

## Question 3 - 10
Switch to branch named "second-part" using `git checkout second-part` and see README.md

## External Libraries Used
* dart-sdk standard libraries
* CSV parsing library:  https://pub.dartlang.org/packages/csv

