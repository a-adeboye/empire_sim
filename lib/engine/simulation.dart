import '../models/state.dart';

// The Base Command Protocol
abstract class Command {
  void execute(WorldState state);
}

// Example Command: Opening a Bank Account (Enforcing your 2 Bank / 3 Fintech rule)
class OpenAccountCommand implements Command {
  final String bankName;
  final AccountType type;

  OpenAccountCommand(this.bankName, this.type);

  @override
  void execute(WorldState state) {
    int traditionalCount = state.banks.where((b) => b.type == AccountType.traditional).length;
    int fintechCount = state.banks.where((b) => b.type == AccountType.fintech).length;

    if (type == AccountType.traditional && traditionalCount >= 2) {
      throw Exception("Maximum traditional bank limit reached.");
    }
    if (type == AccountType.fintech && fintechCount >= 3) {
      throw Exception("Maximum fintech limit reached.");
    }

    state.banks.add(BankAccount(bankName, type, 0.0));
  }
}

// The Master Engine
class SimulationEngine {
  late WorldState currentState;

  SimulationEngine() {
    // Initialization / World Seed
    currentState = WorldState(
      year: 2026,
      player: PlayerCharacter(name: "Alexander Adebayo", age: 18, country: "Nigeria"),
      banks: [],
    );
  }

  // The Master Simulation Equation (S_t+1)
  void tick() {
    currentState.year += 1;
    currentState.player.age += 1;
    
    // 1. Process Economy changes
    // 2. Process NPC Decisions
    // 3. Process Random Events (Health decay, etc.)
    currentState.player.health -= 1; 

    // Calculate total net worth for this tick
  }

  void processAction(Command command) {
    try {
      command.execute(currentState);
      // Trigger UI update
    } catch (e) {
      print("Action failed: ${e.toString()}");
    }
  }

  double getTotalNetWorth() {
    return currentState.banks.fold(0, (sum, account) => sum + account.balance);
  }
}