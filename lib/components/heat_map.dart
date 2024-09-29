import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class HeatMap extends StatelessWidget {
  final DateTime initDate;
  final Map<DateTime, int> datasets;
  const HeatMap({
    super.key,
    required this.initDate,
    required this.datasets,
  });

  @override
  Widget build(BuildContext context) {
    return HeatMapCalendar(
      initDate: initDate,
      datasets: datasets,
      colorMode: ColorMode.color,
      defaultColor: Theme.of(context).colorScheme.secondary,
      textColor: Theme.of(context).colorScheme.inversePrimary,
      showColorTip: false,
      size: 30,
      colorsets: {
        1: Colors.green.shade200,
        2: Colors.green.shade300,
        3: Colors.green.shade400,
        4: Colors.green.shade500,
        5: Colors.green.shade600,
        6: Colors.green.shade700,
        7: Colors.green.shade800,
      },
    );
  }
}
