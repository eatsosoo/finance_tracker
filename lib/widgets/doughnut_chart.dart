import 'package:finance_tracker/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartSampleData {
  final String tag;
  final double amount;
  final String text;
  final Color? color;

  ChartSampleData({
    required this.tag,
    required this.amount,
    required this.text,
    this.color,
  });
}

class DoughnutDefault extends StatefulWidget {
  final List<ChartSampleData> series;
  final Color baseColor;

  const DoughnutDefault({
    super.key,
    required this.series,
    this.baseColor = Colors.black,
  });

  @override
  State<DoughnutDefault> createState() => _DoughnutDefaultState();
}

class _DoughnutDefaultState extends State<DoughnutDefault> {
  late TooltipBehavior _tooltip;
  late List<ChartSampleData> _chartData;
  late int _explodeIndex;
  late List<Color> _colors;

  @override
  void initState() {
    super.initState();
    _explodeIndex = 0;
    _tooltip = TooltipBehavior(enable: true, format: 'point.x : point.y%');
    _colors = generateColors(baseColor: widget.baseColor, count: widget.series.length);
    _chartData = List.generate(widget.series.length, (i) {
      return ChartSampleData(
        tag: widget.series[i].tag,
        amount: widget.series[i].amount,
        text: widget.series[i].text,
        color: widget.series[i].color,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildDefaultDoughnutChart();
  }

  /// Tạo biểu đồ doughnut
  SfCircularChart _buildDefaultDoughnutChart() {
    return SfCircularChart(
      // title: const ChartTitle(text: 'Composition of ocean water'),
      // legend: const Legend(
      //   isVisible: true,
      //   overflowMode: LegendItemOverflowMode.wrap,
      // ),
      series: _buildDefaultDoughnutSeries(),
      tooltipBehavior: _tooltip,
      backgroundColor: Colors.white,
    );
  }

  /// Tạo dữ liệu series cho doughnut
  List<DoughnutSeries<ChartSampleData, String>> _buildDefaultDoughnutSeries() {
    return <DoughnutSeries<ChartSampleData, String>>[
      DoughnutSeries<ChartSampleData, String>(
        dataSource: _chartData,
        xValueMapper: (ChartSampleData data, _) => data.tag,
        yValueMapper: (ChartSampleData data, _) => data.amount,
        dataLabelMapper: (ChartSampleData data, _) => data.text,
        pointColorMapper: (ChartSampleData data, _) => data.color,
        dataLabelSettings: const DataLabelSettings(isVisible: true),
        explode: true,
        explodeIndex: _explodeIndex,
        onPointTap: (ChartPointDetails details) {
          setState(() {
            _explodeIndex = details.pointIndex!;
          });
        },
      ),
    ];
  }

  @override
  void dispose() {
    _chartData.clear();
    super.dispose();
  }
}
