import 'package:flutter/material.dart';

void main() => runApp(const TipApp());

class TipApp extends StatelessWidget {
  const TipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( // make a theme that's green RAHHHH
      title: 'Tip Calculator',
      theme: ThemeData( // theme from seed color like in the lesson 2
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      darkTheme: ThemeData (
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.light, // dark mode version of the same green theme
        ),
      ),
      themeMode: ThemeMode.system,
      home: const TipPage(), // follows light/dark setting
    );
  }
}
// converts the text into number and tryparse gives null if its not a number
double? parseBill(String input) => double.tryParse(input.trim());
// return a record with name fields so we can use result.tip and result.total
({double tip, double total}) computeTip(double bill, int percent) {
  final tip = bill * percent / 100;
  return (tip: tip, total: bill + tip);
}
// StatefulWidget for the bill and percentage change while the app runs
class TipPage extends StatefulWidget {
  const TipPage({super.key});

  @override
  State<TipPage> createState() => _TipPageState();
}

class _TipPageState extends State<TipPage> {
  final TextEditingController billController = TextEditingController();
  int percent = 15; // controller holds the text type in the bill field

  @override
  void dispose() {
    billController.dispose();
  }


  @override
  Widget build(BuildContext context) {

    final bill = parseBill(billController.text);
 // these are empty and the if else statement fills in what should show
    String message = '';
    String tipText = '';
    String totalText = '';
// if else statement
    // bill is null when the input is empty or not a number
    if (bill == null) {
      message = 'Enter a valid amount';

    } else {
      final result = computeTip(bill, percent);
      String tipNumber = result.tip.toStringAsFixed(2);
      String totalNumber = result.total.toStringAsFixed(2);

      tipText = 'Tip:' + tipNumber;
      totalText = 'Total:' + totalNumber;

    }
    return Scaffold(
        appBar: AppBar(title: const Text('Tip Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column (
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField ( // bill field w
              controller: billController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                prefixText: 'P',
                labelText: 'Bill amount',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() {}),
        ), // setstate so the total update right wa
        const SizedBox(height: 16),


            // percentage buttons of the app
            SegmentedButton<int>(
              segments: const [
                ButtonSegment(value: 15, label: Text('15%')),
                ButtonSegment(value: 10, label: Text('10%')),
                ButtonSegment(value: 20, label: Text('20%')),
              ],
              selected: {percent},
              onSelectionChanged:(selection) {
                setState(() { // set so percent
                  percent = selection.first;
                                }); //
      },
            ),
        const SizedBox(height: 20),

        // results
        Text(message), // only text when the bills is invalid
        Text(tipText, style: const TextStyle(fontSize: 16)),
        Text(totalText,style: const TextStyle(fontSize: 24)), // bigger total
        ],
        ),
      ),
    );

  }
}