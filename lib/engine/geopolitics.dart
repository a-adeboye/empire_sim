import '../models/state.dart';

enum Currency { ngn, aed, sar, usd, gbp, eur, krw, jpy, cny, thb, cad }

class Country {
  final String id;
  final String name;
  final Currency currency;
  final double corporateTaxRate;
  final double baseExchangeRateToUsd; // Determines conversion when migrating

  const Country(this.id, this.name, this.currency, this.corporateTaxRate, this.baseExchangeRateToUsd);
}

class WorldDatabase {
  static const Map<String, Country> countries = {
    'NGA': Country('NGA', 'Nigeria', Currency.ngn, 0.08, 1658.0),
    'UAE': Country('UAE', 'United Arab Emirates', Currency.aed, 0.09, 3.78),
    'KSA': Country('KSA', 'Saudi Arabia', Currency.sar, 0.00, 3.69),
    'EUR': Country('EUR', 'European Union', Currency.eur, 0.25, 0.88),
    'KOR': Country('KOR', 'South Korea', Currency.krw, 0.24, 1361.36),
    'USA': Country('USA', 'United States', Currency.usd, 0.21, 1.0),
    'GBR': Country('GBR', 'United Kingdom', Currency.gbp, 0.25, 0.73),
    'JPN': Country('JPN', 'Japan', Currency.jpy, 0.30, 158.03),
    'CHN': Country('CHN', 'China', Currency.cny, 0.25, 7.32),
    'THA': Country('THA', 'Thailand', Currency.thb, 0.20, 33.65),
    'CAN': Country('CAN', 'Canada', Currency.cad, 0.265, 1.35),
  };
}

class EmigrateCommand {
  final String targetCountryId;

  EmigrateCommand(this.targetCountryId);

  void execute(WorldState state) { // Changed from dynamic to WorldState
    Country current = WorldDatabase.countries[state.player.country]!;
    Country target = WorldDatabase.countries[targetCountryId]!;

    // Convert liquid cash via USD as base
    double cashInUsd = state.playerCash / current.baseExchangeRateToUsd;
    state.playerCash = cashInUsd * target.baseExchangeRateToUsd;
    
    state.player.country = targetCountryId;
    state.activeCurrency = target.currency;
  }
}