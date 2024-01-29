import 'package:flutter/foundation.dart';
import 'package:flutter_coffee/data/api.dart';
import 'package:flutter_coffee/data/model.dart';


/// Create a service class that uses the CoffeeAPI (defined in api.dart)
/// and keeps the state of the user's coffee order (represented by class CoffeeOrder).
///
/// The CoffeeService should:
/// * make it possible to list the coffee beverages.
/// * make it possible to list the coffee shops.
/// * make it possible to add a coffee to the order.
/// * make it possible to remove a coffee from the order.
/// * make it possible to clear the order.
/// * make it possible to place the order.


/// OR - make it a ChangeNotifier?
/// * make it possible to observe changes to the CoffeeOrder state, using for instance a ValueNotifier.
class CoffeeService extends ChangeNotifier {
  CoffeeService({required this.api});

  final CoffeeAPI api;
  // final ValueNotifier<List<CoffeeDrink>> selectedDrinks = ValueNotifier([]);
  // final ValueNotifier<CoffeeShop?> selectedShop = ValueNotifier(null);
  List<CoffeeDrink> _selectedDrinks = [];
  CoffeeShop? _selectedShop;

  String lastOrderNumber = '';

  Future<List<CoffeeDrink>> listCoffeeDrinks() => api.listCoffeeDrinks();

  Future<CoffeeShop> selectNearestCoffeeShop() async {
    _selectedShop = await api.findNearestCoffeeShop();
    notifyListeners();
    return _selectedShop!;
  }

  CoffeeShop? get selectedCoffeeShop => _selectedShop;

  set selectedCoffeeShop(CoffeeShop? shop) {
    _selectedShop = shop;
    notifyListeners();
    // selectedShop.value = shop;
  }

  List<CoffeeDrink> get selectedDrinks => _selectedDrinks;

  String imagePathForCoffee(CoffeeDrink coffee) {
    return 'assets/images/${coffee.id}.png';
  }



  bool orderContains(CoffeeDrink coffee) {
    return selectedDrinks.contains(coffee);
  }

  void addCoffeeToOrder(CoffeeDrink coffee) {
    if (!orderContains(coffee)) {
      _selectedDrinks = [...selectedDrinks, coffee];
      notifyListeners();
    }
  }

  void removeCoffeeFromOrder(CoffeeDrink coffee) {
    _selectedDrinks = selectedDrinks.where((element) => element != coffee).toList();
    notifyListeners();
  }

  void clearOrder() {
    _selectedDrinks = [];
    _selectedShop = null;
    notifyListeners();
  }

  Future<String> placeOrder() async {
    if (_selectedShop == null) {
      return Future.error('No shop!');
    }
    lastOrderNumber = await api.orderCoffee(CoffeeOrder(
      items: _selectedDrinks.map((e) => CoffeeOrderItem(coffee: e, quantity: 1)).toList(),
      shop: _selectedShop!,
    ));
    return lastOrderNumber!;
  }
}


/*
Example prompts:

Could you implement the CoffeeService for me? Make sure you implement the requirements listed in the comments of
class CoffeeService and implement the contract of CoffeeAPI correctly.

Possible refinements:

* Could you fix the problem in addCoffeeToOrder with adding OrderItems to the order?

*/
