import 'ownership.dart';
import 'entities.dart';

class Company extends LegalEntity implements Asset {
  @override
  double marketValue;
  
  @override
  List<OwnershipStake> capTable;
  
  String industrySector;
  double annualRevenue;
  double profitMargin;
  int employees;

  Company({
    required String id,
    required String name,
    required String jurisdiction,
    required this.marketValue,
    required this.capTable,
    required this.industrySector,
    this.annualRevenue = 0.0,
    this.profitMargin = 0.0,
    this.employees = 0,
  }) : super(id, name, jurisdiction);
}