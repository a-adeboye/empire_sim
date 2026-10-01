import 'dart:ui';
import 'package:flutter/material.dart';

class GlassDashboard extends StatefulWidget {
  @override
  _GlassDashboardState createState() => _GlassDashboardState();
}

class _GlassDashboardState extends State<GlassDashboard> {
  // Triggers the complex simulation loop silently
  void _ageUp() {
    setState(() {
      // engine.tick(); 
      // This runs the exchange rates, stock markets, and maintenance silently!
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // A dynamic, vibrant background is required for the glass effect to work
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade900, Colors.black87],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                _buildGlassCard(
                  child: Column(
                    children: [
                      Text("👤 ALEXANDER ADEBAYO", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                      Text("Age 28 • Toronto, Canada 🇨🇦", style: TextStyle(color: Colors.white70, fontSize: 16)),
                      Divider(color: Colors.white24),
                      _buildStatRow("💰 Net Worth", "\$4.2B CAD"),
                      _buildStatRow("🏢 Businesses", "3 (1 Public)"),
                    ],
                  ),
                ),
                Spacer(),
                // Arcade-style quick action buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildGlassIconButton(Icons.business, "Empire"),
                    _buildGlassIconButton(Icons.car_rental, "Assets"),
                    _buildGlassIconButton(Icons.group, "Staff"),
                  ],
                ),
                SizedBox(height: 20),
                // Massive, satisfying Age Up Button
                GestureDetector(
                  onTap: _ageUp,
                  child: _buildGlassCard(
                    child: Center(
                      child: Text("+ AGE UP", style: TextStyle(color: Colors.greenAccent, fontSize: 24, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // The macOS-style Liquid Glass Builder
  Widget _buildGlassCard({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0), // The core macOS blur
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _buildGlassIconButton(IconData icon, String label) {
    return Column(
      children: [
        _buildGlassCard(child: Icon(icon, color: Colors.white, size: 30)),
        SizedBox(height: 8),
        Text(label, style: TextStyle(color: Colors.white70)),
      ],
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.white70, fontSize: 18)),
          Text(value, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}