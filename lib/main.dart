/// A simple Flutter app for ordering coffee (this is just a example starter app).
import 'package:flutter/material.dart';
import 'package:flutter_coffee/data/api.dart';
import 'package:flutter_coffee/data/service.dart';
import 'package:flutter_coffee/ui/order_placed.dart';
import 'package:flutter_coffee/ui/place_order.dart';
import 'package:flutter_coffee/ui/products.dart';
import 'package:flutter_coffee/ui/welcome.dart';


void main() {
  runApp(MyApp(coffeeService: CoffeeService(api: CoffeeAPI())));
}

class MyApp extends StatelessWidget {
  const MyApp({required this.coffeeService, super.key});

  final CoffeeService coffeeService;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.brown,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(coffeeService: coffeeService),
        '/product_selection': (context) => ProductSelection(coffeeService: coffeeService),
        '/order_confirmation': (context) => OrderConfirmationScreen(coffeeService: coffeeService),
        '/final_screen': (context) => FinalScreen(coffeeService: coffeeService),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$_counter ☕️', style: Theme.of(context).textTheme.headlineLarge),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _incrementCounter,
        label: const Text('Add ☕️'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
