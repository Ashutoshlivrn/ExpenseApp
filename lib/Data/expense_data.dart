import 'package:expenseapp/Data/hive_database.dart';
import 'package:expenseapp/datetime/date_time_helper.dart';
import 'package:flutter/cupertino.dart';

import '../Models/expense_item.dart';

class ExpenseData extends ChangeNotifier{

  //list of all expense
  List<ExpenseItem> overallExpenseList = [];

  //get expense list
List<ExpenseItem> getAllExpenseList(){
  return overallExpenseList;
  notifyListeners();
}
//prepare data to display
  final db = HiveDataBase();
  void prepareData(){
  if(db.readData().isNotEmpty ){
    overallExpenseList = db.readData();
 
  }
  }

  //add new expense
void addNewExpense( ExpenseItem newExpense){
  overallExpenseList.add(newExpense);
  notifyListeners();
  db.saveData(overallExpenseList);
}

  // delete expense
void deleteExpense( ExpenseItem expense){
  overallExpenseList.remove(expense);
  notifyListeners();
  db.saveData(overallExpenseList);
}
  //get weekday from a date time object
String getDayName(DateTime dateTime) {
  switch (dateTime.weekday){
    case 1:
      return 'Mon';
    case 2:
      return 'Tue';
    case 3:
      return 'Wed';
    case 4:
      return 'Thu';
    case 5:
      return 'Fri';
    case 6:
      return 'Sat';
    case 7:
      return 'Sun';
    default:
      return '';
  }

}
  // get the date for the start of the week
   DateTime? startOfWeekDate() {
     DateTime? startOfWeek;

     //get today's date
     DateTime today = DateTime.now();

     // go back from today to find sunday
     for (int i = 0; i < 7; i++) {
       if (getDayName(today.subtract(Duration(days: i))) == 'Sun') {
         startOfWeek = today.subtract(Duration(days: i));
       }
     }
     return startOfWeek;
   }

   Map<String, double> calculateDailyExpenseSummary() {
   Map<String, double> dailyExpenseSummary = {
    // date(yyyymmdd): anountTotalForDay
  };
  for( var expense in overallExpenseList){
    String date = convertDateTimeToString(expense.dateTime);
    double amount = double.parse(expense.amount);

    if(dailyExpenseSummary.containsKey(date)){
      double currentAmount = dailyExpenseSummary[date]!;
      currentAmount += amount;
      dailyExpenseSummary[date] = currentAmount;
    }
    else{
      dailyExpenseSummary.addAll({date: amount});
    }
  }
  return dailyExpenseSummary;
   }
}














