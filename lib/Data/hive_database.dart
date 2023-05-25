import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../Models/expense_item.dart';

class HiveDataBase{
  //reference our box
  final _mybox = Hive.box('expense_database');

  //write data
 void saveData(List<ExpenseItem> allExpense) {

   List<List<dynamic>> allExpenseFormatted = [];

   for( var expense in allExpense){
     List<dynamic> expenseFormatted = [
       expense.name,
       expense.amount,
       expense.dateTime
     ];
     allExpenseFormatted.add(expenseFormatted);
   }
   _mybox.put('ALL_EXPENSES', allExpenseFormatted);
 }

 List<ExpenseItem> readData() {

   List savedExpenses = _mybox.get('ALL_EXPENSES') ?? [];
   List<ExpenseItem> allExpenses = [];

   for ( int i=0; i< savedExpenses.length ; i++){
     String name = savedExpenses[i][0];
     String amount = savedExpenses[i][1];
     DateTime dateTime = savedExpenses[i][2];
     
     ExpenseItem expense = ExpenseItem(
         name: name,
         amount: amount,
         dateTime: dateTime);

     allExpenses.add(expense);
   }
   return allExpenses;
 }

}