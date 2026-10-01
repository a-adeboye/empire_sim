enum BusinessType {
  engineering, law, cafe, airways, oilRefinery, aiDeepTech, saas, 
  fashion, casino, gameStudio, semiconductors, roboticsDefense, telecom, autoManufacturing
}

class Company {
  String name;
  BusinessType type;
  bool isPublic; // Enables IPO mechanics
  // ... other properties from previous codebase

  Company(this.name, this.type, {this.isPublic = false});
}

class FormBusinessCommand {
  final BusinessType type;
  final String name;

  FormBusinessCommand(this.type, this.name);

  void execute(dynamic state) {
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

  void execute(dynamic state) {
    if (company.isPublic) throw Exception("Already public.");
    if (company.marketValue < 50000000) throw Exception("Company is too small for an IPO.");
    
    company.isPublic = true;
    state.playerCash += company.marketValue * 0.20; // Float 20% of shares for cash
    state.player.status += 10; // Boost prestige
  }
}