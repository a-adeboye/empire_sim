import 'entities.dart';

enum Visibility { public, private, hidden }

class OwnershipStake {
  final LegalEntity owner;       // The entity holding this specific stake
  final double legalPercent;     // What is on the public registry
  final double economicPercent;  // Right to dividends and sale profits
  final double votingPercent;    // Right to make operational decisions
  final Visibility visibility;

  OwnershipStake({
    required this.owner,
    required this.legalPercent,
    required this.economicPercent,
    required this.votingPercent,
    this.visibility = Visibility.public,
  });
}