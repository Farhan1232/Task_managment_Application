

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:task_managment_app/provider/task_list_provider.dart';


import '../provider/favourite_provider.dart';
import 'colors.dart';


class ChartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppColor.darkBlackColor,
      appBar: AppBar(
        title: Text('Real-time Chart'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer2<Taskprovider, FavoriteProvider>(
          builder: (context, todoProvider, favoriteProvider, child) {
            final userAddedData = List.generate(
              todoProvider.items.length + 1,
              (index) => index.toDouble(),
            );
            final favoriteData = List.generate(
              favoriteProvider.favoriteItems.length + 1,
              (index) => index.toDouble(),
            );

            return LineChart(
              LineChartData(
                minX: 0,
                maxX: userAddedData.length.toDouble(),
                minY: 0,
                lineBarsData: [
                  LineChartBarData(
                    spots: userAddedData.asMap().entries.map((entry) {
                      return FlSpot(entry.key.toDouble(), entry.value.toDouble());
                    }).toList(),
                    isCurved: true,
                    color:Colors.blue,
                    barWidth: 4,
                    isStrokeCapRound: true,
                    belowBarData: BarAreaData(show: false),
                  ),
                  LineChartBarData(
                    spots: favoriteData.asMap().entries.map((entry) {
                      return FlSpot(entry.key.toDouble(), entry.value.toDouble());
                    }).toList(),
                    isCurved: true,
                    color: Colors.red,
                    barWidth: 4,
                    isStrokeCapRound: true,
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
