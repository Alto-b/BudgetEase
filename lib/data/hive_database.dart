import 'package:expense_tracker/models/expense_items.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDatabase{

  final _mybox=Hive.box('expense_database');

  void saveData(List<ExpenseItem> allExpense){

    List<List<dynamic>>allExpensesFormatted=[];
    for(var expense in allExpense){
      List<dynamic> expenseFormatted=[
      expense.name,
      expense.amount,
      expense.datetime
      ];
      allExpensesFormatted.add(expenseFormatted);
    }
    _mybox.put("All_expenses",allExpensesFormatted);
  }

  List<ExpenseItem> readData(){
    List savedExpenses = _mybox.get("All_expenses") ?? [];
    List<ExpenseItem> allExpenses=[];

    for(int i=0;i<savedExpenses.length; i++){
      String name = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      DateTime datetime = savedExpenses[i][2];

      ExpenseItem expense=ExpenseItem(name: name, amount: amount, datetime: datetime);
  
    allExpenses.add(expense);
    }
  return allExpenses;

  }

}