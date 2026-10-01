enum Currency { ngn, aed, sar, usd, cad, gbp, eur, krw, jpy, cny, thb }

class Country {
  final String id;
  final String name;
  final Currency currency;
  final double corporateTaxRate;
  final double economicVolatility; // Impacts the probability of market shocks

  const Country({
    required this.id,
    required this.name,
    required this.currency,
    required this.corporateTaxRate,
    required this.economicVolatility,
  });
}

class WorldDatabase {
  static const Map<String, Country> countries = {
    'NGA': Country(id: 'NGA', name: 'Nigeria', currency: Currency.ngn, corporateTaxRate: 0.08, economicVolatility: 0.08),
    'UAE': Country(id: 'UAE', name: 'United Arab Emirates', currency: Currency.aed, corporateTaxRate: 0.09, economicVolatility: 0.03),
    'KSA': Country(id: 'KSA', name: 'Saudi Arabia', currency: Currency.sar, corporateTaxRate: 0.00, economicVolatility: 0.04),
    'USA': Country(id: 'USA', name: 'United States', currency: Currency.usd, corporateTaxRate: 0.21, economicVolatility: 0.02),
    'CAN': Country(id: 'CAN', name: 'Canada', currency: Currency.cad, corporateTaxRate: 0.21, economicVolatility: 0.01),
    'GBR': Country(id: 'GBR', name: 'United Kingdom', currency: Currency.gbp, corporateTaxRate: 0.25, economicVolatility: 0.03),
    'EUR': Country(id: 'EUR', name: 'European Union', currency: Currency.eur, corporateTaxRate: 0.24, economicVolatility: 0.02),
    'KOR': Country(id: 'KOR', name: 'South Korea', currency: Currency.krw, corporateTaxRate: 0.24, economicVolatility: 0.03),
    'JPN': Country(id: 'JPN', name: 'Japan', currency: Currency.jpy, corporateTaxRate: 0.30, economicVolatility: 0.02),
    'CHN': Country(id: 'CHN', name: 'China', currency: Currency.cny, corporateTaxRate: 0.25, economicVolatility: 0.05),
    'THA': Country(id: 'THA', name: 'Thailand', currency: Currency.thb, corporateTaxRate: 0.20, economicVolatility: 0.06),
  };
}