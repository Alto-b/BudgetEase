// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors



import 'package:expense_tracker/components/expense_summary.dart';
import 'package:expense_tracker/components/expense_tile.dart';
import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/models/expense_items.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //controllers
  final nameController=TextEditingController();
  final amountController=TextEditingController();

  @override
  void initState(){
    super.initState();
    Provider.of<ExpenseData>(context,listen: false).prepareData();
  }

  //to add new expense
  void addNewExpense(){
    showDialog(context: context,
               builder:(context) =>
               Container(
                height: 200,
                 child: Form(
                  key: _formKey,
                   child: AlertDialog(
                    title: Text("ADD EXPENSES"),
                    content: Column(
                      children: [
                        //title txt
                        TextFormField(
                          validator: (value) {
                            if(value==null){
                              return 'cant be empty';
                            }
                            return null;
                          },
                          controller: nameController,
                          decoration: InputDecoration(
                             hintText: "Title",
                             border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)
                             )
                          ),
                        ),SizedBox(height: 20,),
                        //amount txt
                        TextFormField(
                          validator: (value) {
                            if(value==null){
                              return 'cant be empty';
                            }
                            return null;
                          },
                          controller: amountController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                             hintText: "Amount",
                             border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)
                             )
                          ),
                        ),                     
                      ],
                    ),
                    actions: [
                      //save
                      MaterialButton(
                        onPressed:(){
                          save();
                        },
                        child: Text("ADD"), ),
                        //cancel
                      MaterialButton(
                        onPressed:(){
                          cancel();
                        },
                        child: Text("CANCEL"), )
                    ],
                   ),
                 ),
               ) ,);
  }

  //delete expense
  void deleteExpense(ExpenseItem expense){
    Provider.of<ExpenseData>(context,listen: false).deleteExpense(expense);
  }

  //save button
  void save(){
    if(nameController.text.isNotEmpty && amountController.text.isNotEmpty){
      ExpenseItem newExpense=ExpenseItem(name: nameController.text, amount: amountController.text, datetime:DateTime.now());
    Provider.of<ExpenseData>(context,listen: false).addNewExpense(newExpense);
    Navigator.pop(context);
    clear();}
  }
  //cancel button
void cancel(){
  Navigator.pop(context);
  clear();
}
  
  //clear controllers
  void clear(){
    nameController.clear();
    amountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(builder:(context,value,child)=>Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: Text("EXPENSE TRACKER",
        style: GoogleFonts.play(
          fontWeight: FontWeight.bold
        ),),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.settings))
        ],
      ),

      body: ListView(
        children: [
          SizedBox(height: 20,),
          //weekly
          ExpenseSummary(startOfWeek: value.startOfWeekDate()),

          SizedBox(height: 20,),

          //expenses
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
        itemCount: value.getAllExpenseList().length,
        itemBuilder: (context,index)=>Padding(
          padding: const EdgeInsets.all(25.0),
          child: ExpenseTile(
            name: value.getAllExpenseList()[index].name, 
            amount: value.getAllExpenseList()[index].amount, 
            dateTime: value.getAllExpenseList()[index].datetime,
            deleteTapped: (p0) => deleteExpense(value.getAllExpenseList()[index]),),
            
        )
        ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed:  addNewExpense,
        child: Icon(Icons.add,color: Colors.white,),
        backgroundColor: Colors.black,
        ),
    ),
    );
  }
}