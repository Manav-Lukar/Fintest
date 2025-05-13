import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math' as math;

class SimpleHealthDashboardPage extends StatefulWidget {
  const SimpleHealthDashboardPage({Key? key, required DateTime date1, required DateTime date2}) : super(key: key);

  @override
  State<SimpleHealthDashboardPage> createState() => _SimpleHealthDashboardPageState();
}

class _SimpleHealthDashboardPageState extends State<SimpleHealthDashboardPage> {
  // User health data
  final String userName = "Alex";
  final double weight = 70.5; // in kg
  final double height = 175; // in cm
  final double bmi = 23.1;
  final int steps = 4500;
  final int heartRate = 82; // BPM
  final int systolicBP = 138; // mmHg
  final int diastolicBP = 88; // mmHg
  final int fastingGlucose = 115; // mg/dL
  final double cholesterol = 210; // mg/dL
  final int sleepHours = 6; // hours
  final double waterIntake = 1.2; // liters

  // Health targets
  final int targetHeartRate = 75; // BPM
  final int targetSystolicBP = 120; // mmHg
  final int targetDiastolicBP = 80; // mmHg
  final int targetFastingGlucose = 100; // mg/dL
  final double targetCholesterol = 200; // mg/dL
  final int targetSleepHours = 8; // hours
  final double targetWaterIntake = 2.5; // liters

  // Mock data for heartrate history
  List<FlSpot> heartRateData = [];

  @override
  void initState() {
    super.initState();
    _generateHeartRateData();
  }

  void _generateHeartRateData() {
    final random = math.Random();
    heartRateData = List.generate(14, (i) {
      return FlSpot(i.toDouble(), 70 + random.nextDouble() * 25);
    });
    // Add some spikes for demonstration
    heartRateData[4] = const FlSpot(4, 105);
    heartRateData[9] = const FlSpot(9, 110);
  }

  // Calculate disease risks based on health metrics
  Map<String, double> calculateDiseaseRisks() {
    Map<String, double> risks = {};
    
    // Heart disease risk (simplified calculation)
    double heartRisk = 0;
    if (heartRate > 80) heartRisk += 0.15;
    if (systolicBP > 130) heartRisk += 0.2;
    if (diastolicBP > 85) heartRisk += 0.15;
    if (cholesterol > 200) heartRisk += 0.2;
    if (bmi > 25) heartRisk += 0.1;
    if (sleepHours < 7) heartRisk += 0.1;
    risks["Heart Disease"] = heartRisk.clamp(0.0, 1.0);
    
    // Diabetes risk (simplified calculation)
    double diabetesRisk = 0;
    if (fastingGlucose > 100) diabetesRisk += 0.3;
    if (bmi > 25) diabetesRisk += 0.2;
    if (steps < 5000) diabetesRisk += 0.15;
    if (waterIntake < 2) diabetesRisk += 0.05;
    risks["Diabetes"] = diabetesRisk.clamp(0.0, 1.0);
    
    // Hypertension risk (simplified calculation)
    double hypertensionRisk = 0;
    if (systolicBP > 130) hypertensionRisk += 0.35;
    if (diastolicBP > 85) hypertensionRisk += 0.35;
    if (heartRate > 80) hypertensionRisk += 0.1;
    if (sleepHours < 7) hypertensionRisk += 0.1;
    risks["Hypertension"] = hypertensionRisk.clamp(0.0, 1.0);
    
    return risks;
  }

  String getRiskLevel(double risk) {
    if (risk < 0.3) {
      return "Low";
    } else if (risk < 0.6) {
      return "Moderate";
    } else {
      return "High";
    }
  }

  Color getRiskColor(double risk) {
    if (risk < 0.3) {
      return Colors.green;
    } else if (risk < 0.6) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, double> diseaseRisks = calculateDiseaseRisks();
    
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "Health Dashboard",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User greeting
              Text(
                "Hello, $userName!",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Your health status overview",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 20),
              
              // Disease risk section
              const Text(
                "Health Risk Assessment",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              
              // Disease risk cards
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: diseaseRisks.length,
                itemBuilder: (context, index) {
                  String diseaseName = diseaseRisks.keys.elementAt(index);
                  double riskValue = diseaseRisks[diseaseName]!;
                  return _buildRiskCard(diseaseName, riskValue);
                },
              ),
              
              const SizedBox(height: 20),
              
              // Vital signs section
              const Text(
                "Vital Signs",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              
              // Heart rate card with chart
              _buildHeartRateCard(),
              const SizedBox(height: 15),
              
              // Blood pressure & glucose in a row
              Row(
                children: [
                  Expanded(child: _buildMetricCard("Blood Pressure", "$systolicBP/$diastolicBP", "mmHg", 
                      (systolicBP > 130 || diastolicBP > 85) ? Colors.orange : Colors.green)),
                  const SizedBox(width: 10),
                  Expanded(child: _buildMetricCard("Blood Glucose", "$fastingGlucose", "mg/dL", 
                      fastingGlucose > 100 ? Colors.orange : Colors.green)),
                ],
              ),
              const SizedBox(height: 15),
              
              // BMI & Cholesterol in a row
              Row(
                children: [
                  Expanded(child: _buildMetricCard("BMI", "$bmi", "kg/m²", 
                      bmi > 25 ? Colors.orange : Colors.green)),
                  const SizedBox(width: 10),
                  Expanded(child: _buildMetricCard("Cholesterol", "$cholesterol", "mg/dL", 
                      cholesterol > 200 ? Colors.orange : Colors.green)),
                ],
              ),
              const SizedBox(height: 15),
              
              // Sleep & Water in a row
              Row(
                children: [
                  Expanded(child: _buildMetricCard("Sleep", "$sleepHours", "hours", 
                      sleepHours < 7 ? Colors.orange : Colors.green)),
                  const SizedBox(width: 10),
                  Expanded(child: _buildMetricCard("Water", "$waterIntake", "liters", 
                      waterIntake < 2 ? Colors.orange : Colors.green)),
                ],
              ),
              const SizedBox(height: 20),
              
              // Recommendations
              _buildRecommendationsCard(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'Trends',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildRiskCard(String diseaseName, double riskValue) {
    String riskLevel = getRiskLevel(riskValue);
    Color riskColor = getRiskColor(riskValue);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                diseaseName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: riskColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  riskLevel,
                  style: TextStyle(
                    color: riskColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: riskValue,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(riskColor),
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
          const SizedBox(height: 8),
          _buildRiskFactors(diseaseName),
        ],
      ),
    );
  }

  Widget _buildRiskFactors(String diseaseName) {
    List<String> factors = [];
    
    if (diseaseName == "Heart Disease") {
      if (heartRate > 80) factors.add("Elevated heart rate");
      if (systolicBP > 130 || diastolicBP > 85) factors.add("High blood pressure");
      if (cholesterol > 200) factors.add("Elevated cholesterol");
      if (bmi > 25) factors.add("Above normal BMI");
      if (sleepHours < 7) factors.add("Insufficient sleep");
    } else if (diseaseName == "Diabetes") {
      if (fastingGlucose > 100) factors.add("Elevated blood glucose");
      if (bmi > 25) factors.add("Above normal BMI");
      if (steps < 5000) factors.add("Low physical activity");
      if (waterIntake < 2) factors.add("Low water intake");
    } else if (diseaseName == "Hypertension") {
      if (systolicBP > 130) factors.add("High systolic pressure");
      if (diastolicBP > 85) factors.add("High diastolic pressure");
      if (heartRate > 80) factors.add("Elevated heart rate");
      if (sleepHours < 7) factors.add("Insufficient sleep");
    }
    
    if (factors.isEmpty) {
      return const Text(
        "No significant risk factors",
        style: TextStyle(color: Colors.green, fontSize: 13),
      );
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Contributing factors:",
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 4),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: factors.map((factor) => _buildFactorChip(factor)).toList(),
        ),
      ],
    );
  }

  Widget _buildFactorChip(String factor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        factor,
        style: TextStyle(
          color: Colors.grey[800],
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildHeartRateCard() {
    Color heartRateColor = heartRate > 80 ? Colors.orange : Colors.green;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.favorite, color: heartRateColor),
                  const SizedBox(width: 8),
                  const Text(
                    "Heart Rate",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Text(
                "$heartRate BPM",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: heartRateColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 100,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                minX: 0,
                maxX: 13,
                minY: 60,
                maxY: 120,
                lineBarsData: [
                  LineChartBarData(
                    spots: heartRateData,
                    isCurved: true,
                    color: heartRateColor,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: heartRateColor.withOpacity(0.2),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Target: $targetHeartRate BPM",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
              Text(
                "2-week average",
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String title, String value, String unit, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Text(
                value,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                unit,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendationsCard() {
    List<Map<String, dynamic>> recommendations = [];
    
    // Add recommendations based on health data
    if (systolicBP > 130 || diastolicBP > 85) {
      recommendations.add({
        'icon': Icons.restaurant,
        'text': 'Reduce sodium intake and consider the DASH diet',
        'color': Colors.orange,
      });
    }
    
    if (heartRate > 80) {
      recommendations.add({
        'icon': Icons.self_improvement,
        'text': 'Practice deep breathing exercises to reduce stress',
        'color': Colors.blue,
      });
    }

    if (fastingGlucose > 100) {
      recommendations.add({
        'icon': Icons.no_food,
        'text': 'Reduce sugar intake and processed carbohydrates',
        'color': Colors.red,
      });
    }

    if (sleepHours < 7) {
      recommendations.add({
        'icon': Icons.bedtime,
        'text': 'Aim for 7-8 hours of sleep per night',
        'color': Colors.indigo,
      });
    }

    if (waterIntake < 2) {
      recommendations.add({
        'icon': Icons.water_drop,
        'text': 'Increase water intake to at least 2.5L daily',
        'color': Colors.lightBlue,
      });
    }

    if (steps < 5000) {
      recommendations.add({
        'icon': Icons.directions_walk,
        'text': 'Aim for at least 8,000 steps daily',
        'color': Colors.green,
      });
    }
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Personalized Recommendations",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          ...recommendations.map((rec) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: rec['color'].withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(rec['icon'], color: rec['color'], size: 16),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    rec['text'],
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          )).toList(),
          const SizedBox(height: 5),
          Center(
            child: TextButton(
              onPressed: () {},
              child: const Text(
                "See detailed plan",
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HealthApp extends StatelessWidget {
  const HealthApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SimpleHealthDashboardPage(
        date1: DateTime.now().subtract(const Duration(days: 7)),
        date2: DateTime.now(),
      ),
    );
  }
}

void main() {
  runApp(const HealthApp());
}