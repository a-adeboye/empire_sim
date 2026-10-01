import '../models/entities.dart';
import '../models/business.dart';

class WealthEngine {
  /// Recursively calculates the true economic value a person holds across 
  /// a web of shell companies, subsidiaries, and trusts.
  static double calculateBeneficialWealth(LegalEntity target, List<Asset> worldAssets) {
    double totalWealth = 0.0;

    for (var asset in worldAssets) {
      double effectiveInterest = _traceEconomicInterest(target, asset, worldAssets, 1.0, <String>{});
      totalWealth += (asset.marketValue * effectiveInterest);
    }
    return totalWealth;
  }

  static double _traceEconomicInterest(
      LegalEntity target, 
      Asset currentAsset, 
      List<Asset> allAssets, 
      double currentMultiplier,
      Set<String> visitedIds) {
      
    // Prevent infinite loops in circular corporate ownership (A owns B, B owns A)
    if (visitedIds.contains(currentAsset.id)) return 0.0;
    visitedIds.add(currentAsset.id);

    double targetInterest = 0.0;

    for (var stake in currentAsset.capTable) {
      if (stake.owner.id == target.id) {
        // Direct match found
        targetInterest += stake.economicPercent * currentMultiplier;
      } 
      else if (stake.owner is Trust) {
        // Trace through Trust beneficiaries
        var trust = stake.owner as Trust;
        for (var ben in trust.beneficiaries) {
          if (ben.entity.id == target.id) {
            targetInterest += (stake.economicPercent * ben.economicInterest) * currentMultiplier;
          }
        }
      }
      else if (stake.owner is Company) {
        // Recursively trace up through the holding company parent
        targetInterest += _traceEconomicInterest(
            target, 
            stake.owner as Company, 
            allAssets, 
            currentMultiplier * stake.economicPercent,
            Set.from(visitedIds) // Pass a copy of the visited tree
        );
      }
    }
    return targetInterest;
  }
}