import 'package:flutter/material.dart';

void main() {
  runApp(const TipCalculatorApp());
}

class TipCalculatorApp extends StatelessWidget {
  const TipCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tip Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const TipCalculatorPage(),
    );
  }
}

class TipCalculatorPage extends StatefulWidget {
  const TipCalculatorPage({super.key});

  @override
  State<TipCalculatorPage> createState() => _TipCalculatorPageState();
}

class _TipCalculatorPageState extends State<TipCalculatorPage> {
  final TextEditingController billController = TextEditingController();

  double tipPercent = 10;
  int people = 1;

  double get bill => double.tryParse(billController.text) ?? 0;
  double get tipAmount => bill * tipPercent / 100;
  double get totalAmount => bill + tipAmount;
  double get perPerson => people == 0 ? 0 : totalAmount / people;

  void calculate() {
    setState(() {});
  }

  void reset() {
    setState(() {
      billController.clear();
      tipPercent = 10;
      people = 1;
    });
  }

  @override
  void dispose() {
    billController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tip Calculator',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.calculate_rounded,
                size: 70,
                color: Colors.indigo,
              ),
              const SizedBox(height: 10),
              const Text(
                'Calculate Your Tip',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 25),

              TextField(
                controller: billController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                onChanged: (_) => calculate(),
                decoration: InputDecoration(
                  labelText: 'Bill Amount',
                  hintText: 'Enter bill amount',
                  prefixText: '₹ ',
                  prefixIcon: const Icon(Icons.receipt_long),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                'Tip Percentage',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [5, 10, 15, 20, 25].map((value) {
                  return ChoiceChip(
                    label: Text('$value%'),
                    selected: tipPercent == value.toDouble(),
                    onSelected: (_) {
                      setState(() {
                        tipPercent = value.toDouble();
                      });
                    },
                  );
                }).toList(),
              ),

              const SizedBox(height: 25),

              const Text(
                'Number of People',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton.filled(
                    onPressed: people > 1
                        ? () => setState(() => people--)
                        : null,
                    icon: const Icon(Icons.remove),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      '$people',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton.filled(
                    onPressed: () => setState(() => people++),
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _ResultRow(
                        title: 'Tip Amount',
                        value: '₹ ${tipAmount.toStringAsFixed(2)}',
                      ),
                      const Divider(height: 25),
                      _ResultRow(
                        title: 'Total Amount',
                        value: '₹ ${totalAmount.toStringAsFixed(2)}',
                        highlight: true,
                      ),
                      const Divider(height: 25),
                      _ResultRow(
                        title: 'Per Person',
                        value: '₹ ${perPerson.toStringAsFixed(2)}',
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: reset,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Text('RESET'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: calculate,
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Text('CALCULATE'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResultRow extends StatelessWidget {
  final String title;
  final String value;
  final bool highlight;

  const _ResultRow({
    required this.title,
    required this.value,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 17,
            fontWeight: highlight ? FontWeight.bold : FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: highlight ? 22 : 18,
            fontWeight: FontWeight.bold,
            color: highlight ? Colors.indigo : null,
          ),
        ),
      ],
    );
  }
}
