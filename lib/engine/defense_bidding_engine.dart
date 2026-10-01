import 'dart:math';
import '../models/business.dart';
import '../models/defense_contracts.dart';
import '../models/state.dart';

class BidSubmission {
  final Company biddingCompany;
  final DefenseCapabilities capabilities;
  final double proposedCostDiscount; // 0.0 (Full Price) to 0.30 (30% Discount)

  BidSubmission({
    required this.biddingCompany,
    required this.capabilities,
    this.proposedCostDiscount = 0.0,
  });
}

class DefenseBiddingEngine {
  /// Evaluates all submitted bids deterministically for a single tender offer.
  static Company? evaluateAndAwardContract({
    required DefenseContract tender,
    required List<BidSubmission> bids,
    required int worldSeed,
    required int currentYear,
  }) {
    if (bids.isEmpty) return null;

    BidSubmission? winningBid;
    double highestScore = -1.0;

    // Seeded PRNG for deterministic selection across re-simulations
    final random = Random(worldSeed + currentYear + tender.id.hashCode);

    for (var bid in bids) {
      // 1. Hard Prerequisite Checks
      if (bid.capabilities.securityClearanceLevel < tender.requiredSecurityClearance) {
        continue; // Disqualified: Clearance too low
      }
      if (bid.capabilities.rAndDTechTier < tender.requiredTechTier) {
        continue; // Disqualified: Insufficient R&D Tech Tier
      }
      if (bid.capabilities.manufacturingCapacity < tender.requiredMinCapacity) {
        continue; // Disqualified: Factory capacity insufficient
      }

      // 2. Score Calculation Strategy
      // Score = Tech Advantage + Political Leverage + Price Competitiveness + Risk Factor
      double techScore = (bid.capabilities.rAndDTechTier - tender.requiredTechTier) * 15.0;
      double influenceScore = bid.capabilities.governmentLobbyingPower * 0.40;
      double priceScore = bid.proposedCostDiscount * 100.0; // Higher discount gives competitive edge
      double stochasticFactor = random.nextDouble() * 10.0;  // Random political shift

      double totalScore = techScore + influenceScore + priceScore + stochasticFactor;

      if (totalScore > highestScore) {
        highestScore = totalScore;
        winningBid = bid;
      }
    }

    if (winningBid != null) {
      tender.isSecured = true;
      return winningBid.biddingCompany;
    }

    return null; // Tender unawarded if no candidate qualified
  }
}