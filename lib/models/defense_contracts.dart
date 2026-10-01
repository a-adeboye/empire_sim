enum DefenseSubSector {
  militaryJets,
  hypersonicMissiles,
  autonomousDrones,
  armoredVehicles,
  militarySatelliteComms,
}

class DefenseContract {
  final String id;
  final String title;
  final String issuingCountryId;
  final DefenseSubSector subSector;
  final double totalValueUsd;
  final int durationYears;
  
  // Qualification Thresholds
  final int requiredTechTier;          // 1 to 10
  final int requiredSecurityClearance; // 1 (Confidential) to 5 (Top Secret)
  final double requiredMinCapacity;    // Manufacturing units required per year

  // State Tracking
  int yearsRemaining;
  double annualPayout;
  bool isSecured;

  DefenseContract({
    required this.id,
    required this.title,
    required this.issuingCountryId,
    required this.subSector,
    required this.totalValueUsd,
    required this.durationYears,
    required this.requiredTechTier,
    required this.requiredSecurityClearance,
    required this.requiredMinCapacity,
    this.isSecured = false,
  })  : yearsRemaining = durationYears,
        annualPayout = totalValueUsd / durationYears;
}

/// Extends standard Robotics & Auto-Manufacturing companies with defense capability attributes.
class DefenseCapabilities {
  int securityClearanceLevel; // 1 to 5
  int rAndDTechTier;          // 1 to 10
  double manufacturingCapacity; // Units per year
  double governmentLobbyingPower; // 0.0 to 100.0 (Influence with Defense Depts)
  bool maintainsMilitaryDivision;

  DefenseCapabilities({
    this.securityClearanceLevel = 1,
    this.rAndDTechTier = 1,
    this.manufacturingCapacity = 100.0,
    this.governmentLobbyingPower = 10.0,
    this.maintainsMilitaryDivision = false,
  });
}