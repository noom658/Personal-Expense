import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter_app/providers/home_provider.dart';
import 'package:project_flutter_app/providers/wallet_provider.dart';

Widget PieChartWidget(){
  var provider = HomeProvider().getSections();
  return Container(
    margin: EdgeInsets.only(top: 120),
    height: 100,
    child: PieChart(
      PieChartData(
        borderData: FlBorderData(show: false),
        sectionsSpace: 0,
        centerSpaceRadius: 40,
        sections: provider,
      ),
    ),
  );
}