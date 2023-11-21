// ignore_for_file: prefer_const_constructors

import 'package:expense_tracker/bar%20graph/bar_graph.dart';
import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/datetime/date_time_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseSummary extends StatelessWidget {

  final DateTime startOfWeek;

  const ExpenseSummary({
    super.key,
    required this.startOfWeek
  });

  //calculate max
  double calculateMax(
    ExpenseData value,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday
  ){
    double? max=100;
    
    List<double> values=[
      value.calculateDailytExpenseSummary()[sunday] ?? 0,
      value.calculateDailytExpenseSummary()[monday] ?? 0,
      value.calculateDailytExpenseSummary()[tuesday] ?? 0,
      value.calculateDailytExpenseSummary()[wednesday] ?? 0,
      value.calculateDailytExpenseSummary()[thursday] ?? 0,
      value.calculateDailytExpenseSummary()[friday] ?? 0,
      value.calculateDailytExpenseSummary()[saturday] ?? 0,
    ];

    values.sort();
    max=values.last*1.1;
    return max==0?300:max;
  }

  //calcualte week total
   String calculateWeekTotal(
    ExpenseData value,
    String sunday,
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday
  ){
     List<double> values=[
      value.calculateDailytExpenseSummary()[sunday] ?? 0,
      value.calculateDailytExpenseSummary()[monday] ?? 0,
      value.calculateDailytExpenseSummary()[tuesday] ?? 0,
      value.calculateDailytExpenseSummary()[wednesday] ?? 0,
      value.calculateDailytExpenseSummary()[thursday] ?? 0,
      value.calculateDailytExpenseSummary()[friday] ?? 0,
      value.calculateDailytExpenseSummary()[saturday] ?? 0,
    ];
    double total=0;
    for(int i=0;i<values.length;i++){
      total+=values[i];
    }
    return total.toStringAsFixed(2);
  }


  @override
  Widget build(BuildContext context) {

    //get yyyymmdd for each day of week 
    String sunday=convertDateTimeToString(startOfWeek.add(const Duration(days: 0)));
    String monday=convertDateTimeToString(startOfWeek.add(const Duration(days: 1)));
    String tuesday=convertDateTimeToString(startOfWeek.add(const Duration(days: 2)));
    String wednesday=convertDateTimeToString(startOfWeek.add(const Duration(days: 3)));
    String thursday=convertDateTimeToString(startOfWeek.add(const Duration(days: 4)));
    String friday=convertDateTimeToString(startOfWeek.add(const Duration(days: 5)));
    String saturday=convertDateTimeToString(startOfWeek.add(const Duration(days: 6)));
          
    return Consumer<ExpenseData>(builder: (context,value,child)=>Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text("Week Total:",style: TextStyle(fontWeight: FontWeight.bold),),
                   Text("\₹${calculateWeekTotal(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday)}"),
          
                ],
              ),
              IconButton(onPressed: (){
              
              }, icon: Icon(Icons.replay_outlined))
               ],
          ),
        ),
        SizedBox(height: 20,),
        SizedBox(
          height: 200,
          child: MyBarGraph(
            maxY: calculateMax(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday) ,
            sunAmount: value.calculateDailytExpenseSummary()[sunday] ?? 0, 
            monAmount: value.calculateDailytExpenseSummary()[monday] ?? 0, 
            tueAmount: value.calculateDailytExpenseSummary()[tuesday] ?? 0,  
            wedAmount: value.calculateDailytExpenseSummary()[wednesday] ?? 0, 
            thuAmount: value.calculateDailytExpenseSummary()[thursday] ?? 0, 
            friAmount: value.calculateDailytExpenseSummary()[friday] ?? 0, 
            satAmount: value.calculateDailytExpenseSummary()[saturday] ?? 0, 
          ),
        ),
      ],
    ));
  }
}