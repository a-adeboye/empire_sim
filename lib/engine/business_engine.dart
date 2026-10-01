import '../models/state.dart';
import '../models/business.dart';

class FormBusinessCommand {
  final BusinessType type;
  final String name;

  FormBusinessCommand(this.type, this.name);

  void execute(WorldState state) { // Changed from dynamic to WorldState
    // Enforcement of Licenses and Degrees
    if (type == BusinessType.engineering && !state.player.hasDegree("Engineering")) {
      throw Exception("You must hold an Engineering degree to start this firm.");
    }
    if (type == BusinessType.law && !state.player.hasLicense("Law")) {
      throw Exception("You must pass the Bar Exam and hold a Law license.");
    }
    
    // AutoManufacturing and Robotics unlock Defense sub-sectors later in the UI
    // Creates the company and deducts startup capital...
  }
}

class IPOCommand {
  final Company company;
  IPOCommand(this.company);

  void execute(WorldState state) { // Changed from dynamic to WorldState
    if (company.isPublic) throw Exception("Already public.");
    if (company.marketValue < 50000000) throw Exception("Company is too small for an IPO.");
    
    company.isPublic = true;
    state.playerCash += company.marketValue * 0.20; // Float 20% of shares for cash
    state.player.status += 10; // Boost prestige
  }
}