import 'dart:math';
import '../models/business.dart';
import '../models/state.dart'; // Assume WorldState is imported

// 1. Define the Event Data Structure
class GameEvent {
  final String id;
  final String title;
  final String description;
  final double baseProbability;
  final bool Function(WorldState) condition;
  final void Function(WorldState, Random) applyConsequences;

  GameEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.baseProbability,
    required this.condition,
    required this.applyConsequences,
  });
}

// 2. The Deterministic Engine
class EventEngine {
  final int worldSeed;
  late Random _prng;
  
  // Library of all possible events
  final List<GameEvent> _eventLibrary = [];

  EventEngine(this.worldSeed) {
    _registerEvents();
  }

  void processAnnualEvents(WorldState state) {
    // Re-seed the PRNG specific to this exact year to guarantee determinism
    _prng = Random(worldSeed + state.year);

    for (var event in _eventLibrary) {
      if (event.condition(state)) {
        // Roll against the probability
        if (_prng.nextDouble() <= event.baseProbability) {
          _triggerEvent(event, state);
        }
      }
    }
  }

  void _triggerEvent(GameEvent event, WorldState state) {
    print("EVENT FIRED: ${event.title}");
    event.applyConsequences(state, _prng);
  }

  void _registerEvents() {
    // Event A: Major Oil Discovery
    _eventLibrary.add(GameEvent(
      id: "oil_discovery_major",
      title: "Major Offshore Oil Discovery",
      description: "One of your energy subsidiaries has struck a massive offshore reserve.",
      baseProbability: 0.05,
      condition: (state) {
        // Only valid if the player owns an active energy company
        return state.worldAssets.whereType<Company>().any((c) => c.industrySector == "Energy");
      },
      applyConsequences: (state, random) {
        var energyCo = state.worldAssets.whereType<Company>().firstWhere((c) => c.industrySector == "Energy");
        
        // Value spikes between 40% and 120% deterministically
        double growthFactor = 1.4 + (random.nextDouble() * 0.8);
        energyCo.marketValue *= growthFactor;
        
        // Triggers massive media attention, increasing player status but lowering privacy
        state.player.status += 15;
      }
    ));

    // Event B: Hired CEO Scandal
    _eventLibrary.add(GameEvent(
      id: "ceo_embezzlement_scandal",
      title: "Executive Embezzlement",
      description: "The CEO of your holding company has been caught embezzling funds.",
      baseProbability: 0.02,
      condition: (state) {
        // Only triggers if you have a hired CEO whose loyalty is below 40%
        // (Assuming you linked GovernanceStructure to Company)
        return true; // Simplified for boilerplate
      },
      applyConsequences: (state, random) {
        // Reputation tanks, stock takes a 15% hit, CEO is removed
        state.player.influence -= 10;
      }
    ));
  }
}