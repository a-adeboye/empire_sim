import 'dart:math';
import '../models/business.dart';
import '../models/defense_contracts.dart';

class DefenseExecutionEngine {
  /// Processes active contracts during the annual simulation tick
  static void processAnnualDefenseContracts({
    required Company company,
    required List<DefenseContract> activeContracts,
    required Random prng,
    required Function(String headline, String message) onScandalTriggered,
  }) {
    activeContracts.removeWhere((contract) => contract.yearsRemaining <= 0);

    for (var contract in activeContracts) {
      // 1. Financial Distribution
      double annualRevenue = contract.annualPayout;
      company.annualRevenue += annualRevenue;

      // 2. Technical Risk: Cost Overrun Check (10% base chance)
      if (prng.nextDouble() < 0.10) {
        double costOverrun = annualRevenue * 0.25;
        company.marketValue -= costOverrun; // Margin penalty
      }

      // 3. Systemic Backlash / Geopolitical Friction
      if (contract.subSector == DefenseSubSector.hypersonicMissiles ||
          contract.subSector == DefenseSubSector.militaryJets) {
        
        // High visibility defense work degrades public consumer brand reputation slightly
        company.profitMargin *= 0.99; 

        // 5% chance per year of anti-war/defense controversy scandal
        if (prng.nextDouble() < 0.05) {
          onScandalTriggered(
            "Public Backlash: Defense Operations",
            "${company.name}'s active contract for ${contract.title} has sparked public protests, lowering founder reputation."
          );
        }
      }

      // Decrement contract duration
      contract.yearsRemaining -= 1;
    }
  }
}