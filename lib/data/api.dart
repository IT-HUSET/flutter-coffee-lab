import 'dart:convert';
import 'dart:math';

import 'package:flutter_coffee/data/model.dart';

// TODO: A class implementing an API for Coffee beverages and listing
// coffee shops
class CoffeeAPI {
  List<CoffeeDrink> parseCoffeeDrinksFromJson(String jsonString) {
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => CoffeeDrink.fromJson(json)).toList();
  }

  // TODO: Implement a method for listing available coffee beverages. The
  // return type should be a Future with a list off Coffee objects.
  Future<List<CoffeeDrink>> listCoffeeDrinks() async {
    await Future.delayed(const Duration(seconds: 1));
    return parseCoffeeDrinksFromJson(coffeeDrinksJson);
  }

  List<CoffeeShop> parseCoffeeShopsFromJson(String jsonString) {
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => CoffeeShop.fromJson(json)).toList();
  }

  // TODO: Implement a method for getting the nearest coffee shop. The return type should
  // be a Future with a CoffeeShop object.
  Future<CoffeeShop> findNearestCoffeeShop() async {
    await Future.delayed(const Duration(seconds: 1));
    final coffeeShops = parseCoffeeShopsFromJson(coffeeShopsJson);
    return coffeeShops[Random().nextInt(coffeeShops.length)];
  }

  // TODO: Implement a method for ordering a List coffee beverage. The return
  // type be a Future containing a order ID.
  Future<String> orderCoffee(CoffeeOrder order) async {
    await Future.delayed(const Duration(seconds: 1));
    return Random().nextInt(999999).toString();
  }
}


// Mock data:


const coffeeShopsJson = '''
[
    {
        "id": "1",
        "name": "Nordic Brews",
        "description": "Simple, classy, gets that Icelandic vibe right.",
        "address": "Laugavegur 10, 101 Reykjavik"
    },
    {
        "id": "2",
        "name": "Frost & Foam",
        "description": "Kinda poetic, right? Captures that Icelandic chill and the smoothness of a perfect espresso.",
        "address": "Skólavörðustígur 22, 101 Reykjavik"
    },
    {
        "id": "3",
        "name": "Reykjavik Roasts",
        "description": "Keeping it local and proud. People love that.",
        "address": "Hverfisgata 64, 101 Reykjavik"
    },
    {
        "id": "4",
        "name": "Glacial Grinds",
        "description": "It's Iceland, glaciers are a big deal. Plus, it sounds super fresh.",
        "address": "Bankastræti 12, 101 Reykjavik"
    },
    {
        "id": "5",
        "name": "Huldufólk Brew",
        "description": "A little whimsical with that nod to Icelandic folklore. It's unique, like your bar's gonna be.",
        "address": "Austurstræti 9, 101 Reykjavik"
    }
]
''';


const coffeeDrinksJson = '''
[
  {
    "id": "1",
    "name": "Elf Whisper Latte",
    "price": "600 ISK",
    "description": "A smooth, magical blend that whispers Icelandic folklore with every sip. Maybe add a hint of local herbs or spices to make it truly stand out."
  },
  {
    "id": "2",
    "name": "Viking Mocha",
    "price": "720 ISK",
    "description": "Strong and bold, just like a Viking. Dark chocolate with a robust espresso, maybe even a dash of cinnamon or nutmeg to give it that extra edge."
  },
  {
    "id": "3",
    "name": "Aurora Borealis Americano",
    "price": "660 ISK",
    "description": "Light, luminous, and captivating, just like the Northern Lights. Keep it simple but elegant, maybe with a unique twist like a hint of lavender or mint."
  },
  {
    "id": "4",
    "name": "Glacier Frappé",
    "price": "540 ISK",
    "description": "A cool, refreshing drink that's as mesmerizing as a glacier. Think icy, creamy, with a touch of vanilla or white chocolate. Perfect for those milder Icelandic days."
  },
  {
    "id": "5",
    "name": "Saga Cappuccino",
    "price": "360 ISK",
    "description": "A classic with a twist, paying homage to the rich sagas of Iceland. Maybe add a sprinkle of local sea salt on top, for that storybook finish."
  }
]
''';
