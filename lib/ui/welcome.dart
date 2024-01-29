import 'package:flutter/material.dart';
import 'package:flutter_coffee/data/model.dart';
import 'package:flutter_coffee/data/service.dart';

// TODO: Description/Requirements
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({required this.coffeeService, super.key});

  final CoffeeService coffeeService;

  @override
  State<StatefulWidget> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  /// TODO: Hårdkoda denna i första läget / lättaste svårighetsgraden
  late Future<CoffeeShop> selectedShop;

  @override
  void initState() {
    super.initState();
    _findNearestCoffeeShop();
  }

  void _findNearestCoffeeShop() {
    selectedShop = widget.coffeeService.selectNearestCoffeeShop();
  }

  void _proceedToOrderCoffee() {
    Navigator.pushNamed(context, '/product_selection');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/background1.png',
            fit: BoxFit.cover,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 50.0),
                child: Text(
                  'Welcome to\nKaffiKrútur',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(color: Colors.black, offset: Offset(2, 2))],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.33,
                height: MediaQuery.of(context).size.width * 0.33,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(2, 2),
                      blurRadius: 25.0,
                    )
                  ],
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/logo1.png'),
                  ),
                ),
              ),

              // Wait for Future and show button that navigates to product selection screen when done. When loading,
              // show progress indicator. When error, show error and retry button. (Hit: nudge by typing "FutureBuilder")
              FutureBuilder<CoffeeShop>(
                future: selectedShop,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(children: [
                      Card(margin: const EdgeInsets.symmetric(horizontal: 32), color: Colors.white.withOpacity(0.75),
                        child: Padding(padding: const EdgeInsets.all(16.0), child:
                          Column(children: [
                            const Text(
                              'Your nearest coffee shop is',
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Order from: ${snapshot.data!.name}',
                              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '"${snapshot.data!.description}"',
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Location: ${snapshot.data!.address}',
                              style: const TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ElevatedButton(
                          onPressed: _proceedToOrderCoffee,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown.shade300,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              "Order coffee",
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
                      ),
                    ]);
                  } else if (snapshot.hasError) {
                    return Column(children: [
                      Card(
                        color: Colors.white.withOpacity(0.5),
                        child: Text('Error finding nearest coffee shop: ${snapshot.error}'),
                      ),
                      ElevatedButton(onPressed: _findNearestCoffeeShop, child: const Text('Retry')),
                    ]);
                  } else {
                    return Column(children: [
                      Card(
                        color: Colors.white.withOpacity(0.5),
                        child: const Text(
                          'Finding your nearest coffee shop...',
                          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const CircularProgressIndicator(),
                    ]);
                  }
                },
              ),

              // if (selectedShop == null) const CircularProgressIndicator(),
              // if (selectedShop != null) Padding(
              //   padding: const EdgeInsets.all(20.0),
              //   child: ElevatedButton(
              //     onPressed: () => Navigator.pushNamed(context, '/product_selection'),
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: Colors.brown.shade300,
              //     ),
              //     child: const Padding(
              //       padding: EdgeInsets.all(16.0),
              //       child: Text(
              //         "Order coffee",
              //         style: TextStyle(fontSize: 24),
              //       ),
              //     ),
              //   ),
              // ),

              const SizedBox(height: 16),
            ],
          ),
        ],
      ),
    );
  }
}
