// TODO: A data class representing a Coffee beverage. This class should be able to be created from JSON.
class CoffeeDrink {
  final String id;
  final String name;
  final String price;
  final String description;

  CoffeeDrink({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
  });

  factory CoffeeDrink.fromJson(Map<String, dynamic> json) {
    return CoffeeDrink(
      id: json['id'] as String,
      name: json['name'] as String,
      price: json['price'] as String,
      description: json['description'] as String,
    );
  }
}

// TODO: A data class representing a Coffee shop. This class should be able to be created from JSON.
class CoffeeShop {
  final String id;
  final String name;
  final String address;
  final String description;

  CoffeeShop({
    required this.id,
    required this.name,
    required this.address,
    required this.description,
  });

  factory CoffeeShop.fromJson(Map<String, dynamic> json) {
    return CoffeeShop(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      description: json['description'] as String,
    );
  }
}

/// TODO: A data class representing a Coffee order item, consisting of a CoffeeDrink and a quantity.
class CoffeeOrderItem {
  final CoffeeDrink coffee;
  final int quantity;

  CoffeeOrderItem({
    required this.coffee,
    required this.quantity,
  });
}

// TODO: A data class representing a Coffee order, consisting of list of CoffeeOrderItems and a CoffeeShop.
class CoffeeOrder {
  final List<CoffeeOrderItem> items;
  final CoffeeShop shop;

  CoffeeOrder({
    required this.items,
    required this.shop,
  });
}


// TODO: Mermaid diagram code for the relationships between the model classes above.
// classDiagram
//   CoffeeOrderItem "1" --> "1" Coffee
//   CoffeeOrder "1" --> "*" CoffeeOrderItem
//   CoffeeOrder "1" --> "1" CoffeeShop
// end

