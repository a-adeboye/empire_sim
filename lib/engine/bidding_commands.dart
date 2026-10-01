import '../models/business.dart';
import '../models/defense_contracts.dart';
import '../models/state.dart';

class BidForDefenseContractCommand {
  final Company company;
  final DefenseCapabilities defenseCapabilities;
  final DefenseContract tender;
  final double discountOffered;

  BidForDefenseContractCommand({
    required this.company,
    required this.defenseCapabilities,
    required this.tender,
    this.discountOffered = 0.0,
  });

  void execute(WorldState state) { // Changed from dynamic to WorldState
    // 1. Verify Company Sector Legitimacy
    bool isEligibleSector = company.type == BusinessType.roboticsDefense || 
                           company.type == BusinessType.autoManufacturing;

    if (!isEligibleSector) {
      throw Exception("Only Robotics & Defense or Auto-Manufacturing firms can bid on military hardware contracts.");
    }

    if (!defenseCapabilities.maintainsMilitaryDivision) {
      throw Exception("You must establish a certified Defense & Security division inside this enterprise first.");
    }

    // 2. Create Bid Submission
    var submission = BidSubmission(
      biddingCompany: company,
      capabilities: defenseCapabilities,
      proposedCostDiscount: discountOffered,
    );

    // 3. Pass to Engine
    Company? winner = DefenseBiddingEngine.evaluateAndAwardContract(
      tender: tender,
      bids: [submission], // Evaluated alongside competitor NPC bids in state
      worldSeed: state.worldSeed,
      currentYear: state.year,
    );

    if (winner?.id == company.id) {
      state.activeDefenseContracts.add(tender);
      state.player.status += 8; // Winning government contracts raises national standing
    } else {
      throw Exception("Your bid was rejected by the Department of Defense in favor of a competitor.");
    }
  }
}