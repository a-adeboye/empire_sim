import 'entities.dart';

class WorldState {
  int year;
  int worldSeed;
  PlayerCharacter player;
  List<BankAccount> banks;
  
  // New properties required by the engine commands
  List<Asset> worldAssets; 
  List<dynamic> activeDefenseContracts; // Assuming DefenseContract is imported
  double playerCash;
  dynamic activeCurrency; // Assuming Currency enum from geopolitics

  WorldState({
    required this.year,
    required this.worldSeed,
    required this.player,
    required this.banks,
    this.worldAssets = const [],
    this.activeDefenseContracts = const [],
    this.playerCash = 0.0,
    this.activeCurrency,
  });
}

class PlayerCharacter {
  String name;
  int age;
  String country;
  
  int health;
  int happiness;
  int intelligence;
  int status;
  int influence;

  // Added to support business and career prerequisites
  List<String> degrees;
  List<String> licenses;

  PlayerCharacter({
    required this.name,
    required this.age,
    required this.country,
    this.health = 100,
    this.happiness = 80,
    this.intelligence = 85,
    this.status = 10,
    this.influence = 5,
    this.degrees = const [],
    this.licenses = const [],
  });

  // The missing methods required by the Business Engine
  bool hasDegree(String degreeName) {
    return degrees.contains(degreeName);
  }

  bool hasLicense(String licenseName) {
    return licenses.contains(licenseName);
  }
}

enum AccountType { traditional, fintech }

class BankAccount {
  String institutionName;
  AccountType type;
  double balance;

  BankAccount(this.institutionName, this.type, this.balance);
}