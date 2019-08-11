import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Cart extends ChangeNotifier {
  Map<String, List<Map<String, dynamic>>> cart = {
    'RdzEbID4WdSW5so1XyO97bvbo3R2': [
      {
        'productId': '-Ll3bUD5pQu3GAXKlOrs',
        'quantity': 3,
      },
      {
        'productId': '-Ll4bm2UyhD91UA0HyK0',
        'quantity': 3,
      },
    ],
    'lv104c8kyTXPkqHDGZNb1P5XlTh2': [
      {
        'productId': '-LlEFGFfdumu43Xj3cpA',
        'quantity': 3,
      },
      {
        'productId': '-LlEJsoo-d5erEv94Fm7',
        'quantity': 2,
      },
    ],
  };


  
  // Constructor
  Cart(this.cart);

  int kuantiti;

  Cart.withPlaceholder();

  Cart.empty() {
    this.cart = Map<String, List<Map<String, dynamic>>>();
  }

  // Getter
  List<Map<String, dynamic>> getProductsBySeller(String sellerId) {
    return cart[sellerId];
  }

  int length() {
    int length = 0;
    cart.forEach((sellerId, productsList) {
      length += productsList.length;
    });
    return length;
  }

 void getTotalPrice(String sellerId, String productId ,double itemTotal) {
   
   double totalPrice = 0; 
    
  cart[sellerId].forEach((productMap){
    if(productId==productMap['productId']){
      totalPrice +=itemTotal;
    }
  });

  
print('THIS IS THE TOTAL PRICE  ' + totalPrice.toString());
   
    
    return ;
  }

  Map<String, dynamic> getProduct(String sellerId, String productId) {
    Map<String, dynamic> product;
    cart.forEach((sellerId, productsList) {
      productsList.forEach((productMap) {
        if (productMap.containsValue(productId)) {
          product = productMap;
        }
      });
    });
    return product;
  }

  double getItemTotal(String sellerId, String productId, int quantity){
   double itemTotal;
   

    cart[sellerId].forEach((productMap) {
      Firestore.instance
          .collection('product')
          .document(productId)
          .get()
          .then((ds) {
           itemTotal = quantity*ds.data['price'];
        print('THIS IS ITEM ' +productId+ ' TOTAL PRICE ' + itemTotal.toString());
        //print(itemTotal.toString());
       getTotalPrice(sellerId, productId, itemTotal);
      });
      
    
    });
    
      return itemTotal;
  }

  int getQuantity(String productId) {
    int quantity;
    String _sellerId;
    //double itemTotal;
    cart.forEach((sellerId, productsList) {
      for (Map<String, dynamic> productMap in productsList) {
        if (productMap.containsValue(productId))
          quantity = productMap['quantity'];
        
      }
      _sellerId = sellerId;  
    });
    getItemTotal(_sellerId, productId, quantity);
    print('THIS IS '+ productId+ ' QUANTITY ' + quantity.toString());
    //print('THIS IS ITEM TOTAL' + price.toString());
    return quantity;
  }

  void addProduct(String sellerId, String productId, [int quantity = 1]) {
    bool increment = false;
    if (cart.containsKey(sellerId)) {
      cart[sellerId].forEach((productMap) {
        if (productMap.containsValue(productId)) {
          increaseQuantity(productId, quantity);
          increment = true;
        }
      });
      if (!increment) {
        cart[sellerId].add({
          'productId': productId,
          'quantity': quantity,
        });
      }
    } else {
      cart[sellerId] = List<Map<String, dynamic>>();
      cart[sellerId].add({
        'productId': productId,
        'quantity': quantity,
      });
    }
  }

  void increaseQuantity(String productId, [int increment = 1]) {
    cart.forEach((sellerId, productsList) {
      productsList.forEach((productMap) {
        if (productMap.containsValue(productId)) {
          productMap['quantity'] += increment;

          print(productMap['quantity']);
          return;
        }
      });
    });
  }

  void decreaseQuantity(String productId, [int decrement = 1]) {
    cart.forEach((sellerId, productsList) {
      productsList.forEach((productMap) {
        if (productMap.containsValue(productId)) {
          productMap['quantity'] -= decrement;
          print(productMap['quantity']);
          return;

        }
        
      });
      
    });
  }

  void deleteProduct(String productId) {
    cart.forEach((sellerId, productsList) {
      for (Map<String, dynamic> productMap in productsList) {
        int index = productsList
            .indexWhere((productMap) => (productMap.containsValue(productId)));
        if (index != -1) {
          productsList.removeAt(index);
          break;
        }
      }
    });
  }

  @override
  String toString() {
    return JsonEncoder.withIndent('  ').convert(cart);
  }
}