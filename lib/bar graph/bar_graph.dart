// ignore_for_file: prefer_const_constructors

import 'package:expense_tracker/bar%20graph/bar_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyBarGraph extends StatelessWidget {

  final double? maxY;
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thuAmount;
  final double friAmount;
  final double satAmount;

  

  const MyBarGraph({
    super.key,
    required this.maxY,
    required this.sunAmount,
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thuAmount,
    required this.friAmount,
    required this.satAmount});

  @override
  Widget build(BuildContext context) {

    BarData myBarData=BarData(sunAmount: sunAmount, monAmount: monAmount, tueAmount: tueAmount, wedAmount: wedAmount, thuAmount: thuAmount, friAmount: friAmount, satAmount: satAmount);
    myBarData.initializeBarData();

    return BarChart(
      BarChartData(
        maxY: maxY,
        minY: 0,
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles:SideTitles(showTitles: false) ),
          leftTitles: AxisTitles(sideTitles:SideTitles(showTitles: false) ),
          rightTitles: AxisTitles(sideTitles:SideTitles(showTitles: false) ),
          bottomTitles:AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: getBottomTitles,

            )
          ) 
        ),
        barGroups: myBarData.bardata
          .map((data) => BarChartGroupData(
            x:data.x,
            barRods: [
              BarChartRodData(
                toY:data.y,
                color:Colors.grey[800],
                width: 15,
                borderRadius: BorderRadius.circular(5),
                backDrawRodData: BackgroundBarChartRodData(
                  show: true,
                  toY: maxY,
                  color: Colors.grey[100]
                ))
            ]))
          .toList(),
      )
    );
  }

  Widget getBottomTitles(double value,TitleMeta meta){
    // const style=TextStyle(
    //   color: Colors.grey,
    //   fontWeight: FontWeight.bold,
    //   fontSize: 16
    //   );
    Widget text;
    switch(value.toInt()){
      case 0 : text=const Text("S");break;
      case 1 : text=const Text("M");break;
      case 2 : text=const Text("T");break;
      case 3 : text=const Text("W");break;
      case 4 : text=const Text("T");break;
      case 5 : text=const Text("F");break;
      case 6 : text=const Text("S");break;
      default:text=const Text('');break;
    }
    return SideTitleWidget(child: text, axisSide: meta.axisSide);
  }
  
}