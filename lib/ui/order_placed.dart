import 'package:flutter/material.dart';

import 'package:flutter_coffee/data/service.dart';

/// TODO: Order again button
class FinalScreen extends StatefulWidget {
  const FinalScreen({required this.coffeeService, super.key});

  final CoffeeService coffeeService;

  @override
  State<StatefulWidget> createState() => _FinalState();
}

class _FinalState extends State<FinalScreen> {
  void _orderAgain() {
    widget.coffeeService.clearOrder();
    Navigator.pushNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thank you!'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Your order at ${widget.coffeeService.selectedCoffeeShop!.name} will soon be ready.'),
            const SizedBox(height: 20),
            Text('Pickup at ${widget.coffeeService.selectedCoffeeShop!.address}.'),
            const SizedBox(height: 20),
            Text('Your order number is ${widget.coffeeService.lastOrderNumber}.',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _orderAgain,
        label: const Text('Order again? ☕️'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
