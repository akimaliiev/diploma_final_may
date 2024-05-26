import 'package:flutter/material.dart';

class TopCard extends StatelessWidget {
  const TopCard({required this.balance,required this.income, required this.expense, super.key});
  final String balance;
  final String income;
  final String expense;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 200,
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 10,),
              Text('B A L A N C E',
                style: TextStyle(color: Colors.grey[500], fontSize: 16)),
              Text( 'KZT ' + balance,
              style: TextStyle(color: Colors.grey[800], fontSize: 35),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.arrow_upward),
                      Column(
                        children: [
                          Text('Income'),
                          Text('KZT '+income,
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold
                          ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.arrow_downward),
                      Column(
                        children: [
                          Text('Expense'),
                          Text('KZT '+expense,
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold
                          ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color.fromARGB(255, 101, 100, 95),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade500,
              offset: Offset(4.0, 4.0),
              blurRadius: 15,
              spreadRadius: 1.0,
            ),
            const BoxShadow(
              color: Colors.white,
              offset: Offset(-4.0, -4.0),
              blurRadius: 15,
              spreadRadius: 1
            ),
          ]
        ),
      ),
    );
  }
}