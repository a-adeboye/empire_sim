import 'entities.dart';
import 'business.dart';

enum ExecutiveRole { ceo, cfo, coo, chairman }

class Officer {
  final Person person;
  final ExecutiveRole role;
  final double competence; // 0.0 to 1.0, affects company performance
  final double loyalty;    // 0.0 to 1.0, affects scandal/embezzlement chance

  Officer(this.person, this.role, this.competence, this.loyalty);
}

class GovernanceStructure {
  Person chairman;
  Officer? hiredCEO;
  List<Person> boardMembers;
  
  GovernanceStructure({required this.chairman, this.hiredCEO, required this.boardMembers});
  
  bool get isPlayerRunDayToDay => hiredCEO == null || hiredCEO!.person.id == chairman.id;

  // The Chairman has the final say in major commands (acquisitions, liquidations)
  void executeChairmanVeto(Person actor) {
    if (actor.id != chairman.id) {
      throw Exception("Only the Chairman can authorize this board action.");
    }
  }
}