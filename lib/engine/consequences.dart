import '../models/state.dart';
import '../models/management.dart';
import '../models/business.dart';

class FireExecutiveCommand {
  final Company targetCompany;
  final Officer targetOfficer;

  FireExecutiveCommand(this.targetCompany, this.targetOfficer);

  void execute(WorldState state) {
    // 1. Verify Chairman Authority
    // (Assume governance is attached to targetCompany)
    
    // 2. Direct Consequence: Remove the officer
    // targetCompany.governance.hiredCEO = null;

    // 3. Systemic Consequence A: Severance & Market Shock
    double severanceCost = targetCompany.marketValue * 0.001;
    targetCompany.marketValue -= severanceCost;
    
    // 4. Systemic Consequence B: Institutional memory loss drops efficiency briefly
    targetCompany.profitMargin *= 0.85;

    // 5. Systemic Consequence C: Relationship Engine
    // targetOfficer.person.relationshipToPlayer.trust = 0;
    // targetOfficer.person.relationshipToPlayer.resentment += 50;

    // 6. Push a historic memory for generational tracking
    // state.addMemory("Fired ${targetOfficer.person.name} from ${targetCompany.name} in ${state.year}");
  }
}