import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartData {
  final String xLabel;
  final double yValue;

  ChartData(this.xLabel, this.yValue);
}

class SplineChart extends StatelessWidget {
  final List<ChartData> data;
  final String title;

  const SplineChart({
    super.key,
    required this.data,
    this.title = 'Biểu đồ spline',
  });

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
        // edgeLabelPlacement: EdgeLabelPlacement.shift,
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
              final value = data.yValue.toStringAsFixed(2);
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  // color: seriesIndex == 0 ? Colors.orange : Colors.green,
                  // borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '\$${value}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
      ),
      series: <SplineSeries<ChartData, String>>[
        SplineSeries<ChartData, String>(
          dataSource: data,
          xValueMapper: (ChartData d, _) => d.xLabel,
          yValueMapper: (ChartData d, _) => d.yValue,
          color: Colors.orange,
          width: 2,
          markerSettings: const MarkerSettings(
            isVisible: true,
            shape: DataMarkerType.circle,
            color: Colors.orange,
            borderColor: Colors.white,
            borderWidth: 2,
          ),
        ),
        SplineSeries<ChartData, String>(
          dataSource: data,
          xValueMapper: (ChartData d, _) => d.xLabel,
          yValueMapper: (ChartData d, _) =>
              d.yValue + 10, // khác giá trị để tạo đường thứ 2
          color: Colors.green,
          width: 2,
          markerSettings: const MarkerSettings(
            isVisible: true,
            shape: DataMarkerType.circle,
            color: Colors.green,
            borderColor: Colors.white,
            borderWidth: 2,
          ),
        ),
      ],
    );
  }
}
