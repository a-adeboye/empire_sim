import 'entities.dart';
import 'ownership.dart';

enum BusinessType {
  engineering, law, cafe, airways, oilRefinery, aiDeepTech, saas, 
  fashion, casino, gameStudio, semiconductors, roboticsDefense, telecom, autoManufacturing, holdingAndInvestment
}

class Company extends LegalEntity implements Asset {
  @override
  double marketValue;
  
  @override
  List<OwnershipStake> capTable;
  
  BusinessType type;
  String industrySector;
  double annualRevenue;
  double profitMargin;
  int employees;
  bool isPublic; // Enables IPO mechanics

  Company({
    required String id,
    required String name,
    required String jurisdiction,
    required this.marketValue,
    required this.capTable,
    required this.type,
    required this.industrySector,
    this.annualRevenue = 0.0,
    this.profitMargin = 0.0,
    this.employees = 0,
    this.isPublic = false,
  }) : super(id, name, jurisdiction);
}