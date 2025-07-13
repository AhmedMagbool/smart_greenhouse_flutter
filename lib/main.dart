import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(const SmartGreenhouseApp());
}

class SmartGreenhouseApp extends StatelessWidget {
  const SmartGreenhouseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Greenhouse Dashboard',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const DashboardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🌿 Smart Greenhouse Dashboard'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: SensorGrid(),
          ),
          Expanded(child: SensorChart()),
        ],
      ),
    );
  }
}

class SensorGrid extends StatelessWidget {
  const SensorGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final sensors = [
      {'label': '🌡️ Temp', 'value': '26 °C'},
      {'label': '💧 Hum', 'value': '61 %'},
      {'label': '💡 Light', 'value': '2843'},
      {'label': '🚶 Motion', 'value': 'OFF'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      itemCount: sensors.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2.5),
      itemBuilder: (context, index) {
        final sensor = sensors[index];
        return Card(
          elevation: 2,
          child: Center(
            child: ListTile(
              title: Text(sensor['label']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(sensor['value']!, style: const TextStyle(fontSize: 16)),
            ),
          ),
        );
      },
    );
  }
}

class SensorChart extends StatelessWidget {
  final List<FlSpot> humidityData = [
    FlSpot(1, 40), FlSpot(2, 50), FlSpot(3, 55), FlSpot(4, 53), FlSpot(5, 61)
  ];
  final List<FlSpot> tempData = [
    FlSpot(1, 24), FlSpot(2, 25), FlSpot(3, 26), FlSpot(4, 27), FlSpot(5, 26)
  ];

  SensorChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: LineChart(
        LineChartData(
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              spots: humidityData,
              isCurved: true,
              color: Colors.blue,
              barWidth: 3,
              belowBarData: BarAreaData(show: true, color: Colors.blue.withOpacity(0.3)),
            ),
            LineChartBarData(
              spots: tempData,
              isCurved: true,
              color: Colors.red,
              barWidth: 3,
              belowBarData: BarAreaData(show: true, color: Colors.red.withOpacity(0.3)),
            ),
          ],
        ),
      ),
    );
  }
}
