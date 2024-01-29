import 'package:flutter/material.dart';
import 'package:flutter_coffee/data/service.dart';

class OrderConfirmationScreen extends StatefulWidget {
  const OrderConfirmationScreen({required this.coffeeService, super.key});

  final CoffeeService coffeeService;

  @override
  State<StatefulWidget> createState() => _OrderConfirmationState();
}

class _OrderConfirmationState extends State<OrderConfirmationScreen> {
  Future<String>? orderFuture;

  void _confirmOrder() {
    orderFuture = widget.coffeeService.placeOrder();
    setState(() {});
    orderFuture!.then((value) => Navigator.pushNamed(context, '/final_screen'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your order')),
      body: orderFuture != null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: widget.coffeeService.selectedDrinks.map((drink) {
                return ListTile(
                  title: Text(drink.name),
                  subtitle: Text(drink.price),
                  leading: Image.asset(
                    'assets/coffee_icons/${drink.id}.png',
                    errorBuilder: (_, e, st) => Image.asset('assets/coffee_icons/no_coffee.png'),
                  ),
                );
              }).toList(),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _confirmOrder,
        label: const Text('Confirm order ☕️'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
