import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_coffee/data/model.dart';
import 'package:flutter_coffee/data/service.dart';

/// The second screen - product selection - should display the selected coffee shop, along with a list of available
/// coffee drinks. The user should be able to add a coffee to the order by tapping on it. The user should also be able
/// continue with placing a coffee order by tapping on a floating action button.
class ProductSelection extends StatefulWidget {
  const ProductSelection({required this.coffeeService, super.key});

  final CoffeeService coffeeService;

  @override
  State<StatefulWidget> createState() => _ProductSelectionState();
}

class _ProductSelectionState extends State<ProductSelection> {
  late Future<List<CoffeeDrink>> _coffeeDrinksFuture;

  CoffeeShop? get selectedShop => widget.coffeeService.selectedCoffeeShop;

  @override
  void initState() {
    super.initState();
    _fetchCoffeeDrinks();
  }

  void _fetchCoffeeDrinks() async {
    _coffeeDrinksFuture = widget.coffeeService.listCoffeeDrinks();
  }

  void _placeOrder() {
    Navigator.pushNamed(context, '/order_confirmation');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedShop?.name ?? 'No shop selected'),
      ),
      body: FutureBuilder<List<CoffeeDrink>>(
        future: _coffeeDrinksFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListenableBuilder(listenable: widget.coffeeService, builder: (context, _) {
              return ListView(
                children: snapshot.data!.map((drink) {
                  return ListTile(
                    title: widget.coffeeService.orderContains(drink) ? Text('${drink.name} (Added)') : Text(drink.name),
                    subtitle: Text(drink.price),
                    leading: widget.coffeeService.orderContains(drink)
                        ? Image.asset('assets/coffee_icons/no_coffee.png')
                        : Image.asset(
                      'assets/coffee_icons/${drink.id}.png',
                      errorBuilder: (_, e, st) => Image.asset('assets/coffee_icons/no_coffee.png'),
                    ),
                    onTap: () {
                      widget.coffeeService.addCoffeeToOrder(drink);
                    },
                  );
                }).toList(),
              );
            });
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error loading coffee drinks'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _placeOrder,
        label: const Text('Place order ☕️'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
