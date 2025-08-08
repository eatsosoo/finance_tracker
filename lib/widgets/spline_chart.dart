import 'package:finance_tracker/utils/number_utils.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:finance_tracker/utils/color_utils.dart';

class ChartData {
  final String xLabel;
  final double yValue;

  ChartData(this.xLabel, this.yValue);
}

class SplineChart extends StatefulWidget {
  final List<List<ChartData>> series;
  final String title;
  final List<Color>? palettes;

  const SplineChart({
    super.key,
    required this.series,
    this.title = '',
    this.palettes,
  });

  @override
  State<SplineChart> createState() => _SplineChartState();
}

class _SplineChartState extends State<SplineChart> {
  late List<Color> _palettes;

  @override
  void initState() {
    super.initState();
    _palettes =
        widget.palettes ??
        blackToRedPalette(
          count: widget.series.length,
          leftColor: Colors.black,
          rightColor: Colors.red,
        );
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      margin: EdgeInsets.all(16),
      zoomPanBehavior: ZoomPanBehavior(
        enablePanning: true,
        zoomMode: ZoomMode.x,
        enableDirectionalZooming: true,
      ),
      backgroundColor: Colors.transparent,
      plotAreaBackgroundColor: Colors.transparent,
      plotAreaBorderWidth: 0,
      primaryXAxis: CategoryAxis(
        axisLine: const AxisLine(color: Colors.transparent),
        majorGridLines: const MajorGridLines(width: 0),
        majorTickLines: const MajorTickLines(size: 0),
        labelStyle: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w600,
        ),
        labelPlacement: LabelPlacement.onTicks,
        minimum: 0, // index bắt đầu
        maximum: 5,
        edgeLabelPlacement: EdgeLabelPlacement.shift,
      ),
      primaryYAxis: NumericAxis(
        isVisible: false,
        majorGridLines: const MajorGridLines(width: 0),
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(size: 0),
      ),
      crosshairBehavior: CrosshairBehavior(
        enable: true,
        lineType: CrosshairLineType.vertical,
        lineDashArray: [6, 3], // Nét đứt (bản mới của Syncfusion)
        activationMode: ActivationMode.singleTap,
        lineColor: Colors.grey.shade400,
        lineWidth: 1,
      ),
      tooltipBehavior: TooltipBehavior(
        enable: true,
        activationMode: ActivationMode.singleTap,
        builder:
            (
              dynamic data,
              dynamic point,
              dynamic series,
              int pointIndex,
              int seriesIndex,
            ) {
              final value = data.yValue;
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  // color: seriesIndex == 0 ? Colors.orange : Colors.green,
                  // borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  formatNumberShort(value),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
      ),
      series: <SplineSeries<ChartData, String>>[
        ...widget.series.asMap().entries.map(
          (seri) => SplineSeries<ChartData, String>(
            dataSource: seri.value,
            xValueMapper: (ChartData d, _) => d.xLabel,
            yValueMapper: (ChartData d, _) => d.yValue,
            color: _palettes[seri.key],
            width: 2,
            markerSettings: MarkerSettings(
              isVisible: true,
              shape: DataMarkerType.circle,
              color: _palettes[seri.key],
              borderColor: Colors.white,
              borderWidth: 2,
            ),
          ),
        ).toList(),
      ],
    );
  }
}
