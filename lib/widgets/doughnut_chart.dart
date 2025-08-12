import 'package:finance_tracker/types/chart.dart';
import 'package:finance_tracker/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';



class DoughnutChart extends StatefulWidget {
  final List<ChartSampleData> series;
  final Color baseColor;

  const DoughnutChart({
    super.key,
    required this.series,
    this.baseColor = Colors.red,
  });

  @override
  State<DoughnutChart> createState() => _DoughnutChartState();
}

class _DoughnutChartState extends State<DoughnutChart> {
  late TooltipBehavior _tooltip;
  late List<ChartSampleData> _chartData;
  late int _explodeIndex;
  late List<Color> _colors;

  @override
  void initState() {
    super.initState();
    _explodeIndex = 0;
    _tooltip = TooltipBehavior(enable: true, format: 'point.x : point.y%');
    _colors = blackToRedPalette(
      count: widget.series.length,
      leftColor: widget.baseColor,
      rightColor: Colors.white,
    );
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

  @override
  void didUpdateWidget(covariant DoughnutChart oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Nếu danh sách series mới khác với cũ → cập nhật
    if (widget.series != oldWidget.series) {
      setState(() {
        _colors = blackToRedPalette(
          count: widget.series.length,
          leftColor: widget.baseColor,
          rightColor: Colors.white,
        );
        _chartData = List.generate(widget.series.length, (i) {
          return ChartSampleData(
            tag: widget.series[i].tag,
            amount: widget.series[i].amount,
            text: widget.series[i].text,
            color: widget.series[i].color, // use color from generateColors()
          );
        });
      });
    }
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
      backgroundColor: Colors.transparent,
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
