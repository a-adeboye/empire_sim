import '../models/entities.dart';
import '../models/business.dart';
import '../models/ownership.dart';
// Assuming WorldState from previous architecture is imported

abstract class Command {
  void execute(dynamic state); // dynamic used here as placeholder for WorldState
}

class FormHoldingCompanyCommand implements Command {
  final Person founder;
  final String companyName;
  final String jurisdiction;
  final double initialCapital;

  FormHoldingCompanyCommand(this.founder, this.companyName, this.jurisdiction, this.initialCapital);

  @override
  void execute(dynamic state) {
    // 1. Enforce the 10-Business Limit
    int controlledBusinesses = state.worldAssets.whereType<Company>().where((company) {
      var playerStake = company.capTable.firstWhere(
        (stake) => stake.owner.id == founder.id, 
        orElse: () => OwnershipStake(owner: founder, legalPercent: 0, economicPercent: 0, votingPercent: 0)
      );
      // You only "directly control" it if your direct voting power is > 50%
      return playerStake.votingPercent > 0.5;
    }).length;

    if (controlledBusinesses >= 10) {
      throw Exception("You have reached the maximum limit of 10 directly controlled conglomerates.");
    }

    // 2. Execute Financial Transfer
    if (state.playerCash < initialCapital) throw Exception("Insufficient funds.");
    state.playerCash -= initialCapital;

    // 3. Register the new entity in the world
    var newCompany = Company(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: companyName,
      jurisdiction: jurisdiction,
      marketValue: initialCapital,
      industrySector: "Holding & Investment",
      capTable: [
        OwnershipStake(
          owner: founder,
          legalPercent: 1.0,
          economicPercent: 1.0,
          votingPercent: 1.0,
          visibility: Visibility.public,
        )
      ],
    );

    state.worldAssets.add(newCompany);
  }
}