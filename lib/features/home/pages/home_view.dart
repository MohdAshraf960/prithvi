import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Home extends ConsumerStatefulWidget {
  static const id="/home";
  const Home({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  backgroundColor: Colors.purple,
  title: Text("Home"),),


body: Stack(children: [
 
 SfCartesianChart(
          primaryXAxis: CategoryAxis(), // Define the x-axis as a category axis
          series: <BarSeries<ChartData, String>>[
            BarSeries<ChartData, String>(
              dataSource: <ChartData>[
                ChartData('Category 1', 10), // Category and its value
                ChartData('Category 2', 20),
                
              ],
              xValueMapper: (ChartData data, _) => data.category, // x-axis data
              yValueMapper: (ChartData data, _) => data.value,     // y-axis data
            ),
          ],
        ),

],),
    );
  }
}

class ChartData {
  final String category;
  final double value;

  ChartData(this.category, this.value);
}