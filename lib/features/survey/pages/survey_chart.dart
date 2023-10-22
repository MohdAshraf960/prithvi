import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:prithvi/config/config.dart';
import 'package:prithvi/core/core.dart';
import 'package:prithvi/services/services.dart';

class SurveyChart extends StatefulWidget {
  @override
  State<SurveyChart> createState() => _SurveyChartState();
}

class _SurveyChartState extends State<SurveyChart> {
  final categoryColors = {
    "home": Colors.blue,
    "travel": Colors.green,
    "diet": Colors.orange,
    "other": Colors.pink,
  };

  List<Map<String, dynamic>>? surveyList;

  @override
  void initState() {
    getSurveyList();
    super.initState();
  }

  getSurveyList() async {
    surveyList = await SurveyService(
      firestore: FirebaseFirestore.instance,
      secureStorageService: SecureStorageService(),
    ).getSurveyDataByYear(
      DateTime.now().year,
    );

    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "Monthly Report",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: categoryColors.entries.map((entry) {
              final category = entry.key;
              final color = entry.value;
              return Container(
                margin: EdgeInsets.all(8), // Adjust the margin as needed
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      color: color,
                    ),
                    SizedBox(width: 5),
                    Text(
                      category.toUpperCase(),
                      style: TextStyle(
                        color: grey, // Customize the text color
                        fontSize: 14, // Adjust the font size
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          SizedBox(
            height: 10,
          ),
          AspectRatio(
            aspectRatio: 1.5,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: BarChart(
                  BarChartData(
                    titlesData: FlTitlesData(
                      topTitles: AxisTitles(),
                      leftTitles: AxisTitles(
                        axisNameWidget: Text("CO2 Emission(in tones)"),
                      ),
                      rightTitles: AxisTitles(),
                      bottomTitles: AxisTitles(
                        axisNameWidget: Text("Months"),
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            final index = value.toInt();
                            if (index >= 0 && index < surveyList!.length) {
                              final data = surveyList![index];
                              return Text("${data['month']}/${data['year']}");
                            }
                            return Text('');
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    gridData: FlGridData(
                      show: true,
                    ),
                    barGroups: surveyList?.asMap().entries.map((entry) {
                      final index = entry.key;
                      final data = entry.value;
                      final surveyData = data['surveyData'];
                      final categories = ['home', 'travel', 'diet', 'other'];

                      final barRods = categories.map((category) {
                        final value = surveyData[category] ?? 0.0;

                        return BarChartRodData(
                          toY: value,
                          width: 16,
                          color: categoryColors[category],
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(6),
                            topRight: Radius.circular(6),
                          ),
                        );
                      }).toList();

                      return BarChartGroupData(
                        x: index,
                        barsSpace: 4,
                        barRods: barRods,
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
