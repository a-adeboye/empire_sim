enum EngineType { i4, i6,  v6, v8, v12, w16, ev, hybrid }
enum TrimLevel { base, sport, premium, bespoke }

class Vehicle {
  String make;
  String model;
  TrimLevel trim;
  EngineType engine;
  bool isPrimaryCommute;
  double condition; // 100.0 is perfect. Degrades over time.

  Vehicle(this.make, this.model, this.trim, this.engine, {this.isPrimaryCommute = false, this.condition = 100.0});
}

class HouseholdStaff {
  bool hasButler; // Maintains all properties, yachts, aircraft, and cars
  bool hasDriver; // Operates the primary commute vehicle
  
  HouseholdStaff({this.hasButler = false, this.hasDriver = false});

  void runAnnualMaintenance(List<Vehicle> fleet) {
    for (var vehicle in fleet) {
      if (hasButler) {
        vehicle.condition = 100.0; // Butler keeps everything immaculate
      } else {
        vehicle.condition -= 5.0; // Standard degradation
      }
    }
  }
}