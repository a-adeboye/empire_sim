import 'dart:math';

class WorldState {
  int year;
  PlayerCharacter player;
  List<BankAccount> banks;
  // Future expansions: Economy, NPCs, Estates

  WorldState({required this.year, required this.player, required this.banks});
}

class PlayerCharacter {
  String name;
  int age;
  String country;
  
  // Core Stats
  int health;
  int happiness;
  int intelligence;
  int status;
  int influence;

  PlayerCharacter({
    required this.name,
    required this.age,
    required this.country,
    this.health = 100,
    this.happiness = 80,
    this.intelligence = 85,
    this.status = 10,
    this.influence = 5,
  });
}

enum AccountType { traditional, fintech }

class BankAccount {
  String institutionName;
  AccountType type;
  double balance;

  BankAccount(this.institutionName, this.type, this.balance);
}