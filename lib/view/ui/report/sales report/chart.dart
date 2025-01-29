import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ItemReportChartWidget extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  const ItemReportChartWidget({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    double chartWidth = items.length * 50;
    chartWidth = chartWidth.clamp(
        MediaQuery.sizeOf(context).width, MediaQuery.sizeOf(context).width * 5);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Sales Report'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: chartWidth,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(
                labelRotation: -45,
                majorGridLines: const MajorGridLines(width: 0),
              ),
              primaryYAxis: NumericAxis(
                labelFormat: '\${value}',
                axisLine: const AxisLine(width: 1),
                majorGridLines: const MajorGridLines(dashArray: [5, 5]),
              ),
              title: ChartTitle(
                text: 'Sales Amount by Item',
                textStyle:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              legend: Legend(
                isVisible: true,
                position: LegendPosition.bottom,
              ),
              tooltipBehavior: TooltipBehavior(enable: true),
              // تلميحات عند الضغط
              series: [
                ColumnSeries<Map<String, dynamic>, String>(
                  dataSource: items,
                  xValueMapper: (data, _) => data['item'],
                  yValueMapper: (data, _) => data['salesAmount'],
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                  name: 'Sales Amount',
                  color: Colors.blueAccent,
                  gradient: const LinearGradient(
                    colors: [Colors.blueAccent, Colors.cyan],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
