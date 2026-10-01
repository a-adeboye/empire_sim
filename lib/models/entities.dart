import 'ownership.dart';

abstract class LegalEntity {
  String id;
  String name;
  String taxJurisdiction;

  LegalEntity(this.id, this.name, this.taxJurisdiction);
}

class Person extends LegalEntity {
  int age;
  Person(String id, String name, String jurisdiction, this.age) 
      : super(id, name, jurisdiction);
}

class Beneficiary {
  LegalEntity entity;
  double economicInterest; // Percentage of trust distributions
  Beneficiary(this.entity, this.economicInterest);
}

class Trust extends LegalEntity {
  LegalEntity trustee; // The manager (Player, Lawyer NPC, or Bank)
  List<Beneficiary> beneficiaries; 
  
  Trust(String id, String name, String jurisdiction, this.trustee, this.beneficiaries)
      : super(id, name, jurisdiction);
}

abstract class Asset {
  String id;
  String name;
  double marketValue;
  List<OwnershipStake> capTable; // The capitalization table (who owns what)

  Asset(this.id, this.name, this.marketValue, this.capTable);
}