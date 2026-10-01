import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'engine/simulation.dart';

void main() {
  runApp(EmpireSimApp());
}

class EmpireSimApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Empire & Dynasty Sim',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.blueGrey,
      ),
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final SimulationEngine engine = SimulationEngine();
  final currencyFormatter = NumberFormat.currency(symbol: '\$');

  void _ageUp() {
    setState(() {
      engine.tick();
    });
  }

  @override
  Widget build(BuildContext context) {
    final player = engine.currentState.player;
    
    return Scaffold(
      appBar: AppBar(title: Text(engine.currentState.year.toString())),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Character Header
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white24),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("👤 ${player.name.toUpperCase()}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text("Age ${player.age}  🇳🇬", style: TextStyle(fontSize: 16, color: Colors.grey)),
                  SizedBox(height: 16),
                  _buildStatRow("❤️ Health", player.health),
                  _buildStatRow("😊 Happiness", player.happiness),
                  _buildStatRow("🧠 Intelligence", player.intelligence),
                  _buildStatRow("💰 Net Worth", engine.getTotalNetWorth(), isCurrency: true),
                  _buildStatRow("⭐ Status", player.status),
                  _buildStatRow("👥 Influence", player.influence),
                ],
              ),
            ),
            Spacer(),
            // Age Up Button
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: _ageUp,
                child: Text("[ AGE UP ]", style: TextStyle(fontSize: 20, letterSpacing: 2)),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white12),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, num value, {bool isCurrency = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16)),
          Text(
            isCurrency ? currencyFormatter.format(value) : value.toString(),
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}