import 'package:flutter/material.dart';

class ExpensePage extends StatefulWidget {
  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  List<double> expenses = [100.0, 200.0, 300.0]; // Example expenses
 
  double calculateTotalExpenses() {
    return expenses.fold(0, (previous, current) => previous + current);
  }

  void addExpense(double amount) {
    setState(() {
      expenses.add(amount);
    });
  }

  void deleteExpense(int index) {
    setState(() {
      double deletedExpense = expenses.removeAt(index);
      double totalExpenses = calculateTotalExpenses() - deletedExpense;
      expenses.clear();
      expenses.addAll(List.from(expenses)..add(totalExpenses));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Expense Tracker',
          style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(237, 96, 57,158), 
        leading: IconButton( 
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Total Expenses',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 4,
              color: Colors.white70, // Set card color to white with opacity
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '\$${calculateTotalExpenses().toStringAsFixed(2)}', // Display total expense amount
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromARGB(237, 96, 57,158),),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ExpenseListPage(expenses: expenses, onDelete: deleteExpense)),
                );
              },
              child: Text(
                'View Expenses',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(237, 96, 57,158),// Set button color to deep purple
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddExpensePage()),
                );
                if (result != null && result is double) {
                  addExpense(result);
                }
              },
              child: Text(
                'Add Expense',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(237, 96, 57,158), // Set button color to deep purple
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddExpensePage extends StatelessWidget {
  final TextEditingController _expenseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Expense',
          style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(237, 96, 57,158), // Set app bar color to deep purple
        leading: IconButton( // Add back button for iOS
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _expenseController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Expense Amount',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final amount = double.tryParse(_expenseController.text);
                if (amount != null) {
                  Navigator.pop(context, amount);
                }
              },
              child: Text(
                'Add',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(237, 96, 57,158), // Set button color to deep purple
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExpenseListPage extends StatelessWidget {
  final List<double> expenses;
  final Function(int) onDelete;

  const ExpenseListPage({required this.expenses, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Expense List',
          style: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(237, 96, 57,158), // Set app bar color to deep purple
        leading: IconButton( // Add back button for iOS
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              'Expense ${index + 1}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '\$${expenses[index].toStringAsFixed(2)}',
                  style: TextStyle(color: Color.fromARGB(237, 96, 57,158), fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  color: const Color.fromARGB(255, 107, 106, 106),
                  onPressed: () {
                    onDelete(index);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ExpensePage(),
  ));
}
