import 'package:flutter/material.dart';

void main() {
  runApp(FoodOrderingSystem());
}

class FoodOrderingSystem extends StatefulWidget {
  @override
  _FoodOrderingSystemState createState() => _FoodOrderingSystemState();
}

class _FoodOrderingSystemState extends State<FoodOrderingSystem> {
  Map<String, double> menu = {
    'Burger': 2.99,
    'Pizza': 3.99,
    'Fries': 1.99,
  };

  late String selectedMenuItem;
  int quantity = 1;

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
    });
  }

  void resetOrder() {
    setState(() {
      selectedMenuItem = null;
      quantity = 1;
    });
  }

  double getTotalPrice() {
    if (selectedMenuItem != null) {
      return menu[selectedMenuItem] * quantity;
    }
    return 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Ordering System',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Food Ordering System'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButton(
                hint: Text('Select an item'),
                value: selectedMenuItem,
                items: menu.keys.map((String menuItem) {
                  return DropdownMenuItem(
                    value: menuItem,
                    child: Text(menuItem),
                  );
                }).toList(),
                onChanged: (String value) {
                  setState(() => selectedMenuItem = value);
                },
              ),
              SizedBox(height: 16.0),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: decrementQuantity,
                  ),
                  Text(quantity.toString()),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: incrementQuantity,
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Text('Total: \$${getTotalPrice().toStringAsFixed(2)}'),
              SizedBox(height: 16.0),
              ElevatedButton(
                child: Text('Place Order'),
                onPressed: () {
                  if (selectedMenuItem != null) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Order Placed'),
                          content: Text(
                              'Your order for $quantity $selectedMenuItem(s) has been placed.'),
                          actions: [
                            TextButton(
                              child: Text('OK'),
                              onPressed: resetOrder,
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
