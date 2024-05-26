import 'dart:async';

import 'package:diploma_16_10/components/drawer.dart';
import 'package:diploma_16_10/components/loading_circle.dart';
import 'package:diploma_16_10/components/plus_button.dart';
import 'package:diploma_16_10/components/top_card.dart';
import 'package:diploma_16_10/components/transactions.dart';
import 'package:diploma_16_10/google_sheets_api.dart';
import 'package:diploma_16_10/pages/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final _textcontrollerAmount = TextEditingController();
  final _textcontrollerItem = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isIncome = false;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  void goToProfilePage() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfilePage(),
      ),
    );
  }
  
  void _newTransaction() {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: Text('NEW  TRANSACTION'),
            content: SingleChildScrollView(
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey, 
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Expense'),
                        Switch(
                          value: _isIncome,
                          onChanged: (newValue) {
                            setState(() {
                              _isIncome = newValue;
                            });
                          },
                        ),
                        Text('Income'),
                      ],
                    ),
                    SizedBox(height: 5,),
                    Row(children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Amount'
                          ),
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Enter an amount';
                            }
                            return null;
                          },
                          controller: _textcontrollerAmount,
                        ),
                      )
                    ],),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'For what?'
                            ),
                            controller: _textcontrollerItem,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
    
            actions: <Widget>[
              MaterialButton(
                color: Colors.grey[600],
                child: Text('Cancel', style: TextStyle(color: Colors.white),),
                onPressed: () {
                  Navigator.of(context).pop();
                }
              ),
              MaterialButton(
                color: Colors.grey[600],
                child: Text('Enter', style: TextStyle(color: Colors.white),),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Perform actions if form is valid
                    _enterTransaction();
                    Navigator.of(context).pop();
                  }
                },
              
              )
            ],
          );
        }
      );
    }
  );
}
  
  bool timerHasStarted = false;
  void startLoading(){
    timerHasStarted = true;
    Timer.periodic(Duration(seconds: 1), (timer){
      if(GoogleSheetsApi.loading == false){
        setState(() {});
        timer.cancel();
      }
    });
  }
  
  void _enterTransaction(){
  GoogleSheetsApi.insert(
    _textcontrollerItem.text,
    _textcontrollerAmount.text,
    _isIncome
  );
    setState(() {
      
    });
  }
  void openEditBox(BuildContext context, int index) {
  // Get the current transaction details
  var transaction = GoogleSheetsApi.currentTransactions[index];
  TextEditingController nameController = TextEditingController(text: transaction[0]);
  TextEditingController amountController = TextEditingController(text: transaction[1]);
  bool isIncome = transaction[2] == 'income';  // Convert string to bool here if necessary

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Edit Transaction'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Transaction Name'),
              ),
              TextFormField(
                controller: amountController,
                decoration: InputDecoration(labelText: 'Amount'),
              ),
              SwitchListTile(
                title: Text('Is Income?'),
                value: isIncome,
                onChanged: (bool value) {
                  isIncome = value; // Toggle between Income and Expense
                  // IMPORTANT: Update the state within the dialog
                  (context as Element).markNeedsBuild();
                },
              ),
            ],
          ),
        ),
        actions: [
          MaterialButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          MaterialButton(
            child: Text('Save'),
            onPressed: () {
              // Directly pass the boolean `isIncome`
              GoogleSheetsApi.update(
                index,
                nameController.text,
                amountController.text,
                isIncome
              );
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}


  void openDeleteBox(BuildContext context, int index) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Delete Transaction'),
        content: Text('Are you sure you want to delete this transaction?'),
        actions: [
          MaterialButton(
            child: Text('No'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          MaterialButton(
            child: Text('Yes'),
            onPressed: () {
              GoogleSheetsApi.delete(index);  // Assumes a delete method exists in your API
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}



  @override
  Widget build(BuildContext context) {

    if(GoogleSheetsApi.loading == true && timerHasStarted == false){
      startLoading();
    }

    return Scaffold(
      drawer: MyDrawer(
        onProfileTap: goToProfilePage,
        onLogoutTap: signUserOut,
      ),
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey[200]),
        title: const Center(
          child: Text(
            'Control Yourself',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 118, 118, 118),
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            TopCard(
              balance: (GoogleSheetsApi.calculateIncome() - GoogleSheetsApi.calculateExpense()).toString(),
              income: GoogleSheetsApi.calculateIncome().toString(),
              expense: GoogleSheetsApi.calculateExpense().toString(),
            ),
            Expanded( 
              child: Container(
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Expanded(
                        child: GoogleSheetsApi.loading == true ? const LoadingCircle() : ListView.builder(
                          itemCount: GoogleSheetsApi.currentTransactions.length,
                          itemBuilder: (context, index){
                            return MyTransaction(
                              transactionName: GoogleSheetsApi.currentTransactions[index][0],
                              money: GoogleSheetsApi.currentTransactions[index][1],
                              expenseOrIncome: GoogleSheetsApi.currentTransactions[index][2],
                              onEditPressed: (context) => openEditBox,
                              onDeletePressed: (context) => openDeleteBox,
                            );
                          }
                        )
                      )
                    ]
                  ),
                ),
              ),         
            ),         
            PlusButton(
              function: _newTransaction,
            ),
          ],
        ),
      ),
    );
  }  
}

  
