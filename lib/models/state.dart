import 'entities.dart';
import 'defense_contracts.dart';
import 'geopolitics.dart';

class WorldState {
  int year;
  int worldSeed;
  PlayerCharacter player;
  List<BankAccount> banks;
  
  List<Asset> worldAssets; 
  List<DefenseContract> activeDefenseContracts; // Replaced dynamic
  double playerCash;
  Currency? activeCurrency; // Replaced dynamic

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